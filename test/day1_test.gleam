import day1
import gleam/list

pub fn solve_test() {
  assert day1.solve_day1() == 1_882_714
}

pub fn solve2_test() {
  assert day1.solve_day2() == 19_437_052
}

pub fn list_test() {
  let left = [3, 4, 2, 1, 3, 3]
  let right = [4, 3, 5, 3, 9, 3]

  let result =
    left
    |> list.map(fn(l) {
      echo l

      let count =
        right
        |> list.count(fn(x) { x == l })

      echo count

      l * count
    })
    |> list.fold(0, fn(sum, current) { sum + current })

  assert result == 31
}
