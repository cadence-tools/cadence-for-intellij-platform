package cadence.language.psi;

import cadence.language.CadenceLanguage;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class CadenceTokenType extends IElementType {
    public CadenceTokenType(@NotNull @NonNls String debugName) {
        super(debugName, CadenceLanguage.INSTANCE);
    }

    @Override
    public String toString() {
        return "CadenceTokenType." + super.toString();
    }
}
