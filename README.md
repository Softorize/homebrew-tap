# Softorize Homebrew Tap

Homebrew formulae and casks for Softorize tools.

## Install

```bash
brew tap softorize/tap
brew install linked
brew install --cask spotsearch
brew install --cask postai
```

## Available Formulae

| Formula | Description |
|---------|-------------|
| `linked` | Fast LinkedIn CLI — read, post, message, and network from your terminal |
| `yoy` | Yahoo Mail CLI — read, send, search, and manage Yahoo Mail from your terminal |
| `cpass` | ClaudePass — secret manager for AI coding agents (see note below) |

## Available Casks

| Cask | Description |
|------|-------------|
| `spotsearch` | Fast, lightweight file search application for macOS |
| `postai` | Advanced API Testing Tool with AI Integration |

**`cpass` note:** its source repo (`gumruyanzh/claudepass`) is private, so
`brew install cpass` needs a token with read access to it first:

```bash
export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
brew install cpass
```

## Update

```bash
brew update
brew upgrade linked
brew upgrade --cask spotsearch
brew upgrade --cask postai
```

## License

[MIT](LICENSE) © Softorize
