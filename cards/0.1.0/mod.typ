/// Display some content in a rectangle with a small caption
/// at the top left-hand corner
#let outlined(fill: luma(200), caption, content) = {
	let (dx, dy) = (.35em, .7em)

	block(inset: (left: 1em - dx, top: dy))[

		#rect(
			radius: 3pt,
			fill: fill,
			stroke: (bottom: 1.5pt + fill.darken(50%), right: 1.5pt + fill.lighten(30%)),
			content
		)

		#place(
			top + left,
			dx: -dx,
			dy: -dy,
			block(
				radius: 2pt,
				inset: 2.5pt,
				stroke: (bottom: .5pt + luma(100), right: .5pt + luma(170)),
				fill: luma(30),
				text(fill: fill.lighten(30%), weight: "bold", size: .67em, caption)
			)
		)

	]
}
