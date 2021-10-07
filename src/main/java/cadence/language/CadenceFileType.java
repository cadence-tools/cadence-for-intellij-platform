package cadence.language;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class CadenceFileType extends LanguageFileType {
    public static final CadenceFileType INSTANCE = new CadenceFileType();

    private CadenceFileType() {
        super(CadenceLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public String getName() {
        return "Cadence File";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "Cadence language file";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "cdc";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return CadenceIcon.FILE;
    }
}
