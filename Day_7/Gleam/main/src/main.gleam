import gleam/int.{bitwise_and, bitwise_not, bitwise_or, bitwise_shift_left, bitwise_shift_right}
import gleam/dict.{type Dict}
import gleam/list
import gleam/result
import gleam/string
import simplifile.{read}
import gleam/io

const mask_16 = 0xFFFF

pub fn main() {
  let path = "../../input"
  let assert Ok(contents) = read(from: path)
  
  let instructions = 
    string.split(contents, "\n")
    |> list.filter(fn(line) { line != "" })
    |> list.map(fn(line) {
      let parts = string.split(line, " ")
      let target = list.last(parts) |> result.unwrap("")
      let expr = list.take(parts, list.length(parts) - 2)
      #(target, expr)
    })
    |> dict.from_list

  let #(_final_cache, result_a) = get_value("a", instructions, dict.new())
  
  echo result_a
}

fn get_value(
  wire: String,
  instructions: Dict(String, List(String)),
  cache: Dict(String, Int),
) -> #(Dict(String, Int), Int) {
  case int.parse(wire) {
    Ok(val) -> #(cache, val)
    Error(_) -> {
      case dict.get(cache, wire) {
        Ok(val) -> #(cache, val)
        Error(_) -> {
          let assert Ok(expr) = dict.get(instructions, wire)
          let #(new_cache, res) = eval_expr(expr, instructions, cache)
          #(dict.insert(new_cache, wire, res), res)
        }
      }
    }
  }
}

fn eval_expr(
  expr: List(String),
  instructions: Dict(String, List(String)),
  cache: Dict(String, Int),
) -> #(Dict(String, Int), Int) {
  case expr {
    [val] -> get_value(val, instructions, cache)
    ["NOT", x] -> {
      let #(c, v) = get_value(x, instructions, cache)
      #(c, bitwise_and(bitwise_not(v), mask_16))
    }
    [x, op, y] -> {
      let #(c1, v1) = get_value(x, instructions, cache)
      let #(c2, v2) = get_value(y, instructions, c1)
      let res = case op {
        "AND" -> bitwise_and(v1, v2)
        "OR" -> bitwise_or(v1, v2)
        "LSHIFT" -> bitwise_and(bitwise_shift_left(v1, v2), mask_16)
        "RSHIFT" -> bitwise_shift_right(v1, v2)
        _ -> 0
      }
      #(c2, res)
    }
    _ -> #(cache, 0)
  }
}
