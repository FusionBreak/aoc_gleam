import gleam/int
import gleam/list
import gleam/string
import simplifile

pub fn solve1() -> Int {
  let input = parse("input/2024/day1_1.txt")
  let left = input |> list.map(fn(p) { p.0 })
  let right = input |> list.map(fn(p) { p.1 })

  left
  |> list.sort(int.compare)
  |> list.zip(right |> list.sort(int.compare))
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> list.fold(0, fn(sum, current) { sum + current })
}

pub fn solve2() -> Int {
  let input = parse("input/2024/day1_2.txt")
  let left = input |> list.map(fn(p) { p.0 })
  let right = input |> list.map(fn(p) { p.1 })

  left
  |> list.map(fn(l) {
    let count =
      right
      |> list.count(fn(x) { x == l })

    l * count
  })
  |> list.fold(0, fn(sum, current) { sum + current })
}

pub fn parse(path: String) {
  let parse_part_halve = fn(part: String) {
    case int.parse(part) {
      Ok(num) -> num
      Error(_) -> 0
    }
  }

  let parse_part = fn(parts: List(String)) {
    let left = case parts |> list.first {
      Ok(first) -> parse_part_halve(first)
      Error(_) -> 0
    }

    let right = case parts |> list.last {
      Ok(last) -> parse_part_halve(last)
      Error(_) -> 0
    }

    #(left, right)
  }

  case simplifile.read(path) {
    Ok(content) -> {
      let lines =
        content
        |> string.split("\n")
        |> list.filter(fn(line) { line != "" })

      let parts =
        lines
        |> list.map(fn(l) { string.split(l, " ") })
        |> list.map(parse_part)
      parts
    }

    Error(e) -> {
      echo simplifile.describe_error(e)
      []
    }
  }
}
