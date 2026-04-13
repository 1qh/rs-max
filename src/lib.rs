//! rs-max: Maximum strictness Rust project.

use core::fmt;

use serde::{Deserialize, Serialize};
use serde_json as _;

/// A greeting message.
#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub struct Greeting {
    /// The name to greet.
    pub name: &'static str,
}

impl Greeting {
    /// Formats the greeting as a string.
    #[inline]
    #[must_use]
    pub fn message(&self) -> String {
        return core::format_args!("Hello, {}!", self.name).to_string();
    }

    /// Creates a new greeting.
    #[inline]
    #[must_use]
    pub const fn new(name: &'static str) -> Self {
        return Self { name };
    }
}

impl fmt::Display for Greeting {
    #[inline]
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        return write!(f, "Hello, {}!", self.name);
    }
}

#[cfg(test)]
mod tests {
    use super::Greeting;

    /// Verifies greeting creation.
    ///
    /// # Panics
    ///
    /// Panics if name does not match.
    #[test]
    fn creates_greeting() {
        let greeting = Greeting::new("world");
        assert!(greeting.name == "world", "name should be world");
    }

    /// Verifies greeting message format.
    ///
    /// # Panics
    ///
    /// Panics if message does not match.
    #[test]
    fn formats_message() {
        let greeting = Greeting::new("Rust");
        assert!(greeting.message() == "Hello, Rust!", "message should match");
    }

    /// Verifies serde round-trip.
    ///
    /// # Panics
    ///
    /// Panics if serialization fails or output does not match.
    #[test]
    fn serde_roundtrip() {
        let greeting = Greeting::new("serde");
        let json = serde_json::to_string(&greeting);
        assert!(json.is_ok(), "serialize should succeed");
        assert!(
            json.unwrap_or_default() == r#"{"name":"serde"}"#,
            "json should match"
        );
    }
}
