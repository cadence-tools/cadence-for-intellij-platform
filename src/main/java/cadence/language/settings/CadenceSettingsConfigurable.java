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
        return "Cadence LSP settings";
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
        boolean modified = false;
        modified |= !mySettingsComponent.getFlowPathText().equals(settings.flowPath);
        modified |= !mySettingsComponent.getConfigPathText().equals(settings.configPath);
        modified |= !mySettingsComponent.getActiveAccountNameText().equals(settings.activeAccountName);
        modified |= !mySettingsComponent.getActiveAccountAddressText().equals(settings.activeAccountAddress);
        modified |= !(mySettingsComponent.getEmulatorState() == settings.emulatorState);
        modified |= !mySettingsComponent.getDebugLogFileStdInText().equals(settings.debugLogFileStdIn);
        modified |= !mySettingsComponent.getDebugLogFileStdOutText().equals(settings.debugLogFileStdOut);
        modified |= !(mySettingsComponent.isDebugLspMessagesActive() == settings.debugLspMessagesActive);
        return modified;
    }

    @Override
    public void apply() {
        CadenceSettingsState settings = CadenceSettingsState.getInstance();
        settings.flowPath = mySettingsComponent.getFlowPathText();
        settings.configPath = mySettingsComponent.getConfigPathText();
        settings.activeAccountName = mySettingsComponent.getActiveAccountNameText();
        settings.activeAccountAddress = mySettingsComponent.getActiveAccountAddressText();
        settings.emulatorState = mySettingsComponent.getEmulatorState();
        settings.debugLogFileStdIn = mySettingsComponent.getDebugLogFileStdInText();
        settings.debugLogFileStdOut = mySettingsComponent.getDebugLogFileStdOutText();
        settings.debugLspMessagesActive = mySettingsComponent.isDebugLspMessagesActive();
    }

    @Override
    public void reset() {
        CadenceSettingsState settings = CadenceSettingsState.getInstance();
        mySettingsComponent.setFlowPathText(settings.flowPath);
        mySettingsComponent.setConfigPathText(settings.configPath);
        mySettingsComponent.setActiveAccountNameText(settings.activeAccountName);
        mySettingsComponent.setActiveAccountAddressText(settings.activeAccountAddress);
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