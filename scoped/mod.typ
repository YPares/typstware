#let _scope-counter = state("scope-counter", 0)

#let _inside(beg, end) = selector => {
	query(selector.after(beg, inclusive: false).before(end, inclusive: false))
}

#let _outside(beg, end) = selector => {
	query(selector.before(beg, inclusive: false).or(selector.after(end, inclusive: false)))
}

#let _before(beg, end) = (inclusive: false, selector) => {
	if inclusive {
		query(selector.before(end, inclusive: false))
	} else {
		query(selector.before(beg, inclusive: false))
	}
}

#let _after(beg, end) = (inclusive: false, selector) => {
	if inclusive {
		query(selector.after(beg, inclusive: false))
	} else {
		query(selector.after(end, inclusive: false))
	}
}

/// Provides a locally scoped version of `query`
///
/// -> content
#let scoped(
	/// A function that will be called with a dictionary containing:
	//
	//   `query-in`: a function that runs a query against the content returned by `func` only
	//   `query-out`: a function that runs a query against the whole doc _except_ the content returned by `func`
	//
	// Should return a content.
	func
) = context [
	#_scope-counter.update(x => x + 1) // Ensure we get unique label names for each call to `scoped`

	#let beg = label("scope-begin:" + str(_scope-counter.get()))
	#let end = label("scope-end:" + str(_scope-counter.get()))

	#hide[] #beg

	#func((
		inside: _inside(beg, end),
		outside: _outside(beg, end),
		before: _before(beg, end),
		after: _after(beg, end)
	))

	#hide[] #end
]
