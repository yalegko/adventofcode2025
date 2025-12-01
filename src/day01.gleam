import gleam/int
import gleam/list
import gleam/string

fn mod(a, n: Int) -> Int {
  case a >= 0 {
    True -> a % n
    False -> mod(a + n, n)
  }
}

fn into_dir_pair(line: String) -> #(Int, Int) {
  let #(d, n) = case line {
    "R" <> n -> #(1, n)
    "L" <> n -> #(-1, n)
    _ -> panic as "unreachable"
  }

  let assert Ok(val) = int.parse(n)
  #(d, val)
}

pub fn solve1(input: String) -> Int {
  let start = 50

  let #(_, positions) =
    input
    |> string.split("\n")
    |> list.map(into_dir_pair)
    |> list.map_fold(start, fn(pos, p) {
      let next = { pos + p.0 * p.1 } |> mod(100)
      #(next, next)
    })

  positions
  |> list.count(fn(pos) { pos == 0 })
}

pub fn solve2(input: String) -> Int {
  let start = 50

  let #(_, positions) =
    input
    |> string.split("\n")
    |> list.map(into_dir_pair)
    |> list.map_fold(start, fn(pos, p) {
      let raw_pos = pos + p.0 * p.1

      let num_clicks = case raw_pos {
        x if x >= 100 -> raw_pos / 100
        x if x < 0 && pos != 0 -> { -1 * raw_pos } / 100 + 1
        x if x < 0 -> { -1 * raw_pos } / 100
        0 -> 1
        _ -> 0
      }

      let next_pos = raw_pos |> mod(100)
      #(next_pos, num_clicks)
    })

  positions
  |> list.fold(0, fn(a, b) { a + b })
}
