package cadence.language;

import com.intellij.lexer.FlexAdapter;

public class CadenceLexerAdapter extends FlexAdapter {

    public CadenceLexerAdapter() {
        super(new CadenceLexer(null));
    }

}