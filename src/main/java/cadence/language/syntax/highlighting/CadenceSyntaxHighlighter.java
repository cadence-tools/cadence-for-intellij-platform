package cadence.language.syntax.highlighting;

import cadence.language.CadenceLexerAdapter;
import cadence.language.psi.CadenceTypes;
import com.intellij.lexer.Lexer;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.editor.HighlighterColors;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
import com.intellij.psi.TokenType;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;

import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;

public class CadenceSyntaxHighlighter extends SyntaxHighlighterBase {

    public static final TextAttributesKey SEPARATOR =
        createTextAttributesKey("CADENCE_SEPARATOR", DefaultLanguageHighlighterColors.OPERATION_SIGN);
    public static final TextAttributesKey OPERATOR =
        createTextAttributesKey("CADENCE_OPERATOR", DefaultLanguageHighlighterColors.OPERATION_SIGN);
    public static final TextAttributesKey KEYWORD =
        createTextAttributesKey("CADENCE_KEYWORD", DefaultLanguageHighlighterColors.KEYWORD);
    public static final TextAttributesKey STRING_VALUE =
        createTextAttributesKey("CADENCE_STRING_VALUE", DefaultLanguageHighlighterColors.STRING);
    public static final TextAttributesKey STRING_ESCAPE_SEQUENCE =
        createTextAttributesKey("CADENCE_STRING_ESCAPE_SEQUENCE", DefaultLanguageHighlighterColors.VALID_STRING_ESCAPE);
    public static final TextAttributesKey NUMERIC_VALUE =
        createTextAttributesKey("CADENCE_NUMERIC_VALUE", DefaultLanguageHighlighterColors.NUMBER);
    public static final TextAttributesKey DEFINITION =
        createTextAttributesKey("CADENCE_DEFINITION", DefaultLanguageHighlighterColors.CONSTANT); //TODO perhaps better color
    public static final TextAttributesKey FUNCTION_NAME =
        createTextAttributesKey("CADENCE_FUNCTION_NAME", DefaultLanguageHighlighterColors.INSTANCE_METHOD);
    public static final TextAttributesKey FUNCTION_PARAMETER =
        createTextAttributesKey("CADENCE_FUNCTION_PARAMETER", DefaultLanguageHighlighterColors.INSTANCE_METHOD); //TODO should it be same as function?
    public static final TextAttributesKey TYPE =
        createTextAttributesKey("CADENCE_TYPE", DefaultLanguageHighlighterColors.CLASS_REFERENCE);
    public static final TextAttributesKey SIMPLE_COMMENT =
        createTextAttributesKey("CADENCE_SIMPLE_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
    public static final TextAttributesKey DOCUMENTATION_COMMENT =
        createTextAttributesKey("CADENCE_DOC_COMMENT", DefaultLanguageHighlighterColors.DOC_COMMENT);
    public static final TextAttributesKey BAD_CHARACTER =
        createTextAttributesKey("CADENCE_BAD_CHARACTER", HighlighterColors.BAD_CHARACTER);
    public static final TextAttributesKey IDENTIFIER =
        createTextAttributesKey("CADENCE_IDENTIFIER", DefaultLanguageHighlighterColors.LABEL);




    private static final TextAttributesKey[] BAD_CHAR_KEYS = new TextAttributesKey[]{BAD_CHARACTER};
    private static final TextAttributesKey[] SEPARATOR_KEYS = new TextAttributesKey[]{SEPARATOR};
    private static final TextAttributesKey[] OPEPARATOR_KEYS = new TextAttributesKey[]{OPERATOR};
    private static final TextAttributesKey[] KEY_KEYS = new TextAttributesKey[]{KEYWORD};
    private static final TextAttributesKey[] STRING_VALUE_KEYS = new TextAttributesKey[]{STRING_VALUE};
    private static final TextAttributesKey[] STRING_ESCAPE_SEQUENCE_KEYS = new TextAttributesKey[]{STRING_ESCAPE_SEQUENCE};
    private static final TextAttributesKey[] NUMERIC_VALUE_KEYS = new TextAttributesKey[]{NUMERIC_VALUE};
    private static final TextAttributesKey[] DEFINITION_KEYS = new TextAttributesKey[]{DEFINITION};
    private static final TextAttributesKey[] FUNCTION_NAME_KEYS = new TextAttributesKey[]{FUNCTION_NAME};
    private static final TextAttributesKey[] FUNCTION_PARAMETER_KEYS = new TextAttributesKey[]{FUNCTION_PARAMETER};
    private static final TextAttributesKey[] TYPE_KEYS = new TextAttributesKey[]{TYPE};
    private static final TextAttributesKey[] SIMPLE_COMMENT_KEYS = new TextAttributesKey[]{SIMPLE_COMMENT};
    private static final TextAttributesKey[] DOCUMENTATION_COMMENT_KEYS = new TextAttributesKey[]{DOCUMENTATION_COMMENT};
    private static final TextAttributesKey[] IDENTIFIER_KEYS = new TextAttributesKey[]{IDENTIFIER};
    private static final TextAttributesKey[] EMPTY_KEYS = new TextAttributesKey[0];

    @NotNull
    @Override
    public Lexer getHighlightingLexer() {
        return new CadenceLexerAdapter();
    }

    @NotNull
    @Override
    public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {
        if (tokenType.equals(CadenceTypes.SIMPLE_COMMENT)) {
            return SIMPLE_COMMENT_KEYS;
        } else if (tokenType.equals(CadenceTypes.DOCUMENTATION_COMMENT)) {
            return DOCUMENTATION_COMMENT_KEYS;
        } else if (tokenType.equals(CadenceTypes.SEPARATOR)) {
            return SEPARATOR_KEYS;
        } else if (tokenType.equals(CadenceTypes.OPERATOR)) {
            return OPEPARATOR_KEYS;
        } else if (tokenType.equals(CadenceTypes.KEYWORD)) {
            return KEY_KEYS;
        } else if (tokenType.equals(CadenceTypes.STRING_VALUE)) {
            return STRING_VALUE_KEYS;
        } else if (tokenType.equals(CadenceTypes.STRING_ESCAPE_SEQUENCE)) {
            return STRING_ESCAPE_SEQUENCE_KEYS;
        } else if (tokenType.equals(CadenceTypes.NUMERIC_VALUE)) {
            return NUMERIC_VALUE_KEYS;
        } else if (tokenType.equals(CadenceTypes.DEFINITION)) {
            return DEFINITION_KEYS;
        } else if (tokenType.equals(CadenceTypes.FUNCTION_NAME)) {
            return FUNCTION_NAME_KEYS;
        } else if (tokenType.equals(CadenceTypes.FUNCTION_PARAMETER)) {
            return FUNCTION_PARAMETER_KEYS;
        } else if (tokenType.equals(CadenceTypes.TYPE)) {
            return TYPE_KEYS;
        } else if (tokenType.equals(CadenceTypes.IDENTIFIER)) {
            return IDENTIFIER_KEYS;
        } else if (tokenType.equals(TokenType.BAD_CHARACTER)) {
            return BAD_CHAR_KEYS;
        } else {
            return EMPTY_KEYS;
        }
    }

}

