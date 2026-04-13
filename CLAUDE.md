# rs-max

See [README.md](README.md) for commands and setup.

## Rules

- Use `#[expect(lint, reason = "...")]` for documented exceptions, never `#[allow]`
- No `//` comments in Rust source, only `///` doc comments
- Pipeline cleans and updates deps every run
- Run `just ci` before committing (pre-commit hook does this)
