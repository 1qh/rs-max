//! rs-max binary entry point.

use std::io;
use std::io::Write as _;

use rs_max::Greeting;
use serde as _;
use serde_json as _;

/// Entry point.
fn main() {
    let greeting = Greeting::new("world");
    let _result = writeln!(io::stdout(), "{greeting}");
}
