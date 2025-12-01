import day01
import simplifile

pub fn solve_test() {
  let assert Ok(example) = simplifile.read("input/day01/test.txt")
  assert day01.solve1(example) == 3

  let assert Ok(input) = simplifile.read("input/day01/input.txt")
  assert day01.solve1(input) == 962

  assert day01.solve2("L1000") == 10
  assert day01.solve2("R1000") == 10
  assert day01.solve2("R1000\nL1000") == 20

  assert day01.solve2("L50") == 1
  assert day01.solve2("R50") == 1
  assert day01.solve2("L150") == 2
  assert day01.solve2("R150") == 2
  assert day01.solve2("L250") == 3
  assert day01.solve2("R250") == 3

  assert day01.solve2("L50\nR1000") == 11
  assert day01.solve2("R1050") == 11
  assert day01.solve2("L50\nL100") == 2

  let assert Ok(example) = simplifile.read("input/day01/test.txt")
  assert day01.solve2(example) == 6

  let assert Ok(example) = simplifile.read("input/day01/input.txt")
  assert day01.solve2(example) == 5782
}
