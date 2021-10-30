package cadence.language.settings;

import com.intellij.openapi.options.Configurable;
import org.jetbrains.annotations.Nls;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

/**
 * Provides controller functionality for application settings.
 */
public class CadenceSettingsConfigurable implements Configurable {

    private CadenceSettingsComponent mySettingsComponent;

    // A default constructor with no arguments is required because this implementation
    // is registered as an applicationConfigurable EP

    @Nls(capitalization = Nls.Capitalization.Title)
    @Override
    public String getDisplayName() {
        return "Cadence settings";
    }

    @Override
    public JComponent getPreferredFocusedComponent() {
        return mySettingsComponent.getPreferredFocusedComponent();
    }

    @Nullable
    @Override
    public JComponent createComponent() {
        mySettingsComponent = new CadenceSettingsComponent();
        return mySettingsComponent.getPanel();
    }

    @Override
    public boolean isModified() {
        CadenceSettingsState settings = CadenceSettingsState.getInstance();
        boolean modified = !mySettingsComponent.getActiveAccountNameText().equals(settings.activeAccountName);
        modified |= mySettingsComponent.getActiveAccountAddressText() != settings.activeAccountAddress;
        modified |= mySettingsComponent.getConfigPathText() != settings.configPath;
        modified |= mySettingsComponent.getEmulatorState() != settings.emulatorState;
        modified |= mySettingsComponent.getDebugLogFileStdInText() != settings.debugLogFileStdIn;
        modified |= mySettingsComponent.getDebugLogFileStdOutText() != settings.debugLogFileStdOut;
        modified |= mySettingsComponent.isDebugLspMessagesActive() != settings.debugLspMessagesActive;
        return modified;
    }

    @Override
    public void apply() {
        CadenceSettingsState settings = CadenceSettingsState.getInstance();
        settings.activeAccountName = mySettingsComponent.getActiveAccountNameText();
        settings.activeAccountAddress = mySettingsComponent.getActiveAccountAddressText();
        settings.configPath = mySettingsComponent.getConfigPathText();
        settings.emulatorState = mySettingsComponent.getEmulatorState();
        settings.debugLogFileStdIn = mySettingsComponent.getDebugLogFileStdInText();
        settings.debugLogFileStdOut = mySettingsComponent.getDebugLogFileStdOutText();
        settings.debugLspMessagesActive = mySettingsComponent.isDebugLspMessagesActive();
    }

    @Override
    public void reset() {
        CadenceSettingsState settings = CadenceSettingsState.getInstance();
        mySettingsComponent.setActiveAccountNameText(settings.activeAccountName);
        mySettingsComponent.setActiveAccountAddressText(settings.activeAccountAddress);
        mySettingsComponent.setConfigPathText(settings.configPath);
        mySettingsComponent.setEmulatorState(settings.emulatorState);
        mySettingsComponent.setDebugLogFileStdInText(settings.debugLogFileStdIn);
        mySettingsComponent.setDebugLogFileStdOutText(settings.debugLogFileStdOut);
        mySettingsComponent.setDebugLspMessagesActive(settings.debugLspMessagesActive);
    }

    @Override
    public void disposeUIResources() {
        mySettingsComponent = null;
    }

}