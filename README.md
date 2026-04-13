# rs-max

Maximum strictness Rust project template.

## Setup

```sh
just setup
```

## Commands

| Command          | What                                                   |
| ---------------- | ------------------------------------------------------ |
| `just ci`        | Full pipeline (clean, update, format, lint, test, ...) |
| `just ci-remote` | Same without clean (for CI)                            |
| `just fix`       | Auto-fix everything                                    |
| `just fmt`       | Auto-format all files                                  |
| `just check`     | Quick cargo check                                      |
| `just lint`      | Clippy with all lints                                  |
| `just test`      | Run tests                                              |
| `just watch`     | Dev loop with bacon                                    |
| `just cov`       | Coverage report                                        |
| `just update`    | Update all dependencies                                |
| `just doc-open`  | Build and open docs                                    |

## Strictness

- Every stable rustc allow-by-default lint: `forbid`
- Every clippy group (pedantic, nursery, cargo, restriction): `deny`
- Zero warnings: `warnings = "deny"`
- No `//` comments in Rust source
- Pre-commit hook runs full `just ci`
- Pipeline cleans and updates deps every run
- CI runs same pipeline + coverage
- Dependabot keeps deps and actions up to date weekly
