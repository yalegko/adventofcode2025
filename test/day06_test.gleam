import day06
import simplifile

pub fn solve_test() {
  let assert Ok(input) = simplifile.read("input/day06/test.txt")
  assert day06.solve1(input) == 4_277_556
  let assert Ok(input) = simplifile.read("input/day06/input.txt")
  assert day06.solve1(input) == 7_326_876_294_741

  let assert Ok(input) = simplifile.read("input/day06/test.txt")
  assert day06.solve2(input) == 3_263_827
  let assert Ok(input) = simplifile.read("input/day06/input.txt")
  assert day06.solve2(input) == 10_756_006_415_204
}
