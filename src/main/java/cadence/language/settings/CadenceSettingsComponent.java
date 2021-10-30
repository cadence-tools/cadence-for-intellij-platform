package cadence.language.settings;

import cadence.language.lsp.EmulatorState;
import com.intellij.openapi.ui.ComboBox;
import com.intellij.ui.components.JBCheckBox;
import com.intellij.ui.components.JBLabel;
import com.intellij.ui.components.JBTextField;
import com.intellij.util.ui.FormBuilder;

import javax.swing.*;

import static cadence.language.lsp.EmulatorState.STARTED;
import static cadence.language.lsp.EmulatorState.STARTING;
import static cadence.language.lsp.EmulatorState.STOPPED;

/**
 * Supports creating and managing a {@link JPanel} for the Settings Dialog.
 */

public class CadenceSettingsComponent {

    private final EmulatorState[] emulatorStates = { STOPPED, STARTING, STARTED};

    private final JPanel myMainPanel;
    private final JBTextField activeAccountName = new JBTextField();
    private final JBTextField activeAccountAddress = new JBTextField();
    private final JBTextField configPath = new JBTextField();
    private final JComboBox<EmulatorState> emulatorState = new ComboBox<>(emulatorStates);
    private final JBCheckBox debugLspMessagesActive = new JBCheckBox();
    private final JBTextField debugLogFileStdIn = new JBTextField();
    private final JBTextField debugLogFileStdOut = new JBTextField();

    private final JBCheckBox myIdeaUserStatus = new JBCheckBox("Do you use IntelliJ IDEA? ");

    public CadenceSettingsComponent() {
        myMainPanel = FormBuilder.createFormBuilder()
            .addLabeledComponent(new JBLabel("Active Account Name: "), activeAccountName, 1, false)
            .addComponent(activeAccountName, 1)
            .addLabeledComponent(new JBLabel("Active Account Address: "), activeAccountAddress, 2, false)
            .addComponent(activeAccountAddress, 2)
            .addLabeledComponent(new JBLabel("Config path (path of flow.json): "), configPath, 3, false)
            .addComponent(configPath, 3)
            .addLabeledComponent(new JBLabel("Log Language Server Protocol Messages "), emulatorState, 4, false)
            .addComponent(debugLspMessagesActive, 4)
            .addLabeledComponent(new JBLabel("Log file for StdIn messages: "), emulatorState, 5, false)
            .addComponent(debugLogFileStdIn, 5)
            .addLabeledComponent(new JBLabel("Log file for StdOut messages: "), emulatorState, 6, false)
            .addComponent(debugLogFileStdOut, 6)
            .addLabeledComponent(new JBLabel("Emulator state: "), emulatorState, 7, false)
            .addComponent(emulatorState, 7)
            .addComponentFillVertically(new JPanel(), 0)
            .getPanel();

    }

    public JPanel getPanel() {
        return myMainPanel;
    }

    public JComponent getPreferredFocusedComponent() {
        return activeAccountName;
    }

    public String getActiveAccountNameText() {
        return activeAccountName.getText();
    }

    public String getActiveAccountAddressText() {
        return activeAccountAddress.getText();
    }

    public String getConfigPathText() {
        return configPath.getText();
    }

    public int getEmulatorState() {
        return ((EmulatorState) emulatorState.getSelectedItem()).ordinal();
    }

    public String getDebugLogFileStdInText() {
        return debugLogFileStdIn.getText();
    }

    public String getDebugLogFileStdOutText() {
        return debugLogFileStdOut.getText();
    }

    public boolean isDebugLspMessagesActive() {
        return debugLspMessagesActive.isSelected();
    }

    public void setActiveAccountNameText(String activeAccountNameText) {
        activeAccountName.setText(activeAccountNameText);
    }

    public void setActiveAccountAddressText(String activeAccountAddressText) {
        activeAccountAddress.setText(activeAccountAddressText);
    }

    public void setConfigPathText(String configPathText) {
        configPath.setText(configPathText);
    }

    public void setEmulatorState(int emulatorStateInt) {
        emulatorState.setSelectedItem(EmulatorState.values()[emulatorStateInt]);
    }

    public void setDebugLogFileStdInText(String debugLogFileStdInText) {
        debugLogFileStdIn.setText(debugLogFileStdInText);
    }

    public void setDebugLogFileStdOutText(String debugLogFileStdOutText) {
        debugLogFileStdOut.setText(debugLogFileStdOutText);
    }

    public void setDebugLspMessagesActive(boolean debugLspMessagesActiveValue) {
        debugLspMessagesActive.setSelected(debugLspMessagesActiveValue);
    }

}
