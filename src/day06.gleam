import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Problem =
  #(String, List(Int))

fn parse(input: String) -> List(Problem) {
  input
  |> string.split("\n")
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(string.trim)
    |> list.filter(fn(s) { !string.is_empty(s) })
  })
  |> list.transpose
  |> list.map(fn(problem) {
    let assert [op, ..rev_nums] = problem |> list.reverse
    let nums =
      rev_nums
      |> list.reverse
      |> list.map(int.parse)
      |> result.values
    assert list.length(rev_nums) == list.length(nums)
    #(op, nums)
  })
}

fn calc(p: Problem) -> Int {
  let #(op, nums) = p
  case op {
    "+" -> nums |> list.fold(0, int.add)
    "*" -> nums |> list.fold(1, int.multiply)
    _ -> panic as "unknown operation"
  }
}

pub fn solve1(input: String) -> Int {
  input
  |> parse
  |> list.map(calc)
  |> list.fold(0, int.add)
}

fn is_empty_column(col) -> Bool {
  col |> list.all(fn(c) { c == " " })
}

fn but_last(l: List(String)) -> List(String) {
  let assert [_last, ..rest] = list.reverse(l)
  list.reverse(rest)
}

fn parse_problem2(matrix: List(List(String))) -> Problem {
  let op =
    matrix
    |> list.first
    |> result.unwrap(or: [])
    |> list.last
    |> result.unwrap("invalid matrix")

  let nums =
    matrix
    |> list.map(but_last)
    |> list.map(fn(digits) {
      digits
      |> string.join("")
      |> string.trim
      |> int.parse
    })
    |> result.values

  #(op, nums)
}

fn parse2(input: String) -> List(Problem) {
  input
  |> string.split("\n")
  |> list.map(string.to_graphemes)
  |> list.transpose
  |> list.fold(#([], []), fn(acc, col) {
    let #(cur, acc) = acc
    case is_empty_column(col) {
      True -> #([], list.append(acc, [cur]))
      False -> #(list.append(cur, [col]), acc)
    }
  })
  |> fn(res) {
    let #(cur, acc) = res
    list.append(acc, [cur])
  }
  |> list.map(parse_problem2)
}

pub fn solve2(input: String) -> Int {
  input
  |> parse2
  |> list.map(calc)
  |> list.fold(0, int.add)
}
