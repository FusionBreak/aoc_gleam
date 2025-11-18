import day2
import gleam/io
import gleam/list
import gleam/string

pub fn solve1_test() {
  assert day2.solve1() == 549
}

pub fn solve2_test() {
  assert day2.solve2() == 589
  //578 is too low.
  //592 is too high.
}

pub fn calc_distances_test() {
  let test_cases = [
    #([7, 6, 4, 2, 1], [-1, -2, -2, -1]),
    #([1, 2, 7, 8, 9], [1, 5, 1, 1]),
    #([9, 7, 6, 2, 1], [-2, -1, -4, -1]),
    #([1, 3, 2, 4, 5], [2, -1, 2, 1]),
    #([8, 6, 4, 4, 1], [-2, -2, 0, -3]),
    #([1, 3, 6, 7, 9], [2, 3, 1, 2]),
  ]

  test_cases
  |> list.each(fn(x) {
    let result = day2.calc_distances(x.0)
    assert result == x.1
  })
}

pub fn check_is_safe_test() {
  let test_cases = [
    #([1, 2, 2, 1], day2.Safe),
    #([-1, -5, -1, -1], day2.Unsafe),
    #([2, 1, 4, 1], day2.Unsafe),
    #([-2, 1, -2, -1], day2.Unsafe),
    #([2, 2, 0, 3], day2.Unsafe),
    #([-2, -3, -1, -2], day2.Safe),
  ]

  test_cases
  |> list.each(fn(x) {
    let result = day2.check_is_safe(x.0)
    assert result == x.1
  })
}

pub fn with_tolerance_test() {
  let test_cases = [
    #([7, 6, 4, 2, 1], day2.Safe),
    #([1, 2, 7, 8, 9], day2.Unsafe),
    #([9, 7, 6, 2, 1], day2.Unsafe),
    #([1, 3, 2, 4, 5], day2.Safe),
    #([8, 6, 4, 4, 1], day2.Safe),
    #([1, 3, 6, 7, 9], day2.Safe),
  ]

  test_cases
  |> list.each(fn(x) {
    let result = day2.with_tolerance(x.0)

    case result == x.1 {
      True -> Nil
      False -> {
        io.println("=== TEST FAILED ===")
        io.println("Values: " <> string.inspect(x.0))
        io.println("Expected: " <> string.inspect(x.1))
        io.println("Got: " <> string.inspect(result))
        io.println("==================")
      }
    }

    assert result == x.1
  })
}
