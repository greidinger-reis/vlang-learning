module triangles

enum Triangle {
	isosceles
	scalene
	equilateral
}

enum ParseTriangleErrorKind {
	not_enough_sides
	invalid_sides
}

struct ParseTriangleError {
	Error
	kind ParseTriangleErrorKind
}

fn (err ParseTriangleError) msg() string {
	return 'Invalid triangle: ${err.kind}'
}

fn parse_triangle(maybe_triangle string) !Triangle {
	sides_str := maybe_triangle.split(',')

	if sides_str.len < 3 {
		return ParseTriangleError{
			kind: ParseTriangleErrorKind.not_enough_sides
		}
	}

	sides := sides_str.map(fn (it string) !f32 {
		as_float := it.f32()

		if as_float > 0.0 {
			return as_float
		} else {
			return ParseTriangleError{
				kind: ParseTriangleErrorKind.invalid_sides
			}
		}
	})

	a := sides[0]!
	b := sides[1]!
	c := sides[2]!

	if a == b && b == c {
		return Triangle.equilateral
	} else if a == b || b == c || a == c {
		return Triangle.isosceles
	} else {
		return Triangle.scalene
	}
}

fn main() {
	triangles := [
		'3,4,5',
		'3,3,3',
		'3,4,6',
		'-1,4,5',
		'3,4',
		'3,4,5,6',
		'3,4,5,6,7',
	]

	for triangle in triangles {
		parsed := parse_triangle(triangle) or {
			println(err)
			continue
		}
		match parsed {
			.isosceles {
				println('${triangle} is isosceles.')
			}
			.scalene {
				'${triangle} is scalene.'
			}
			.equilateral {
				'${triangle} is equilateral.'
			}
		}
	}
}
