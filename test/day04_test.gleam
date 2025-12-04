import day04
import simplifile

pub fn solve_test() {
  let assert Ok(input) = simplifile.read("input/day04/test.txt")
  assert day04.solve1(input) == 13
  let assert Ok(input) = simplifile.read("input/day04/input.txt")
  assert day04.solve1(input) == 1320

  let assert Ok(input) = simplifile.read("input/day04/test.txt")
  assert day04.solve2(input) == 43
  let assert Ok(input) = simplifile.read("input/day04/input.txt")
  assert day04.solve2(input) == 8354
}
