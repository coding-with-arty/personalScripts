# Gitignore Cheat Sheet

A quick reference for common `.gitignore` patterns and use cases.

---

## Basic Patterns

| Pattern        | Meaning                                                     |
| -------------- | ----------------------------------------------------------- |
| `*.log`        | Ignore all `.log` files (e.g., `debug.log`)                 |
| `*.env`        | Ignore all files ending with `.env`                         |
| `*.env*`       | Ignore `.env`, `.env.pub`, `save.env`, etc.                 |
| `secret*`      | Ignore any file starting with `secret` (e.g., `secret.txt`) |
| `build/`       | Ignore a folder named `build` and everything inside         |
| `/build/`      | Ignore only the `build` folder in the repository root       |
| `**/build/`    | Ignore any `build` folder at any level in the project       |
| `*.pyc`        | Ignore compiled Python files                                |
| `__pycache__/` | Ignore Python cache folders                                 |

---

## Negation (Force tracking a file)

| Pattern          | Meaning                                                   |
| ---------------- | --------------------------------------------------------- |
| `!important.env` | Track this file even if it matches a previous ignore rule |

---

## Comments

| Pattern               | Meaning                                    |
| --------------------- | ------------------------------------------ |
| `# This is a comment` | Lines starting with `#` are ignored by Git |

---

## Examples for a Node.js/Flask Project

```gitignore
# Python/Flask
*.pyc
__pycache__/
instance/
*.env*

# Node.js
node_modules/
npm-debug.log
yarn-error.log

# IDE/editor files
.vscode/
.idea/
*.sublime-project
*.sublime-workspace
```

---

### Notes

* `*` = wildcard for any number of characters
* `/` at the start = path relative to repo root
* `/` at the end = folder
* `!` = force include
