package cadence.language.psi;

import cadence.language.config.CadenceFileType;
import cadence.language.config.CadenceLanguage;
import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.jetbrains.annotations.NotNull;

public class CadenceFile extends PsiFileBase {

    public CadenceFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, CadenceLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public FileType getFileType() {
        return CadenceFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return "Cadence File";
    }

}
