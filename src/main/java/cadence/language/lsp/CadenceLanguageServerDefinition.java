package cadence.language.lsp;

    import cadence.language.DebugStreamConnectionProvider;
    import com.intellij.openapi.diagnostic.Logger;
    import com.intellij.util.ExceptionUtil;
    import org.wso2.lsp4intellij.client.connection.StreamConnectionProvider;
    import org.wso2.lsp4intellij.client.languageserver.serverdefinition.LanguageServerDefinition;
    import org.wso2.lsp4intellij.client.languageserver.serverdefinition.RawCommandServerDefinition;

    import java.io.File;
    import java.io.FileOutputStream;
    import java.io.IOException;
    import java.io.OutputStream;
    import java.net.URI;
    import java.net.URL;
    import java.util.Arrays;
    import java.util.Enumeration;
    import java.util.Map;


public class CadenceLanguageServerDefinition extends LanguageServerDefinition {

    private static final Logger log = Logger.getInstance(CadenceLanguageServerDefinition.class);

    private static final String LOG_PREFIX = "LSP-LOG";
    private static final String DEBUG_STDIN_FILE_PATH = "/home/nkotsola/workspaces/logs/cadence-lsp.stdin.log";
    private static final String DEBUG_STDOUT_FILE_PATH = "/home/nkotsola/workspaces/logs/cadence-lsp.stdout.log";
    private static final Boolean DEBUG_LOGGING = true;
    protected String[] command;
    private RawCommandServerDefinition rawCommandServerDefinition = null;
    private OutputStream debugStdinStream;
    private OutputStream debugStdoutStream;

    private DebugStreamConnectionProvider teeStreamConnectionProvider;
    /**
     * Helper class used when debug logging is turned off to not write to any log files
     */
    private static class DummyOutputStream extends OutputStream {
        @Override
        public void write(int b) throws IOException {
        }
    }

    /**
     * Creates new instance with the given language id which is different from the file extension.
     *
     * @param ext         The extension
     * @param languageIds The language server ids mapping to extension(s).
     * @param command     The command to run
     */
    @SuppressWarnings("WeakerAccess")
    public CadenceLanguageServerDefinition(String extension, String[] command) {
        this.ext = extension;
        this.command = command;
        this.languageIds = Map.of();

//        String flowPath = getResourcePath(flowCliRelativePath);
//        if (flowPath == null) {
//            log.error(LOG_PREFIX + "Could not find " + flowCliRelativePath + " which should have been bundled in the plugin.");
//            return;
//        }
//
//        System.out.println("Flowpath:" + flowPath);
      //  this.command = new String[]{"flow"};
        enableDebugLogging();
        rawCommandServerDefinition = new RawCommandServerDefinition(this.ext, this.command);
    }

    private class InitializationOption {
        public int emulatorState = 0;
        public String activeAccountName = "emulator-account";
        public String activeAccountAddress = "f8d6e0586b0a20c7";
        public String configPath = "/home/nkotsola/workspaces/vscode-cadence/src/test/fixtures/workspace/flow.json";

    }
    @Override
    public Object getInitializationOptions(URI uri) {
      //  return "{\"emulatorState\":0,\"activeAccountName\":\"emulator-account\",\"activeAccountAddress\":\"f8d6e0586b0a20c7\",\"configPath\":\"/home/nkotsola/workspaces/vscode-cadence/src/test/fixtures/workspace/flow.json\"}";
        return new InitializationOption();
    }


    private void enableDebugLogging() {
        if (DEBUG_LOGGING) {
            try {
                File debugStdinFile = new File(DEBUG_STDIN_FILE_PATH);
                debugStdinStream = new FileOutputStream(debugStdinFile, true);
                File debugStdoutFile = new File(DEBUG_STDOUT_FILE_PATH);
                debugStdoutStream = new FileOutputStream(debugStdoutFile, true);
            } catch (IOException e) {
                log.error("LSP-LOG" + "Unable to open debug logging files.", e);
            }
        } else {
            debugStdinStream = new DummyOutputStream();
            debugStdoutStream = new DummyOutputStream();
        }

    }

    public String toString() {
        return "CadenceLanguageServerDefinition : " + String.join(" ", command);
    }

    @Override
    public StreamConnectionProvider createConnectionProvider(String workingDir) {
        var realStreamProvider = rawCommandServerDefinition.createConnectionProvider(workingDir);
        teeStreamConnectionProvider = new DebugStreamConnectionProvider(realStreamProvider, debugStdinStream, debugStdoutStream);
        return teeStreamConnectionProvider;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof CadenceLanguageServerDefinition) {
            CadenceLanguageServerDefinition commandsDef = (CadenceLanguageServerDefinition) obj;
            return ext.equals(commandsDef.ext) && Arrays.equals(command, commandsDef.command);
        }
        return false;
    }

    @Override
    public int hashCode() {
        return ext.hashCode() + 3 * Arrays.hashCode(command);
    }

    public void logDebug(String logMessage){
        if (teeStreamConnectionProvider!=null){
            teeStreamConnectionProvider.logDebug(logMessage);
        }
    }
    private String getResourcePath(String relativePath) {
        try {
            ClassLoader classLoader = getClass().getClassLoader();
            Enumeration<URL> allResources = classLoader.getResources("");
            while (allResources.hasMoreElements()) {
                URL url = allResources.nextElement();
                log.debug(LOG_PREFIX + "resource found: " + url.toString());
            }
            URL resourceUrl = classLoader.getResource(relativePath);
            if (resourceUrl == null) {
                return null;
            }
            log.info(LOG_PREFIX + "Found requested resource: " + resourceUrl.getFile());
            return resourceUrl.getFile();
        } catch (IOException e) {
            log.warn(LOG_PREFIX + "Failed to read resources: " + e.getMessage() + ExceptionUtil.getThrowableText(e));
            return null;
        }
    }
}
