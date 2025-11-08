use ciborium::de::from_reader;
use minijinja::{Environment, UndefinedBehavior};
use std::collections::HashMap;
use wasm_minimal_protocol::*;

initiate_protocol!();

#[wasm_func]
pub fn render_template(template: &[u8], subs: &[u8]) -> Result<Vec<u8>, String> {
    let subs: HashMap<String, String> = from_reader(subs).map_err(|e| e.to_string())?;

    let mut env = Environment::new();
    env.set_undefined_behavior(UndefinedBehavior::SemiStrict);
    let rendered = env
        .render_str(
            std::str::from_utf8(template).map_err(|e| e.to_string())?,
            subs,
        )
        .map_err(|e| e.to_string())?;

    Ok(rendered.into())
}
