<div align="center">
  <a href="https://github.com/cadence-tools/cadence-for-intellij-platform">
    <img src="images/flow-logo.png" alt="Flow Logo" width="80" height="80">
  </a>

<h3 align="center">Flow - Cadence Support for Intellij Platform</h3>

  <p align="center">
    Support for Cadence, the resource-oriented smart contract language of Flow, in Intellij Platform IDEs. 
    <br />
    <a href="https://plugins.jetbrains.com/plugin/17764-cadence"><strong>Get the plugin</strong></a>
    <br />
    <br />
    <a href="https://github.com/cadence-tools/cadence-for-intellij-platform/issues">Report a Problem / Request a Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#installation">Installation</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#usage">Usage</a></li>
          <ul>
            <li><a href="#syntax-highlighting">Syntax Highlighting</a></li>
            <li><a href="#language-server-protocol-support">Language Server Protocol Support</a></li>
          </ul>
        <li><a href="#compatibility">Compatibility</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
      <ul>
        <li><a href="#building-the-project">Building the project</a></li>
        <li><a href="#making-changes-to-the-language-recognition">Making changes to the language recognition</a></li>
        <li><a href="#making-changes-to-the-highlighting">Making changes to the highlighting</a></li>
        <li><a href="#supporting-cadence-language-server-protocol">Supporting Cadence Language Server Protocol</a></li>
        <li><a href="#making-a-release-(only-for-mainteners)">Making a release (only for maintainers)</a></li>
      </ul>

  </ol>
</details>


# About the Project

![Usage Screenshot](images/plugin-screenshot.png/?raw=true)
- Cadence language support for intellij platform IDEs
- https://plugins.jetbrains.com/plugin/17764-cadence

# Getting Started
## Installation
- You can download the plugin by searching the marketplace in your Intellij Platform IDE
- Alternative you can get it from the [Jetbrains Marketplace](https://plugins.jetbrains.com/plugin/17764-cadence)

## Usage

### Syntax Highlighting
- The plugin will be immediately associated with any `.cdc` files and provide syntax highlighting.
- It will follow the different themes / color schemes you choose from your IDE
- You can customize the colors by going to `Settings` -> `Editor` -> `Color Scheme` -> `Cadence`

### Language Server Protocol Support
- To utilize the LSP support, you must have [flow-cli](github.com/onflow/flow-cli) installed and available on your PATH
- You can test it by running on a terminal the command `flow cadence language-server`. (It will tell you that it does nothing when ran from a terminal)
- You should run the flow emulator from the flow-cli before starting the plugin, with the command `flow emulator start`
- You can configure the settings for the LSP under `Settings` -> `Tools` -> `Cadence LSP settings`
- Note: After changing settings, a restart is required for them to take effect. This will be addressed in a future release

## Compatibility
All Intellij Platform products, from version 2021.2 and up:
- IntelliJ IDEA Ultimate
- IntelliJ IDEA Community
- IntelliJ IDEA Educational
- PyCharm Professional
- PyCharm Community
- PyCharm Educational
- GoLand
- RubyMine
- CLion
- PhpStorm
- WebStorm
- Rider
- Code With Me Guest
- Android Studio
- DataSpell
- DataGrip
- JetBrains Gateway
- MPS
- AppCode

# Roadmap
- Refine syntax highlighting
- Improve support for Language Server Protocol

# Contributing
- Everyone is welcome to contribute, through issues reporting or pull requests
- Feel free to open an issue before you start working on it, to avoid duplicate work

## Building the project
- Open project with Intellij
- From project structure, set the project SDK to a JDK 11, and the language level to 11
- From project structure -> modules -> main, click the edit on the "gen" folder under sources and check the checkbox to mark it as generated
- Go to `Cadence.bnf` and from the context menu `Generate Parser Code`
- Go to `Cadence.flex` and from the context menu `Run JFlex Generator` 
- Build the project (run the gradle build task)
- Run the gradle task runide
- On the new IDE that runs, if you open a `.cdc` file you should see the plugin working
- If you make changes on the code, generate any sources needed, and run the runide again
- If after changes you see "strange" results, it's a good idea to actually delete the `gen` folder and rerun the generations

## Making changes to the language recognition

### Cadence.bnf
- Declares the high level Token types
- All declared types will be available as return types at Cadence.flex
- After changing you must generate parser code (control+shift+g)
- It is good idea to also first delete the `gen` folder

### Cadence.flex
- Used to define the regexes that recognise the tokens
- Generates the Lexer using JFlex
- After changing you must Run JFlex generator (control+shift+g)
- First rule that matches wins
- You can have states, in which you declare the rules that apply only there

## Making changes to the highlighting
Once a token is being recognised in the PSI structure, to add highlighting for it, you need to update:
- `CadenceSyntaxHighlighter` for the actual highlighting
- `CadenceColorSettingsPage` to add new tokens to the Color Scheme page of the IDE

## Supporting Cadence Language Server Protocol
- The Language Server Protocol server provided by [Cadence](https://github.com/onflow/cadence/) is utilized
- To provide the support the library [lsp4intellij](https://github.com/ballerina-platform/lsp4intellij/) is used
- Settings and functionality for logging input / output commands to LSP server for local debugging are available

## Making a release (only for maintainers)
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