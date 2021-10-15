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
FunctionIdentifier = {SimpleIdentifier}
ParamIdentifier = {SimpleIdentifier}:
TypeIdentifier = {SimpleIdentifier}
AccessIdentifier = {SimpleIdentifier}\)

SimpleIdentifier={NameFirstCharacter}{NameLegalCharacters}

NameLegalCharacters = [_A-Za-z0-9]*
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

/* identifiers literals */
IdentifierFirstCharacter = [_A-Za-z]
IdentifierCharacter = [_A-Za-z\R]*

%state STRING, DEFINITION, FUNCTION_NAME, FUNCTION_PARAMS, ACCESS

%%

<YYINITIAL> {
  "access"                       { yybegin(ACCESS); return CadenceTypes.KEYWORD; }
  "fun"                          { yybegin(FUNCTION_NAME); return CadenceTypes.KEYWORD; } //TODO support function calls


// Control
  "if"                           { return CadenceTypes.KEYWORD; }
  "else"                         { return CadenceTypes.KEYWORD; }
  "switch"                       { return CadenceTypes.KEYWORD; }
  "case"                         { return CadenceTypes.KEYWORD; }
   "default"                     { return CadenceTypes.KEYWORD; }

// Control transfer
  "break"                        { return CadenceTypes.KEYWORD; }
  "continue"                     { return CadenceTypes.KEYWORD; }
  "return"                       { return CadenceTypes.KEYWORD; }

// Loop
  "while"                        { return CadenceTypes.KEYWORD; }
  "for"                          { return CadenceTypes.KEYWORD; }
  "in"                           { return CadenceTypes.KEYWORD; }

// Imports
  "import"                       { return CadenceTypes.KEYWORD; }
  "from"                         { return CadenceTypes.KEYWORD; }

   "Never"                       { return CadenceTypes.KEYWORD; }
// Variable declaration
  "let"                          { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "var"                          { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }


// Function
  "return"                       { return CadenceTypes.KEYWORD; }
  "pre"                          { return CadenceTypes.KEYWORD; }
  "post"                         { return CadenceTypes.KEYWORD; }
  "execute"                      { return CadenceTypes.KEYWORD; }
  "prepare"                      { return CadenceTypes.KEYWORD; }

// Composite types
  "create"                       { return CadenceTypes.KEYWORD; }
  "destroy"                      { return CadenceTypes.KEYWORD; }
  "init"                         { return CadenceTypes.KEYWORD; }
  "synthetic"                    { return CadenceTypes.KEYWORD; }
  "self"                         { return CadenceTypes.KEYWORD; }
  "get"                          { return CadenceTypes.KEYWORD; }
  "set"                          { return CadenceTypes.KEYWORD; }

// events
  "emit"                         { yybegin(FUNCTION_NAME); return CadenceTypes.KEYWORD; }

// Access
  "priv"                         { return CadenceTypes.KEYWORD; }
  "pub"                          { return CadenceTypes.KEYWORD; }



// Types
  "Void"                         { return CadenceTypes.TYPE; }
  "Bool"                         { return CadenceTypes.TYPE; }

  "Int8"                         { return CadenceTypes.TYPE; }
  "Int16"                        { return CadenceTypes.TYPE; }
  "Int32"                        { return CadenceTypes.TYPE; }
  "Int64"                        { return CadenceTypes.TYPE; }
  "Int128"                       { return CadenceTypes.TYPE; }
  "Int256"                       { return CadenceTypes.TYPE; }

  "UInt8"                        { return CadenceTypes.TYPE; }
  "UInt16"                       { return CadenceTypes.TYPE; }
  "UInt32"                       { return CadenceTypes.TYPE; }
  "UInt64"                       { return CadenceTypes.TYPE; }
  "UInt128"                      { return CadenceTypes.TYPE; }
  "UInt256"                      { return CadenceTypes.TYPE; }

  "Word8"                        { return CadenceTypes.TYPE; }
  "Word16"                       { return CadenceTypes.TYPE; }
  "Word32"                       { return CadenceTypes.TYPE; }
  "Word64"                       { return CadenceTypes.TYPE; }

  "Fix64"                        { return CadenceTypes.TYPE; }
  "UFix64"                       { return CadenceTypes.TYPE; }

  "contract"                     { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "account"                      { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
  "all"                          { return CadenceTypes.KEYWORD; }

   "event"                       { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "transaction"                 { return CadenceTypes.KEYWORD; }

   "AnyStruct"                   { return CadenceTypes.KEYWORD; }
   "AnyResource"                 { return CadenceTypes.KEYWORD; }
   "struct"                      { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "resource"                    { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }
   "interface"                   { yybegin(DEFINITION); return CadenceTypes.KEYWORD; }

   "Address"                     { return CadenceTypes.TYPE; }
   "PublicAccount"               { return CadenceTypes.TYPE; }
   "AuthAccount"                 { return CadenceTypes.TYPE; }



  "String"                       { return CadenceTypes.KEYWORD; }
  "Character"                    { return CadenceTypes.KEYWORD; }

  "enum"                         { return CadenceTypes.KEYWORD; }

  /* boolean literals */
  "true"                         { return CadenceTypes.KEYWORD;  }
  "false"                        { return CadenceTypes.KEYWORD;  }

  /* nil literal */
  "nil"                          { return CadenceTypes.KEYWORD;  }


  /* separators */
  ";"                            { return CadenceTypes.SEPARATOR; }
  "("                            { return CadenceTypes.SEPARATOR; }
  ")"                            { return CadenceTypes.SEPARATOR; }
  "{"                            { return CadenceTypes.SEPARATOR; }
  "}"                            { return CadenceTypes.SEPARATOR; }
  "["                            { return CadenceTypes.SEPARATOR; }
  "]"                            { return CadenceTypes.SEPARATOR; }
  ","                            { return CadenceTypes.SEPARATOR; }
  "."                            { return CadenceTypes.SEPARATOR; }

  /* operators */
  "@"                           { return CadenceTypes.OPERATOR; }
  "??"                           { return CadenceTypes.OPERATOR; }
  "<-!"                          { return CadenceTypes.OPERATOR; }
  "<-"                          { return CadenceTypes.OPERATOR; }
  "as?"                          { return CadenceTypes.OPERATOR; }
  "="                            { return CadenceTypes.OPERATOR; }
  "<->"                          { return CadenceTypes.OPERATOR; }

  "+"                            { return CadenceTypes.OPERATOR; }
  "-"                            { return CadenceTypes.OPERATOR; }
  "*"                            { return CadenceTypes.OPERATOR; }
  "/"                            { return CadenceTypes.OPERATOR; }
  "%"                            { return CadenceTypes.OPERATOR; }
  "!"                            { return CadenceTypes.OPERATOR; }

  "&&"                           { return CadenceTypes.OPERATOR; }
  "||"                           { return CadenceTypes.OPERATOR; }

  ">"                            { return CadenceTypes.OPERATOR; }
  "<"                            { return CadenceTypes.OPERATOR; }
  "=="                           { return CadenceTypes.OPERATOR; }
  "<="                           { return CadenceTypes.OPERATOR; }
  ">="                           { return CadenceTypes.OPERATOR; }
  "!="                           { return CadenceTypes.OPERATOR; }

  "?"                            { return CadenceTypes.OPERATOR; }
  ":"                            { return CadenceTypes.OPERATOR; }

  "<<"                           { return CadenceTypes.OPERATOR; }
  ">>"                           { return CadenceTypes.OPERATOR; }
  "&"                            { return CadenceTypes.OPERATOR; }
  "|"                            { return CadenceTypes.OPERATOR; }
  "^"                            { return CadenceTypes.OPERATOR; }

  /* string literal */
  \"                             { yybegin(STRING); }

  /* numeric literals */
  {HexIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }
  {OctIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }
  {BinIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }
  {FixPointLiteral}              { return CadenceTypes.NUMERIC_VALUE; }
  {DecIntegerLiteral}            { return CadenceTypes.NUMERIC_VALUE; }

  /* comments */
  {DocumentationComment}         { return CadenceTypes.DOCUMENTATION_COMMENT;}
  {SimpleComment}                { return CadenceTypes.SIMPLE_COMMENT; }

//  /* whitespace */
  {WhiteSpace}                   { return CadenceTypes.SEPARATOR; }
//
//  /* identifiers */
  {Identifier}                   { return CadenceTypes.SEPARATOR; }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return CadenceTypes.STRING_VALUE; }

   \\n                            { return CadenceTypes.ESCAPE_SEQUENCE;}
  (\\0|\\\\|\\t|\\n|\\r|\\\"|\\\') { return CadenceTypes.ESCAPE_SEQUENCE;}
  {UnicodeCharacter}               { return CadenceTypes.ESCAPE_SEQUENCE;}

  {StringCharacter}+             { return CadenceTypes.STRING_VALUE; }

  /* error cases */
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

<DEFINITION> {
{WhiteSpaceOnly}                           {return CadenceTypes.SEPARATOR;}
  {Identifier}                { yybegin(YYINITIAL); return CadenceTypes.DEFINITION; }


  /* error cases */
 // ^({Identifier}|\R)                           { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

<FUNCTION_NAME> {
 {WhiteSpaceOnly}                    {return CadenceTypes.SEPARATOR;}
  {FunctionIdentifier}               { return CadenceTypes.FUNCTION_NAME; }
  \(                              { yybegin(FUNCTION_PARAMS); return CadenceTypes.SEPARATOR;}
  \)                                  { yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
 // ^({Identifier}|\R)            { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}
<FUNCTION_PARAMS> {
 ,                                {return CadenceTypes.SEPARATOR;}
 {WhiteSpaceOnly}                    {return CadenceTypes.SEPARATOR;}
  @                                 {return CadenceTypes.OPERATOR;}
  {ParamIdentifier}               { return CadenceTypes.FUNCTION_PARAMETER; }
  {TypeIdentifier}                    { return CadenceTypes.TYPE; }
  \)                                  { yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
 // ^({Identifier}|\R)                           { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

<ACCESS> {
{WhiteSpaceOnly}                 {return CadenceTypes.SEPARATOR;}
{AccessIdentifier}               {return CadenceTypes.DEFINITION; }
\(                               {return CadenceTypes.SEPARATOR;}
\)                                {yybegin(YYINITIAL); return CadenceTypes.SEPARATOR;}

  /* error cases */
 // ^({Identifier}|\R)                           { return TokenType.BAD_CHARACTER; }
  {LineTerminator}               { return TokenType.BAD_CHARACTER; }
}

/* error fallback */
[^]                              { return TokenType.BAD_CHARACTER; }
//<<EOF>>                          { return TokenType.BAD_CHARACTER; }