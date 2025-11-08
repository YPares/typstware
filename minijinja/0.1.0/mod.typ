#let plugin = plugin("minijinja.wasm")

#let render-template(template, ..subs) = {
  let subs = subs
    .named()
    .pairs()
    .map(
      ((k, v)) => (k, str(v)),
    )
    .to-dict()
  str(plugin.render_template(bytes(template), cbor.encode(subs)))
}
