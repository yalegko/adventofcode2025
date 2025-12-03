import day03
import simplifile

pub fn solve_test() {
  assert day03.max_joltage("987654321111111") == 98
  assert day03.max_joltage("811111111111119") == 89
  assert day03.max_joltage("234234234234278") == 78
  assert day03.max_joltage("818181911112111") == 92

  let assert Ok(example) = simplifile.read("input/day03/test.txt")
  assert day03.solve1(example) == 357
  let assert Ok(example) = simplifile.read("input/day03/input.txt")
  assert day03.solve1(example) == 17_524

  assert day03.max_joltage_depth("987654321111111", 2) == 98
  assert day03.max_joltage_depth("811111111111119", 2) == 89
  assert day03.max_joltage_depth("234234234234278", 2) == 78
  assert day03.max_joltage_depth("818181911112111", 2) == 92

  assert day03.max_joltage_depth("987654321111111", 12) == 987_654_321_111
  assert day03.max_joltage_depth("811111111111119", 12) == 811_111_111_119
  assert day03.max_joltage_depth("234234234234278", 12) == 434_234_234_278
  assert day03.max_joltage_depth("818181911112111", 12) == 888_911_112_111

  let assert Ok(example) = simplifile.read("input/day03/test.txt")
  assert day03.solve2(example) == 3_121_910_778_619
  let assert Ok(example) = simplifile.read("input/day03/input.txt")
  assert day03.solve2(example) == 173_848_577_117_276
}
