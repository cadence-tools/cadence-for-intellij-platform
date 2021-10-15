package cadence.language;

import cadence.language.grammar.CadenceLexer;
import com.intellij.lexer.FlexAdapter;


public class CadenceLexerAdapter extends FlexAdapter {

    public CadenceLexerAdapter() {
        super(new CadenceLexer(null));
    }

}