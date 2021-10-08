package cadence.language;

import cadence.language.lsp.CadenceLanguageServerDefinition;
import com.intellij.openapi.application.PreloadingActivity;
import com.intellij.openapi.progress.ProgressIndicator;
import org.wso2.lsp4intellij.IntellijLanguageClient;

public class CadenceLanguageServerPreloadingActivity extends PreloadingActivity {
    public void preload(ProgressIndicator indicator) {
        System.out.println("Starting language server with command: ");
        IntellijLanguageClient.addServerDefinition(new CadenceLanguageServerDefinition("cdc", new String[]{"flow", "cadence", "language-server"}));
    }
}
