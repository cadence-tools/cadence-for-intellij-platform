# cadence-for-intellij-platform
Cadence language support for intellij platform IDEs

# Installation Guide
- The plugin can be found here: https://plugins.jetbrains.com/plugin/17764-cadence
- Alternatively, you can find it through the Jetbrains Marketplace, if you have added the <alpha> repository channel.

# Compatibility
- All Intellij Platform products, from version 2021.2 and up

# Building the project
- Open project with Intellij
- From project structure, set the project SDK to a JDK 11, and the language level to 11
- From project structure -> modules -> main, click the edit on the "gen" folder under sources and check the checkbox to mark it as generated
- Build the project (run the gradle build task)
- Run the gradle task runide
- On the new IDE that runs, if you open a `.cdc` file you should see the flow icon and some syntax highlighting
- If you make changes on the code, generate any sources needed, and run the runide again
- Sometimes it's good idea to actually delete the `gen` folder and rerun the generations (first .bnf, then .flex)

# Making changes on the language recognition
- One task is to properly use the grammar from vscode plugin (view useful links) to provide the syntax highlighting
- This is done by changing the following 2 files

## Cadence.bnf
- Declares the high level Token types
- All declared types will be available as return types at Cadence.flex
- After changing you must generate parser code (control+shift+g) .It's good idea to also first delete the `gen` folder


## Cadence.flex
- Used to define the regexes that recognise the tokens
- Generates the Lexer using JFlex
- After changing you must Run JFlex generator (control+shift+g)
- First rule that matches wins
- You can have states, in which you declare the rules that apply only there
- 

# Making changes to the highlighting
Once a token is being recognised in the PSI structure, to add highlighting for it, you need to update:
- `CadenceSyntaxHighlighter`
- `CadenceColorSettingsPage`

# Making a release
- Ensure everything is ready
- Make any required changes to build.gradle (version, changelog, release channel)
- commit, and push
- sign the plugin (for now using the sign-plugin.sh , will need to update the version) 
- tag version: ```git tag -a 1.4 -m "my version 1.4"```
- push tag  ```git push 1.4```
- make a release in github. Add the generated signed zip found under /build/distribution
- Go to plugins.jetbrains.com  and upload new version
- Wait for approval
- Test that it works

