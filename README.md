# Daisify

Daisify is a shell script that can be used to easily set up [Daisy UI](https://daisyui.com/) in a new rails application. 

## Usage

```bash
rails new myapp --css=tailwind
cd myapp
daisify
```

You can also specify a particular theme by passing it in as an argument

```bash
rails new myapp --css=tailwind
cd myapp
daisify halloween
```

## Installation

You can set up an alias for daisify inside your shell configuration file (e.g. `.bashrc`, `.zshrc`, etc.):

```bash
alias daisify='/path/you/cloned/to/daisify/daisify.sh'
```

Also, make sure to give execute permissions to the script:

```bash
chmod +x /path/you/cloned/to/daisify/daisify.sh
```
