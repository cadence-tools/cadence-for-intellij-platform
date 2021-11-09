package cadence.language.settings;

import com.intellij.openapi.application.ApplicationManager;
import com.intellij.openapi.components.PersistentStateComponent;
import com.intellij.openapi.components.State;
import com.intellij.openapi.components.Storage;
import com.intellij.util.xmlb.XmlSerializerUtil;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

/**
 * Supports storing the application settings in a persistent way.
 * The {@link State} and {@link Storage} annotations define the name of the data and the file name where
 * these persistent application settings are stored.
 */
@State(
    name = "cadence.language.CadenceSettingsState",
    storages = @Storage("CadenceSettingsPlugin.xml")
)
public class CadenceSettingsState implements PersistentStateComponent<CadenceSettingsState> {

    public int emulatorState = 2;
    public String activeAccountName = "emulator-account";
    public String activeAccountAddress = "f8d6e0586b0a20c7";
    public String flowPath = "";
    public String configPath = "/usr/local/bin/flow.json";
    public Boolean debugLspMessagesActive = false;
    public String debugLogFileStdIn = "/tmp/cadence-stdin.log";
    public String debugLogFileStdOut = "/tmp/cadence-stdout.log";

    public static CadenceSettingsState getInstance() {
        return ApplicationManager.getApplication().getService(CadenceSettingsState.class);
    }

    @Nullable
    @Override
    public CadenceSettingsState getState() {
        return this;
    }

    @Override
    public void loadState(@NotNull CadenceSettingsState state) {
        XmlSerializerUtil.copyBean(state, this);
    }

}