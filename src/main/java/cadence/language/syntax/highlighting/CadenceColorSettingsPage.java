package cadence.language.syntax.highlighting;

import cadence.language.config.CadenceIcon;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighter;
import com.intellij.openapi.options.colors.AttributesDescriptor;
import com.intellij.openapi.options.colors.ColorDescriptor;
import com.intellij.openapi.options.colors.ColorSettingsPage;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Map;

public class CadenceColorSettingsPage implements ColorSettingsPage {

    private static final AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[]{
        new AttributesDescriptor("Separator", CadenceSyntaxHighlighter.SEPARATOR),
        new AttributesDescriptor("Operator", CadenceSyntaxHighlighter.OPERATOR),
        new AttributesDescriptor("Keyword", CadenceSyntaxHighlighter.KEYWORD),
        new AttributesDescriptor("String", CadenceSyntaxHighlighter.STRING_VALUE),
        new AttributesDescriptor("String escape sequence", CadenceSyntaxHighlighter.STRING_ESCAPE_SEQUENCE),
        new AttributesDescriptor("Number", CadenceSyntaxHighlighter.NUMERIC_VALUE),
        new AttributesDescriptor("Definition", CadenceSyntaxHighlighter.DEFINITION),
        new AttributesDescriptor("Function Name", CadenceSyntaxHighlighter.FUNCTION_NAME),
        new AttributesDescriptor("Function Parameter", CadenceSyntaxHighlighter.FUNCTION_PARAMETER),
        new AttributesDescriptor("Type", CadenceSyntaxHighlighter.TYPE),
        new AttributesDescriptor("Comment", CadenceSyntaxHighlighter.SIMPLE_COMMENT),
        new AttributesDescriptor("DocComment", CadenceSyntaxHighlighter.DOCUMENTATION_COMMENT),
        new AttributesDescriptor("Identifier", CadenceSyntaxHighlighter.IDENTIFIER),
        new AttributesDescriptor("Bad Character", CadenceSyntaxHighlighter.BAD_CHARACTER)
    };

    @Nullable
    @Override
    public Icon getIcon() {
        return CadenceIcon.FILE;
    }

    @NotNull
    @Override
    public SyntaxHighlighter getHighlighter() {
        return new CadenceSyntaxHighlighter();
    }

    @NotNull
    @Override
    public String getDemoText() {
        return "// Single line comments\n" +
            "///Single line doc comments\n" +
            "/* Block\n" +
            " comments */\n" +
            "/** Block Doc\n" +
            " comments */\n" +
            "let mytext: String = \"test string escape \\n or escape \\u{0009} unicode\"\n" +
            "pub fun mytestfun(amount: Int32, addresses: @Address){\n" +
            " var amount: Int16;\n" +
            " amount = 525;\n" +
            " return amount; }\n";
    }

    @Nullable
    @Override
    public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
        return null;
    }

    @NotNull
    @Override
    public AttributesDescriptor[] getAttributeDescriptors() {
        return DESCRIPTORS;
    }

    @NotNull
    @Override
    public ColorDescriptor[] getColorDescriptors() {
        return ColorDescriptor.EMPTY_ARRAY;
    }

    @NotNull
    @Override
    public String getDisplayName() {
        return "Cadence";
    }

}
