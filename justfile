set shell := ["bash", "-uc"]

default: ci

ci: fmt-check lint test deny machete doc

fmt:
    cargo +nightly fmt --all

fmt-check:
    cargo +nightly fmt --all -- --check

lint:
    cargo clippy --all-targets --all-features -- -D warnings

test:
    cargo nextest run --all-features
    cargo test --doc

deny:
    cargo deny check

machete:
    cargo machete

doc:
    RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features

watch:
    cargo watch -x check -x 'clippy --all-targets --all-features -- -D warnings' -x 'nextest run'
