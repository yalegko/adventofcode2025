import gleam/bool
import gleam/dict
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn max_joltage(line: String) -> Int {
  let jolts =
    line
    |> string.to_graphemes
    |> list.map(int.parse)
    |> result.values

  max_joltage_rec(jolts, 0, 2)
}

fn max_joltage_rec(jolts: List(Int), current_joltage: Int, depth: Int) -> Int {
  use <- bool.guard(depth == 0, current_joltage)

  case jolts {
    [] -> current_joltage
    [head, ..tail] ->
      int.max(
        // Skip
        max_joltage_rec(tail, current_joltage, depth),
        // Take.
        max_joltage_rec(tail, current_joltage * 10 + head, depth - 1),
      )
  }
}

pub fn solve1(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.map(max_joltage)
  |> list.fold(0, int.add)
}

pub fn max_joltage_depth(line: String, depth: Int) -> Int {
  let jolts =
    line
    |> string.to_graphemes
    |> list.map(int.parse)
    |> result.values

  max_joltage_dp(jolts, depth)
}

pub type Key {
  Key(Int, Int)
}

pub fn max_joltage_dp(jolts: List(Int), depth: Int) -> Int {
  let len = list.length(jolts)

  let cache =
    list.range(0, len)
    |> list.map(fn(i) { #(Key(i, 0), 0) })
    |> dict.from_list

  list.range(len - 1, 0)
  |> list.fold(cache, fn(cache, i) {
    list.range(0, depth)
    |> list.fold(cache, fn(cache, d) {
      // cache[i][d] = max(skip, take)
      // skip = cache[i+1][d]
      // take = current + cache[i+1][d-1]

      let assert Ok(current) =
        jolts
        |> list.drop(i)
        |> list.first
      let skip =
        cache
        |> dict.get(Key(i + 1, d))
        |> result.unwrap(or: -999_999_999_999_999)
      let take =
        cache
        |> dict.get(Key(i + 1, d - 1))
        |> result.unwrap(or: -999_999_999_999_999)
      let digit_power =
        int.power(10, int.to_float(d - 1))
        |> result.unwrap(or: -1.0)
        |> float.round

      let cur_max = int.max(skip, current * digit_power + take)
      dict.insert(cache, Key(i, d), cur_max)
    })
  })
  |> dict.get(Key(0, depth))
  |> result.unwrap(or: -1)
}

pub fn solve2(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.map(max_joltage_depth(_, 12))
  |> list.fold(0, int.add)
}
