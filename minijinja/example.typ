#import "0.1.0/mod.typ" as mnj

#let tmpl = "
  Hello,
  I am {{name}} and I am {{age*2}}/2.

  I own:
  {%- for item in items %}
    {%- if item.qty > 0 and not item.hide %}
    - {{item.name}} x{{item.qty}}
    {%- endif %}
  {%- endfor %}
"

#mnj.render-template(
  tmpl,
  name: "Toto",
  age: 44,
  items: (
    (name: "Foo", qty: 12),
    (name: "Bar", qty: 5, hide: true),
    (name: "Quux", qty: 0),
    (name: "Quuz", qty: 156),
  ),
)
