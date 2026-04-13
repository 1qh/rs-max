# rs-max

Maximum strictness Rust project template.

## Setup

```sh
just setup
```

## Commands

| Command | What |
|---------|------|
| `just ci` | Full pipeline (format, lint, test, audit, docs) |
| `just check` | Quick cargo check |
| `just fmt` | Auto-format rust + toml |
| `just fix` | Auto-fix clippy lints |
| `just lint` | Clippy with all lints |
| `just test` | Run tests |
| `just watch` | Dev loop with bacon |
| `just cov` | Coverage report |
| `just update` | Update all dependencies |
| `just doc-open` | Build and open docs |

## Strictness

- Every stable rustc allow-by-default lint: `forbid`
- Every clippy group (pedantic, nursery, cargo, restriction): `deny`
- Zero warnings: `warnings = "deny"`
- Pre-commit hook runs full `just ci`
- CI runs same pipeline + coverage
- Dependabot keeps deps and actions up to date weekly
