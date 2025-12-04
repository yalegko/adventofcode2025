import gleam/bool
import gleam/dict
import gleam/list
import gleam/result
import gleam/string

type Point {
  Point(Int, Int)
}

type Field {
  Field(map: dict.Dict(Point, String), maxx: Int, maxy: Int)
}

fn parse_field(input: String) -> Field {
  let lines =
    input
    |> string.split("\n")
  let maxy = lines |> list.length
  let maxx = lines |> list.first |> result.unwrap(or: "") |> string.length

  let map =
    lines
    |> list.index_map(fn(line, y) {
      line
      |> string.to_graphemes
      |> list.index_map(fn(c, x) { #(Point(x, y), c) })
    })
    |> list.flatten
    |> dict.from_list

  Field(map:, maxx: maxx - 1, maxy: maxy - 1)
}

fn adjacent(p: Point) -> List(Point) {
  let Point(x, y) = p

  [
    #(-1, -1),
    #(0, -1),
    #(1, -1),
    #(-1, 0),
    #(1, 0),
    #(-1, 1),
    #(0, 1),
    #(1, 1),
  ]
  |> list.map(fn(dd) {
    let #(dx, dy) = dd
    Point(x + dx, y + dy)
  })
}

fn weights_map(f: Field) -> dict.Dict(Point, Int) {
  f.map
  |> dict.map_values(fn(p, c) {
    assert c == "@" || c == "."
    use <- bool.guard(c != "@", -1)

    adjacent(p)
    |> list.map(dict.get(f.map, _))
    |> list.count(fn(c) { c == Ok("@") })
  })
}

fn movable(w: Int) -> Bool {
  w != -1 && w < 4
}

pub fn solve1(input: String) -> Int {
  let field = parse_field(input)

  field
  |> weights_map
  |> dict.values
  |> list.count(movable)
}

pub fn solve2(input: String) -> Int {
  let field = parse_field(input)
  let cleaned = clean_field_rec(field)

  field.map
  |> dict.map_values(fn(p, c) {
    let assert Ok(on_clean) = cleaned.map |> dict.get(p)
    c == on_clean
  })
  |> dict.values
  |> list.count(fn(eq) { eq == False })
}

fn clean_field(field: Field) -> #(Field, Bool) {
  let wmap = weights_map(field)

  let have_movable =
    wmap
    |> dict.to_list
    |> list.find(fn(el) {
      let #(_p, w) = el
      movable(w)
    })
  use <- bool.guard(have_movable |> result.is_error, #(field, False))

  let new_map =
    field.map
    |> dict.map_values(fn(p, c) {
      case wmap |> dict.get(p) {
        Ok(w) if w < 4 -> "."
        Ok(_) -> c
        _ -> panic
      }
    })
  #(Field(..field, map: new_map), True)
}

fn clean_field_rec(field: Field) -> Field {
  case clean_field(field) {
    #(cleaned, True) -> clean_field_rec(cleaned)
    #(_, False) -> field
  }
}
