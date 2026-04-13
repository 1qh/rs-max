# rs-max

Maximum strictness Rust project.

## Commands

- `just ci` — full pipeline (clean, update, format, lint, test, audit, docs)
- `just ci-remote` — same without clean (for CI)
- `just fix` — auto-fix everything (clippy, comments, typos, format)
- `just fmt` — auto-format rust + toml + json + yaml + md
- `just watch` — dev loop with bacon
- `just cov` — coverage report
- `just setup` — first-time setup after clone

## Rules

- Every stable rustc allow-by-default lint is `forbid`
- Every clippy group (pedantic, nursery, cargo, restriction) is `deny`
- Zero warnings — `warnings = "deny"`
- Use `#[expect(lint, reason = "...")]` for documented exceptions, never `#[allow]`
- No `//` comments in Rust source, only `///` doc comments
- All files must pass `dprint check`
- All source must pass `typos`
- Pre-commit hook runs full `just ci`
- Pipeline cleans and updates deps every run
