import day03
import simplifile

pub fn main() -> Nil {
  let assert Ok(example) = simplifile.read("input/day03/input.txt")

  echo day03.solve2(example)

  Nil
}
