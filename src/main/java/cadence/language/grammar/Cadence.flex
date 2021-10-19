package cadence.language.grammar;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import cadence.language.psi.CadenceTypes;
import com.intellij.psi.TokenType;

%%

%class CadenceLexer
%implements FlexLexer
%public
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpaceOnly = [ \t\f]
WhiteSpace = {LineTerminator} | {WhiteSpaceOnly}



/* comments */
DocumentationComment = {DocumentationEndOfLineComment} | {DocumentationBlockComment}
DocumentationEndOfLineComment = "///" {InputCharacter}* {LineTerminator}?
DocumentationBlockComment = "/**"+ [^/*] ~"*/"

SimpleComment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?


/* identifiers */
Identifier = {SimpleIdentifier}\R*
FullIdentifier = {SimpleIdentifier}{SubIdentifier}+\R*
SubIdentifier = \.{SimpleIdentifier}
FunctionIdentifier = {SimpleIdentifier}
ParamIdentifier = {SimpleIdentifier}:
TypeIdentifier = {SimpleIdentifier}|{FullIdentifier}
AccessIdentifier = {SimpleIdentifier}
FunctionCallIdentifier = {FullIdentifier}\(

SimpleIdentifier={NameFirstCharacter}{NameLegalCharacters}*

NameLegalCharacters = [_A-Za-z0-9]
NameFirstCharacter = [_A-Za-z]

/* integer literals */
FixPointLiteral   = {DecIntegerLiteral}\.{DecIntegerLiteral}
DecIntegerLiteral = {DecDigit}+
DecDigit          = [0-9]

HexIntegerLiteral = (0x)({OctDigit})+
HexDigit          = [0-9a-fA-F]

OctIntegerLiteral = (0o)({OctDigit})+
OctDigit          = [0-7]

BinIntegerLiteral   = (0b)({BinDigit})+
BinDigit          = [0-1]
/* string and character literals */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]
UnicodeCharacter = (\\u\{)({HexDigit}){1,8}(\})

%state STRING, DEFINITION, FUNCTION_NAME, TYPE, FUNCTION_PARAMS, ACCESS

%%

<YYINITIAL> {
  {FullIdentifier}                 { return CadenceTypes.FULL_IDENTIFIER; }

  "access"                         { yybegin(ACCESS); return CadenceTypes.KEYWORD; }
  "fun"                            { yybegin(FUNCTION_NAME); return CadenceTypes.KEYWORD; }

// Typelet s
  "Void"\R*                        { return CadenceTypes.TYPE; }

  "Bool"\R*                        { return CadenceTypes.TYPE; }
  "String"\R*                      { return CadenceTypes.TYPE; }
  "Character"\R*                   { return CadenceTypes.TYPE; }

  "Int8"\R*                        { return CadenceTypes.TYPE; }
  "Int16"\R*                       { return CadenceTypes.TYPE; }
  "Int32"\R*                       { return CadenceTypes.TYPE; }
  "Int64"\R*                       { return CadenceTypes.TYPE; }
  "Int128"\R*                      { return CadenceTypes.TYPE; }
  "Int256"\R*                      { return CadenceTypes.TYPE; }

  "UInt8"\R*                       { return CadenceTypes.TYPE; }
  "UInt16"\R*                      { return CadenceTypes.TYPE; }
  "UInt32"\R*                      { return CadenceTypes.TYPE; }
  "UInt64"\R*                      { return CadenceTypes.TYPE; }
  "UInt128"\R*                     { return CadenceTypes.TYPE; }
  "UInt256"\R*                     { return CadenceTypes.TYPE; }

  "Word8"\R*                       { return CadenceTypes.TYPE; }
  "Word16"\R*                      { return CadenceTypes.TYPE; }
  "Word32"\R*                      { return CadenceTypes.TYPE; }
  "Word64"\R*                      { return CadenceTypes.TYPE; }

  "Fix64"\R*                       { return CadenceTypes.TYPE; }
  "UFix64"\R*                      { return CadenceTypes.TYPE; }

  /* boolean literals */
  "true"\R*                        { return CadenceTypes.KEYWORD;  }
  "false"\R*                       { return CadenceTypes.KEYWORD;  }

  /* nil literal */
  "nil"\R*                         { return CadenceTypes.KEYWORD;  }

// Control
  "if"\R*                          { return CadenceTypes.KEYWORD; }
  "else"\R*                        { return CadenceTypes.KEYWORD; }
  "switch"\R*                      { return CadenceTypes.KEYWORD; }
  "case"\R*                        { return CadenceTypes.KEYWORD; }
   "default"\R*                    { return CadenceTypes.KEYWORD; }

// Control transfer
  "break"\R*                       { return CadenceTypes.KEYWORD; }
  "continue"\R*                    { return CadenceTypes.KEYWORD; }
  "return"\R*                      { return CadenceTypes.KEYWORD; }

// Loop
  "while"                          { return CadenceTypes.KEYWORD; }
  "for"                            { return CadenceTypes.KEYWORD; }
  "in"                             { return CadenceTypes.KEYWORD; }

// Imports
  "import"                         { return CadenceTypes.KEYWORD; }
  "from"                           { return CadenceTypes.KEYWORD; }

  "Never"\R*                       { return CadenceTypes.KEYWORD; }

// Variable declaration
  "let"                            { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "var"                            { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }

// Function
  "pre"                            { return CadenceTypes.KEYWORD; }
  "post"                           { return CadenceTypes.KEYWORD; }
  "execute"                        { return CadenceTypes.KEYWORD; }
  "prepare"                        { return CadenceTypes.KEYWORD; }

// Composite types
  "create"                         { return CadenceTypes.KEYWORD; }
  "destroy"                        { return CadenceTypes.KEYWORD; }
  "init"                           { return CadenceTypes.KEYWORD; }
  "synthetic"                      { return CadenceTypes.KEYWORD; }
  "self"                           { return CadenceTypes.KEYWORD; }
  "get"                            { return CadenceTypes.KEYWORD; }
  "set"                            { return CadenceTypes.KEYWORD; }

// events
  "emit"                           { yybegin(FUNCTION_NAME); return CadenceTypes.KEYWORD; }
  "event"                          { yybegin(DEFINITION);    return CadenceTypes.KEYWORD; }

// Access
  "priv"                           { return CadenceTypes.KEYWORD; }
  "pub"                            { return CadenceTypes.KEYWORD; }

  "contract"                       { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "account"                        { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "all"                            { return CadenceTypes.KEYWORD; }

   "transaction"                   { return CadenceTypes.KEYWORD; }

   "AnyStruct"                     { return CadenceTypes.KEYWORD; }
   "AnyResource"                   { return CadenceTypes.KEYWORD; }
   "struct"                        { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "interface"                     { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "resource"                      { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }

   "Address"                       { return CadenceTypes.TYPE; }
   "PublicAccount"                 { return CadenceTypes.TYPE; }
   "AuthAccount"                   { return CadenceTypes.TYPE; }

  "enum"                           { return CadenceTypes.KEYWORD; }

  /* separators */
  ";"                              { return CadenceTypes.SEPARATOR; }
  "("                              { return CadenceTypes.SEPARATOR; }
  ")"                              { return CadenceTypes.SEPARATOR; }
  "{"                              { return CadenceTypes.SEPARATOR; }
  "}"                              { return CadenceTypes.SEPARATOR; }
  "["                              { return CadenceTypes.SEPARATOR; }
  "]"                              { return CadenceTypes.SEPARATOR; }
  ","                              { return CadenceTypes.SEPARATOR; }
  "."                              { return CadenceTypes.SEPARATOR; }

  /* operators */
  "@"                              { return CadenceTypes.OPERATOR; }
  "??"                             { return CadenceTypes.OPERATOR; }
  "<-!"                            { return CadenceTypes.OPERATOR; }
  "<-"                             { return CadenceTypes.OPERATOR; }
  "as?"                            { return CadenceTypes.OPERATOR; }
  "="                              { return CadenceTypes.OPERATOR; }
  "<->"                            { return CadenceTypes.OPERATOR; }

  "+"                              { return CadenceTypes.OPERATOR; }
  "-"                              { return CadenceTypes.OPERATOR; }
  "*"                              { return CadenceTypes.OPERATOR; }
  "/"                              { return CadenceTypes.OPERATOR; }
  "%"                              { return CadenceTypes.OPERATOR; }
  "!"                              { return CadenceTypes.OPERATOR; }

  "&&"                             { return CadenceTypes.OPERATOR; }
  "||"                             { return CadenceTypes.OPERATOR; }

  ">"                              { return CadenceTypes.OPERATOR; }
  "<"                              { return CadenceTypes.OPERATOR; }
  "=="                             { return CadenceTypes.OPERATOR; }
  "<="                             { return CadenceTypes.OPERATOR; }
  ">="                             { return CadenceTypes.OPERATOR; }
  "!="                             { return CadenceTypes.OPERATOR; }

  "?"                              { return CadenceTypes.OPERATOR; }
  ":"                              { return CadenceTypes.OPERATOR; }

  "<<"                             { return CadenceTypes.OPERATOR; }
  ">>"                             { return CadenceTypes.OPERATOR; }
  "&"                              { return CadenceTypes.OPERATOR; }
  "|"                              { return CadenceTypes.OPERATOR; }
  "^"                              { return CadenceTypes.OPERATOR; }

  /* string literal */
  \"                               { yybegin(STRING); }

  /* numeric literals */
  {HexIntegerLiteral}              { return CadenceTypes.NUMERIC_VALUE; }
  {OctIntegerLiteral}              { return CadenceTypes.NUMERIC_VALUE; }
  {BinIntegerLiteral}              { return CadenceTypes.NUMERIC_VALUE; }
  {FixPointLiteral}                { return CadenceTypes.NUMERIC_VALUE; }
  {DecIntegerLiteral}              { return CadenceTypes.NUMERIC_VALUE; }

  /* comments */
  {DocumentationComment}           { return CadenceTypes.DOCUMENTATION_COMMENT;}
  {SimpleComment}                  { return CadenceTypes.SIMPLE_COMMENT; }

  /* whitespace */
  {WhiteSpace}                     { return CadenceTypes.SEPARATOR; }

  /* identifiers */
  {Identifier}                     { return CadenceTypes.IDENTIFIER; }
}

<STRING> {
  \"                               { yybegin(YYINITIAL); return CadenceTypes.STRING_VALUE; }

   \\n                             { return CadenceTypes.STRING_ESCAPE_SEQUENCE;}
  (\\0|\\\\|\\t|\\n|\\r|\\\"|\\\') { return CadenceTypes.STRING_ESCAPE_SEQUENCE;}
  {UnicodeCharacter}               { return CadenceTypes.STRING_ESCAPE_SEQUENCE;}

  {StringCharacter}+               { return CadenceTypes.STRING_VALUE; }
  /* error cases */
  {LineTerminator}                 { return TokenType.BAD_CHARACTER; }
}

<DEFINITION> {
  {WhiteSpaceOnly}                 {return CadenceTypes.SEPARATOR;}
  "interface"                      {return CadenceTypes.KEYWORD;}

  {Identifier}                     { yybegin(YYINITIAL); return CadenceTypes.DEFINITION; }

  /* error cases */
  {LineTerminator}                 { return TokenType.BAD_CHARACTER; }
}

<FUNCTION_NAME> {
 {WhiteSpaceOnly}                  { return CadenceTypes.SEPARATOR;}
  {FunctionIdentifier}             { return CadenceTypes.FUNCTION_NAME; }
  \(                               { yybegin(FUNCTION_PARAMS); return CadenceTypes.SEPARATOR;}
  \)                               { return CadenceTypes.SEPARATOR;}
  :                                { yybegin(TYPE); return CadenceTypes.SEPARATOR;}
  \{                               { yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
  {LineTerminator}                 { return TokenType.BAD_CHARACTER; }
}
<TYPE> {
  {WhiteSpaceOnly}                 { return CadenceTypes.SEPARATOR;}
  @                                { return CadenceTypes.OPERATOR;}
  {TypeIdentifier}                 { yybegin(YYINITIAL); return CadenceTypes.TYPE; }

  /* error cases */
  {LineTerminator}                 { return TokenType.BAD_CHARACTER; }
}
<FUNCTION_PARAMS> {
  ,                                { return CadenceTypes.SEPARATOR;}
  {WhiteSpaceOnly}                 { return CadenceTypes.SEPARATOR;}
  @                                { return CadenceTypes.OPERATOR;}
  {ParamIdentifier}                { return CadenceTypes.FUNCTION_PARAMETER; }
  {TypeIdentifier}                 { return CadenceTypes.TYPE; }
  \):                              { yybegin(TYPE); return CadenceTypes.SEPARATOR;}
  \)                               { yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
  {LineTerminator}                 { return TokenType.BAD_CHARACTER; }
}

// Need separate state for access to correctly handle cases like access(contract), where contract is also keyword
<ACCESS> {
  "("                               {return CadenceTypes.SEPARATOR;}
  ")"                               {yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}
  {WhiteSpaceOnly}                 {return CadenceTypes.SEPARATOR;}
  {AccessIdentifier}               {return CadenceTypes.DEFINITION;}

  /* error cases */
  {LineTerminator}                 { return TokenType.BAD_CHARACTER; }
}

/* error fallback */
[^]                                { return TokenType.BAD_CHARACTER; }
