# rs-max

Maximum strictness Rust project.

## Commands

- `just ci` — full pipeline (format, lint, test, audit, docs)
- `just fmt` — auto-format rust + toml
- `just watch` — dev loop with bacon
- `just cov` — coverage report
- `just setup` — first-time setup after clone

## Rules

- Every rustc allow-by-default lint is `forbid`
- Every clippy group (pedantic, nursery, cargo, restriction) is `deny`
- Zero warnings tolerance — `warnings = "deny"`
- Use `#[expect(lint, reason = "...")]` for documented exceptions, never `#[allow]`
- All TOML files must pass `taplo lint`
- All source must pass `typos` spell check
- Pre-commit hook runs full `just ci`
