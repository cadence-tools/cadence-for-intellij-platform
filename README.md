# cadence-for-intellij-platform
Cadence language support for intellij platform IDEs

# Installation Guide
- Open project with Intellij
- From project structure, set the project SDK to a JDK 11, and the language level to 11
- From project structure -> modules -> main, click the edit on the "gen" folder under sources and check the checkbox to mark it as generated
- Build the project (run the gradle build task)
- Run the gradle task runide
- On the new IDE that runs, if you open a `.cdc` file you should see the flow icon and some syntax highlighting
- If you make changes on the code, generate any sources needed, and run the runide again


# Making changes on the language recognition
- One task is to properly use the grammar from vscode plugin (view useful links) to provide the syntax highlighting
- This is done by changing the following 2 files
- All such changes should be done in the bnf-and-lexer branch, so it can focus on this, while we can still progress on others
## Cadence.flex
- Used to define the tokens, and how they can be combined
- Generates the Lexer using JFlex
- After changes you must Run JFlex generator (control+shift+g)

## Cadence.bnf
- Uses regular expressions to recognise tokens
- First rule that matches has priority
- You can have states in the code, so that some rules apply only sometimes
- After changes you must generate parser code (control+shift+g)
