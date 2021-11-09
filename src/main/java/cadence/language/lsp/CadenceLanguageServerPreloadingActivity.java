package cadence.language.lsp;

import cadence.language.settings.CadenceSettingsState;
import com.intellij.openapi.application.PreloadingActivity;
import com.intellij.openapi.diagnostic.Logger;
import com.intellij.openapi.progress.ProgressIndicator;
import com.intellij.openapi.util.text.StringUtil;
import org.wso2.lsp4intellij.IntellijLanguageClient;

public class CadenceLanguageServerPreloadingActivity extends PreloadingActivity {
    private static final Logger log = Logger.getInstance(CadenceLanguageServerPreloadingActivity.class);

    public void preload(ProgressIndicator indicator) {
        String flowCommand = CadenceSettingsState.getInstance().flowPath;
        if (StringUtil.isEmptyOrSpaces(flowCommand)) {
            flowCommand = "flow";
        }
        log.info("Starting language server with command: " + flowCommand + " cadence language-server");
        IntellijLanguageClient.addServerDefinition(new CadenceLanguageServerDefinition("cdc", new String[]{flowCommand, "cadence", "language-server"}));
    }
}
