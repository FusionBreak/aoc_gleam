import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub type Direction {
  Left
  Right
}

pub type Rotation {
  Rotation(direction: Direction, number: Int)
}

pub fn solve1() {
  let starting_point = 50
  let rotations = parse("input/2025/day1_1.txt")

  let result =
    rotations
    |> count_passing_zeros(starting_point)

  result.0
}

pub fn solve2() {
  let starting_point = 50
  let rotations = parse("input/2025/day1_1.txt")

  let result =
    rotations
    |> count_passing_zeros(starting_point)

  TODO
}

pub fn rotate(rotation: Rotation, position: Int) {
  case rotation.direction {
    Left -> {
      let new_position = position |> int.subtract(rotation.number % 100)
      case new_position < 0 {
        False -> new_position
        True -> new_position |> int.add(100)
      }
    }
    Right -> {
      let new_position = position |> int.add(rotation.number % 100)
      case new_position > 99 {
        False -> new_position
        True -> new_position |> int.subtract(100)
      }
    }
  }
}

pub fn count_passing_zeros(rotations: List(Rotation), starting_point: Int) {
  let zeros =
    rotations
    |> list.map_fold(starting_point, fn(current_position, i) {
      let new_position = rotate(i, current_position)
      let passing_zeros = TODO

      #(new_position, #(new_position, passing_zeros))
    })

  let ending_zeros = zeros.1 |> list.count(fn(x) { x.0 == 0 })
  let passing_zeros =
    zeros.1 |> list.map(fn(x) { x.1 }) |> list.fold(0, int.add)

  #(ending_zeros, passing_zeros)
}

fn parse(path: String) {
  case simplifile.read(path) {
    Ok(content) ->
      content
      |> string.split("\n")
      |> list.filter(fn(s) { s != "" })
      |> list.map(parse_line)
    Error(_) -> panic as "file doesnt exist"
  }
}

fn parse_line(line: String) {
  let direction =
    line
    |> string.first()
    |> result.unwrap("R")
    |> parse_direction()
    |> result.unwrap(Right)
  let number = line |> string.drop_start(1) |> int.parse |> result.unwrap(0)

  Rotation(direction, number)
}

fn parse_direction(input: String) {
  case input {
    "R" -> Ok(Right)
    "L" -> Ok(Left)
    _ -> Error("No valid string. It should be R or L.")
  }
}
