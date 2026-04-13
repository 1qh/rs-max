set shell := ["bash", "-uc"]

default: ci

# First-time setup after clone
setup:
    git config core.hooksPath .githooks
    @echo "done"

# Full pipeline — pre-commit hook and CI run this
ci: fmt-check toml-check typos lint test deny machete doc

# Format everything
fmt:
    cargo fmt --all
    taplo fmt

# Check formatting
fmt-check:
    cargo fmt --all -- --check
    taplo check

# Lint TOML files
toml-check:
    taplo lint

# Spell check
typos:
    typos

# Clippy with all lints
lint:
    cargo clippy --all-targets --all-features -- -D warnings

# Run tests
test:
    cargo nextest run --all-features --no-tests=pass
    cargo test --doc 2>/dev/null || true

# Dependency audit
deny:
    cargo deny check

# Unused dependency check
machete:
    cargo machete

# Build docs, deny warnings
doc:
    RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features

# Test coverage report
cov:
    cargo llvm-cov --all-features --open

# Test coverage (CI, lcov output)
cov-ci:
    cargo llvm-cov --all-features --lcov --output-path lcov.info

# Dev loop — rerun on file changes
watch:
    bacon clippy

# Build release
release:
    cargo build --release
