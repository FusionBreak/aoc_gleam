import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn solve1() -> Int {
  let start_and_end_points = parse("input/2025/day2.txt")
  start_and_end_points
  |> list.map(fn(x) {
    get_invalid_ids_from_range(x.0, x.1) |> list.fold(0, int.add)
  })
  |> list.fold(0, int.add)
}

pub fn get_invalid_ids_from_range(start: Int, end: Int) {
  list.range(start, end)
  |> list.filter(fn(number) { !is_valid(number) })
}

pub fn is_valid(id: Int) -> Bool {
  let id_as_string = id |> int.to_string()
  let lenght = id_as_string |> string.length
  let assert Ok(middle) = lenght |> int.add(1) |> int.divide(2)
  let assert Ok(half_lenght) = lenght |> int.divide(2)
  let first_half = id_as_string |> string.slice(0, half_lenght)
  let second_half = id_as_string |> string.slice(middle, half_lenght)

  int.is_odd(lenght) || first_half != second_half
}

fn parse(path: String) {
  let assert Ok(content) = simplifile.read(path)
  content
  |> string.split(",")
  |> list.map(fn(x) {
    let numbers = x |> string.split("-")
    let assert Ok(start) =
      numbers |> list.first() |> result.unwrap("") |> int.parse()
    let assert Ok(end) =
      numbers |> list.last() |> result.unwrap("") |> int.parse()
    #(start, end)
  })
}
