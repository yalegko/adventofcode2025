import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string

type Intervals =
  List(#(Int, Int))

fn parse(input: String) -> #(Intervals, List(Int)) {
  let lines =
    input
    |> string.split("\n")

  let intervals =
    lines
    |> list.take_while(fn(line) { line != "" })
    |> list.map(fn(line) {
      let assert [a, b] =
        line
        |> string.split("-")
        |> list.map(int.parse)
        |> result.values
      #(a, b)
    })

  let products =
    lines
    |> list.drop_while(fn(line) { line != "" })
    |> list.drop(1)
    |> list.map(int.parse)
    |> result.values

  #(intervals, products)
}

fn in_range(range: #(Int, Int), x: Int) -> Bool {
  range.0 <= x && x <= range.1
}

pub fn solve1(input: String) -> Int {
  let #(intervals, products) = parse(input)

  products
  |> list.count(fn(p) { intervals |> list.any(in_range(_, p)) })
}

pub fn merge_ranges(ranges: Intervals) -> Intervals {
  let assert [head, ..tail] = ranges

  tail
  |> list.fold([head], fn(acc, range) {
    let assert [top, ..rest] = acc
    case top.0 <= range.0 && range.0 <= top.1 {
      // Does not touch at all.
      False -> [range, ..acc]
      // `range` lies inside the `top`.
      True if range.1 <= top.1 -> acc
      // Owerlap.
      True if range.1 > top.1 -> [#(top.0, range.1), ..rest]
      // Unreachable.
      _ -> panic
    }
  })
}

fn comare_ranges(range1, range2) {
  let #(a1, b1) = range1
  let #(a2, b2) = range2
  case int.compare(a1, a2) {
    order.Eq -> int.compare(b1, b2)
    o -> o
  }
}

pub fn solve2(input: String) -> Int {
  let #(intervals, _products) = parse(input)

  intervals
  |> list.unique
  |> list.sort(comare_ranges)
  |> merge_ranges
  |> list.map(fn(range) { range.1 - range.0 + 1 })
  |> list.fold(0, int.add)
}
