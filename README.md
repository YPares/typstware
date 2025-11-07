# `typstware`

A monorepo of various [`typst`](https://typst.app) utilities.

## [`scoped`](./scoped)

A library that provides a `scoped` function that constructs a local variant of `query`, to query content only in the current scope:

```typst
#let card(color, title, content) = (
	align(left,
	stack(
			block(
				inset: 2pt,
				stroke: (left: .5pt, top: .5pt, right: .5pt),
				fill: luma(220),
				text(size: .65em, title)
		),
		rect(
			fill: color,
			content
		)
	)
	)
)

== A first title outside

#lorem(15)

#scoped(sc => [
	== A first title inside
	#lorem(12)

	== A second title inside
	#lorem(20)

	#figure(caption: "Found Level 2 Headings")[
		#card(green)[INSIDE of this "scoped" block][
			#(sc.inside)(heading.where(level: 2)).map(it => emph(it.body)).join([, ])
		]

		#card(yellow)[OUTSIDE of this "scoped" block][
			#(sc.outside)(heading.where(level: 2)).map(it => emph(it.body)).join([, ])
		]

		#card(blue)[BEFORE this "scoped" block][
			#(sc.before)(heading.where(level: 2)).map(it => emph(it.body)).join([, ])
		]

		#card(purple)[AFTER this "scoped" block][
			#(sc.after)(heading.where(level: 2)).map(it => emph(it.body)).join([, ])
		]
	]
])

== A second title outside
#lorem(4)
```
