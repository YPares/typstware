#let _scope-counter = state("scope-counter", 0)

#let _inside(beg, end) = selector => {
	selector.after(beg, inclusive: false).before(end, inclusive: false)
}

#let _outside(beg, end) = selector => {
	selector.before(beg, inclusive: false).or(selector.after(end, inclusive: false))
}

#let _before(beg, end) = (inclusive: false, selector) => {
	if inclusive {
		selector.before(end, inclusive: false)
	} else {
		selector.before(beg, inclusive: false)
	}
}

#let _after(beg, end) = (inclusive: false, selector) => {
	if inclusive {
		selector.after(beg, inclusive: false)
	} else {
		selector.after(end, inclusive: false)
	}
}

/// Provides a locally scoped version of `query`
///
/// -> content
#let scoped(
	/// A function that will be called with a dictionary `scope` containing several operations on selectors:
	//
	//    - `(scope.inside)(s)`: limits the selector `s` to elements appearing inside the scope (ie. inside the content returned by `func`)
	//    - `(scope.outside)(s)`: limits the selector `s` to elements appearing outside the scope
	//    - `(scope.before)(s)`: limits the selector `s` to elements appearing before the scope (excluded)
	//    - `(scope.after)(s)`: limits the selector `s` to elements appearing after the scope (excluded)
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
