import gleam/bool
import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn create_range(line: String) -> List(String) {
  let assert [Ok(a), Ok(b)] =
    line
    |> string.split("-")
    |> list.map(int.parse)

  list.range(a, b)
  |> list.map(int.to_string)
}

fn repeats_twice(num: String) -> Bool {
  let len = string.length(num)
  use <- bool.guard(len % 2 != 0, False)

  let left = string.slice(num, 0, len / 2)
  let right = string.slice(num, len / 2, len)
  left == right
}

fn solve(input: String, is_invalid: fn(String) -> Bool) -> Int {
  input
  |> string.split(",")
  |> list.flat_map(create_range)
  |> list.filter(is_invalid)
  |> list.map(int.parse)
  |> result.values
  |> list.fold(0, int.add)
}

pub fn solve1(input: String) -> Int {
  solve(input, repeats_twice)
}

pub fn repeats_same_number(str: String) -> Bool {
  let len = string.length(str)
  use <- bool.guard(len < 2, False)

  let possible_parts =
    list.range(1, len / 2)
    |> list.filter(fn(l) { len % l == 0 })

  possible_parts
  |> list.any(fn(part_len) {
    let num_parts = len / part_len
    let part = string.slice(str, 0, part_len)
    str == string.repeat(part, num_parts)
  })
}

pub fn solve2(input: String) -> Int {
  solve(input, repeats_same_number)
}
