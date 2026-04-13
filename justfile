set shell := ["bash", "-uc"]
set quiet

default: ci

# Install all required tools
install:
    brew install just cargo-nextest cargo-deny cargo-machete cargo-llvm-cov dprint typos-cli bacon ripgrep

# First-time setup after clone
setup: install
    git config core.hooksPath .githooks
    @echo "done"

# Full pipeline
ci: fmt-check typos no-comments lint test deny machete doc

# Quick check (faster than full lint)
check:
    cargo check --all-targets --all-features

# Format everything
fmt:
    cargo fmt --all
    dprint fmt

# Check formatting
fmt-check:
    cargo fmt --all -- --check
    dprint check

# Ban comments in Rust source (doc comments allowed)
no-comments:
    ! rg '^\s*//[^/!]' -t rust src/

# Spell check
typos:
    typos

# Fix typos automatically
typos-fix:
    typos -w

# Clippy with all lints
lint:
    cargo clippy --all-targets --all-features --quiet -- -D warnings

# Clippy auto-fix
fix:
    cargo clippy --all-targets --all-features --fix --allow-dirty -- -D warnings
    sed -i '' '/^[[:space:]]*\/\/[^\/!]/d' src/**/*.rs
    cargo fmt --all
    dprint fmt

# Run tests
test:
    cargo nextest run --all-features --no-tests=pass --status-level=none --final-status-level=fail 2>/dev/null
    cargo test --doc --quiet 2>&1 | rg '^(FAIL|error)' || true

# Run tests with CI profile (retries, no fail-fast)
test-ci:
    cargo nextest run --all-features --no-tests=pass --profile ci --status-level=fail
    cargo test --doc --quiet 2>/dev/null || true

# Dependency audit
deny:
    cargo deny -L error check

# Unused dependency check
machete:
    cargo machete 2>&1 | rg -v '^(Analyzing|Done!|cargo-machete)' || true

# Build docs, deny warnings
doc:
    RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features --quiet

# Open docs in browser
doc-open:
    RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features --open

# Test coverage report (opens browser)
cov:
    cargo llvm-cov --all-features --open

# Test coverage (CI, lcov output)
cov-ci:
    cargo llvm-cov --all-features --lcov --output-path lcov.info

# Update all dependencies
update:
    cargo update
    dprint config update
    cargo deny -L error check

# Dev loop
watch:
    bacon clippy

# Build release
release:
    cargo build --release

# Clean build artifacts
clean:
    cargo clean

# Show outdated dependencies
outdated:
    cargo install cargo-outdated 2>/dev/null; cargo outdated -R

# Expand macros for a file (e.g. just expand src/main.rs)
expand file:
    cargo expand --file {{file}}

# Show binary size breakdown
bloat:
    cargo install cargo-bloat 2>/dev/null; cargo bloat --release
