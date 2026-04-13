set shell := ["bash", "-uc"]

default: ci

ci: fmt-check lint test deny machete doc

fmt:
    cargo fmt --all

fmt-check:
    cargo fmt --all -- --check

lint:
    cargo clippy --lib --bins --all-features -- -D warnings

test:
    cargo nextest run --all-features --no-tests=pass
    cargo test --doc 2>/dev/null || true

deny:
    cargo deny check

machete:
    cargo machete

doc:
    RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features

watch:
    cargo watch -x check -x 'clippy --all-targets --all-features -- -D warnings' -x 'nextest run'
