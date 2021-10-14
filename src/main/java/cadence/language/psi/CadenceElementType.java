package cadence.language.psi;

import cadence.language.config.CadenceLanguage;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class CadenceElementType extends IElementType {

    public CadenceElementType(@NotNull @NonNls String debugName) {
        super(debugName, CadenceLanguage.INSTANCE);
    }

}