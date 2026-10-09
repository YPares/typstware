#let plugin = plugin("minijinja.wasm")

#let render-template(template, ..subs) = {
  str(plugin.render_template(bytes(template), cbor.encode(subs.named())))
}
