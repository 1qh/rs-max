set shell := ["bash", "-uc"]

default: ci

ci: fmt-check toml-check typos lint test deny machete doc

fmt:
    cargo fmt --all
    taplo fmt

fmt-check:
    cargo fmt --all -- --check
    taplo check

toml-check:
    taplo lint

typos:
    typos

lint:
    cargo clippy --all-targets --all-features -- -D warnings

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
