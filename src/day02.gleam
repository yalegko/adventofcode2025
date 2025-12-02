import gleam/bool
import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn create_range(line: String) -> List(Int) {
  let assert [Ok(a), Ok(b)] =
    line
    |> string.split("-")
    |> list.map(int.parse)

  list.range(a, b)
}

pub fn solve1(input: String) -> Int {
  input
  |> string.split(",")
  |> list.map(create_range)
  |> list.map(list.map(_, int.to_string))
  |> list.flat_map(
    list.filter(_, fn(num) {
      let len = string.length(num)
      use <- bool.guard(len % 2 != 0, False)

      let left = string.slice(num, 0, len / 2)
      let right = string.slice(num, len / 2, len)
      left == right
    }),
  )
  |> list.map(int.parse)
  |> result.values
  |> list.fold(0, int.add)
}

pub fn repeats_same_number(str: String) -> Bool {
  let len = string.length(str)
  use <- bool.guard(len < 2, False)

  list.range(1, len / 2)
  |> list.filter(fn(l) { len % l == 0 })
  |> list.any(fn(part_len) {
    let num_parts = len / part_len
    let part = string.slice(str, 0, part_len)

    str == string.repeat(part, num_parts)
  })
}

pub fn solve2(input: String) -> Int {
  input
  |> string.split(",")
  |> list.map(create_range)
  |> list.map(list.map(_, int.to_string))
  |> list.flat_map(list.filter(_, repeats_same_number))
  |> list.map(int.parse)
  |> result.values
  |> list.fold(0, int.add)
}
