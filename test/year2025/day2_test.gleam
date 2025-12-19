import gleeunit/should
import year2025/day2

pub fn solve1_test() {
  day2.solve1() |> should.equal(18_893_502_033)
}

pub fn is_valid_test() {
  day2.is_valid(110_110) |> should.be_false()
  day2.is_valid(44) |> should.be_false()
  day2.is_valid(4444) |> should.be_false()
  day2.is_valid(112_110) |> should.be_true()
  day2.is_valid(69) |> should.be_true()
  day2.is_valid(44_444) |> should.be_true()
}
