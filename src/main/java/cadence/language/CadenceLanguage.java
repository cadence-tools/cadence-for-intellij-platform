package cadence.language;

import com.intellij.lang.Language;

public class CadenceLanguage extends Language {

    public static final CadenceLanguage INSTANCE = new CadenceLanguage();

    private CadenceLanguage() {
        super("Cadence");
    }

}
