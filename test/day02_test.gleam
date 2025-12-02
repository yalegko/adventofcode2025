import day02
import simplifile

pub fn solve_test() {
  let assert Ok(example) = simplifile.read("input/day02/test.txt")
  assert day02.solve1(example) == 1_227_775_554
  let assert Ok(example) = simplifile.read("input/day02/input.txt")
  assert day02.solve1(example) == 29_940_924_880

  assert day02.repeats_same_number("11")
  assert day02.repeats_same_number("111")
  assert day02.repeats_same_number("565656")
  assert day02.repeats_same_number("123123123")
  assert day02.repeats_same_number("1188511885")
  assert day02.repeats_same_number("2121212121")
  assert !day02.repeats_same_number("12")
  assert !day02.repeats_same_number("112")
  assert !day02.repeats_same_number("11211")

  let assert Ok(example) = simplifile.read("input/day02/test.txt")
  assert day02.solve2(example) == 4_174_379_265
  let assert Ok(example) = simplifile.read("input/day02/input.txt")
  assert day02.solve2(example) == 48_631_958_998
}
