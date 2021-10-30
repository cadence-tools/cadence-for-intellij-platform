package cadence.language.lsp;

    import com.intellij.openapi.diagnostic.Logger;
    import org.apache.commons.io.input.TeeInputStream;
    import org.bouncycastle.util.io.TeeOutputStream;
    import org.wso2.lsp4intellij.client.connection.StreamConnectionProvider;

    import java.io.IOException;
    import java.io.InputStream;
    import java.io.OutputStream;
    import java.nio.charset.StandardCharsets;
    import java.time.ZonedDateTime;
    import java.time.format.DateTimeFormatter;

/**
 * Stream connection provider that optionally logs input and output
 * to output streams.
 */
public class DebugStreamConnectionProvider implements StreamConnectionProvider {

    private static final Logger log = Logger.getInstance(DebugStreamConnectionProvider.class);
    private final StreamConnectionProvider realConnectionProvider;
    private final OutputStream stdinDebugLogStream;
    private final OutputStream stdoutDebugLogStream;
    private InputStream inputStream;
    private OutputStream outputStream;

    /**
     * @param realConnectionProvider - Original StreamConnectionProvider from the RawCommandServerDefinition
     * @param stdinDebugLogStream    - The output stream to echo stdin to
     * @param stdoutDebugLogStream   - The output stream to echo stdout to
     */
    public DebugStreamConnectionProvider(StreamConnectionProvider realConnectionProvider,
                                         OutputStream stdinDebugLogStream,
                                         OutputStream stdoutDebugLogStream) {
        this.realConnectionProvider = realConnectionProvider;
        this.stdinDebugLogStream = stdinDebugLogStream;
        this.stdoutDebugLogStream = stdoutDebugLogStream;
        logDebug("created TeeStreamConnectionProvider instance");

    }

    @Override
    public void start() throws IOException {
        realConnectionProvider.start();

        logDebug("DebugStreamConnectionProvider.start()");

        inputStream = new TeeInputStream(realConnectionProvider.getInputStream(), stdoutDebugLogStream);
        outputStream = new TeeOutputStream(realConnectionProvider.getOutputStream(), stdinDebugLogStream);
    }

    @Override
    public InputStream getInputStream() {
        return inputStream;
    }

    @Override
    public OutputStream getOutputStream() {
        return outputStream;
    }

    @Override
    public void stop() {
        log.debug("DebugStreamConnectionProvider.stop()");
        realConnectionProvider.stop();
        inputStream = null;
        outputStream = null;
    }

    /**
     * Write a message to the log files
     *
     * @param logMessage - the message to log to both log files
     */
    public void logDebug(String logMessage) {
        try {
            var logBytes = String.format("%s%s: " + logMessage + "%n", "LSP-LOG",
                    ZonedDateTime.now().format(DateTimeFormatter.ofPattern("MM/dd/yyyy hh:mm:ss a")))
                .getBytes(StandardCharsets.UTF_8);
            this.stdoutDebugLogStream.write(logBytes);
            this.stdinDebugLogStream.write(logBytes);
        } catch (IOException e) {
            log.error("Couldn't log debug message ", e);
        }
    }
}