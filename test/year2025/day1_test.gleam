import gleeunit/should
import year2025/day1

pub fn solve1_test() {
  day1.solve1() |> should.equal(1052)
}

pub fn solve2_test() {
  day1.solve2() |> should.equal(0)
  //5175 is too low
  //7076 is too high
  //6024 also not right
}

pub fn rotate_test() {
  day1.rotate(day1.Rotation(day1.Right, 5), 5) |> should.equal(10)
  day1.rotate(day1.Rotation(day1.Right, 1), 5) |> should.equal(6)
  day1.rotate(day1.Rotation(day1.Right, 98), 2) |> should.equal(0)
  day1.rotate(day1.Rotation(day1.Right, 98), 5) |> should.equal(3)
  day1.rotate(day1.Rotation(day1.Right, 99), 5) |> should.equal(4)
  day1.rotate(day1.Rotation(day1.Right, 94), 5) |> should.equal(99)

  day1.rotate(day1.Rotation(day1.Left, 5), 10) |> should.equal(5)
  day1.rotate(day1.Rotation(day1.Left, 5), 6) |> should.equal(1)
  day1.rotate(day1.Rotation(day1.Left, 5), 4) |> should.equal(99)
  day1.rotate(day1.Rotation(day1.Left, 1), 1) |> should.equal(0)
  day1.rotate(day1.Rotation(day1.Left, 68), 50) |> should.equal(82)
}

pub fn count_zeros_test() {
  let result =
    [
      day1.Rotation(day1.Left, 68),
      day1.Rotation(day1.Left, 30),
      day1.Rotation(day1.Right, 48),
      day1.Rotation(day1.Left, 5),
      day1.Rotation(day1.Right, 60),
      day1.Rotation(day1.Left, 55),
      day1.Rotation(day1.Left, 1),
      day1.Rotation(day1.Left, 99),
      day1.Rotation(day1.Right, 14),
      day1.Rotation(day1.Left, 82),
    ]
    |> day1.count_zeros(50)

  result.0 |> should.equal(3)
}

pub fn count_passing_zeros_test() {
  day1.count_passing_zeros(day1.Rotation(day1.Right, 5), 5) |> should.equal(0)
  day1.count_passing_zeros(day1.Rotation(day1.Right, 105), 5) |> should.equal(1)
  day1.count_passing_zeros(day1.Rotation(day1.Right, 95), 5) |> should.equal(1)
  day1.count_passing_zeros(day1.Rotation(day1.Left, 205), 95) |> should.equal(2)
  day1.count_passing_zeros(day1.Rotation(day1.Left, 100), 95) |> should.equal(1)
  day1.count_passing_zeros(day1.Rotation(day1.Left, 195), 95) |> should.equal(1)
}
