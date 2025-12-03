import gleam/int
import gleam/list
import gleam/string
import simplifile

pub type IsSafe {
  Unsafe
  Safe
}

pub fn solve1() -> Int {
  let input = parse("input/2024/day2_1.txt")

  input
  |> list.map(calc_distances)
  |> list.map(check_is_safe)
  |> list.count(fn(is_safe) { is_safe == Safe })
}

pub fn solve2() -> Int {
  let input = parse("input/2024/day2_2.txt")

  input
  |> list.map(with_tolerance)
  |> list.count(fn(is_safe) { is_safe == Safe })
}

pub fn calc_distances(values: List(Int)) -> List(Int) {
  values
  |> list.window(2)
  |> list.map(fn(window) {
    let first = case window |> list.first {
      Ok(f) -> f
      Error(_) -> 0
    }

    let second = case window |> list.last {
      Ok(s) -> s
      Error(_) -> 0
    }

    second - first
  })
}

pub fn check_is_safe(distances: List(Int)) -> IsSafe {
  let has_too_large = list.any(distances, fn(d) { d > 3 || d < -3 })

  let has_zero = list.any(distances, fn(d) { d == 0 })

  let has_positive = list.any(distances, fn(d) { d > 0 })
  let has_negative = list.any(distances, fn(d) { d < 0 })
  let has_mixed_signs = has_positive && has_negative

  case has_too_large || has_zero || has_mixed_signs {
    True -> Unsafe
    False -> Safe
  }
}

pub fn with_tolerance(values: List(Int)) -> IsSafe {
  let distances = calc_distances(values)
  let is_safe = check_is_safe(distances)

  case is_safe {
    Safe -> Safe
    Unsafe -> check_with_tolerance(values, 0)
  }
}

fn check_with_tolerance(values: List(Int), index: Int) -> IsSafe {
  let max_index = list.length(values)

  case index <= max_index {
    False -> Unsafe
    True -> {
      let modified_values = remove_at_index(values, index)
      let distances = calc_distances(modified_values)
      let is_safe = check_is_safe(distances)
      case is_safe {
        Safe -> Safe
        Unsafe -> check_with_tolerance(values, index + 1)
      }
    }
  }
}

fn remove_at_index(lst: List(a), target_index: Int) -> List(a) {
  list.index_fold(lst, [], fn(acc, item, current_index) {
    case current_index == target_index {
      True -> acc
      False -> list.append(acc, [item])
    }
  })
}

pub fn parse(path: String) -> List(List(Int)) {
  let parse_line = fn(line: String) {
    line
    |> string.split(" ")
    |> list.map(fn(x) {
      case int.parse(x) {
        Ok(number) -> number
        Error(_) -> 0
      }
    })
  }

  case simplifile.read(path) {
    Ok(content) ->
      content
      |> string.split("\n")
      |> list.filter(fn(s) { s != "" })
      |> list.map(parse_line)
      |> list.filter(fn(line) { !list.is_empty(line) })
    Error(_) -> [[]]
  }
}
