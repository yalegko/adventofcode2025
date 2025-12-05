import day05
import simplifile

pub fn solve_test() {
  let assert Ok(input) = simplifile.read("input/day05/test.txt")
  assert day05.solve1(input) == 3
  let assert Ok(input) = simplifile.read("input/day05/input.txt")
  assert day05.solve1(input) == 828

  let assert Ok(input) = simplifile.read("input/day05/test.txt")
  assert day05.solve2(input) == 14
  let assert Ok(input) = simplifile.read("input/day05/input.txt")
  assert day05.solve2(input) == 352_681_648_086_146
}
