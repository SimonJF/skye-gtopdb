open Episql_types
(* Using the Episql library, converts an SQL schema into a Links table definition *)

type field_name = string

type links_type =
  | Links_string
  | Links_boolean
  | Links_list of links_type
  | Links_integer
  | Links_float
  | Links_char
  | Links_date

let rec show_links_type = function
  | Links_string -> "String"
  | Links_boolean -> "Bool"
  | Links_list ty -> Printf.sprintf "[%s]" (show_links_type ty)
  | Links_integer -> "Int"
  | Links_float -> "Float"
  | Links_char -> "Char"
  | Links_date -> "String"

type field = (field_name * links_type)

type links_table = {
  table_name: string;
  table_fields: field list
}


let as_links_type = function
  | `Boolean -> Some Links_boolean
  | `Real -> Some Links_float
  | `Double_precision -> Some Links_float
  | `Smallint -> Some Links_integer
  | `Integer -> Some Links_integer
  | `Bigint -> Some Links_integer (* May not be sound. *)
  | `Text -> Some Links_string
  | `Char _ -> Some Links_string
  | `Varchar _ -> Some Links_string
  | `Numeric _ -> Some Links_float (* May want to revisit. *)
  | `Time _ -> Some Links_integer
  | `Date -> Some Links_date
  | `Timestamp _ -> Some Links_integer
  | _ -> None

let convert_table (sql_tbl: Episql_types.table) : links_table =
  let convert_item = function
    | Column c ->
        begin
          match as_links_type c.column_type with
            | Some links_ty -> [(c.column_name, links_ty)]
            | None -> []
        end
    | _ -> [] in

  let (_, name) = sql_tbl.table_qname in
  let fields =
    sql_tbl.table_items
    |> List.map convert_item
    |> List.concat in
  { table_name = name; table_fields = fields }

let convert_statements stmts =
  let convert_statement = function
    | Create_table tbl -> [convert_table tbl]
    | _ -> [] in

  stmts
    |> List.map convert_statement
    |> List.concat


let show_links_tables tables =
  let show_links_table table =
    let field_str =
      table.table_fields
      |> List.map (fun (n, ty) ->
          Printf.sprintf "%s: %s" n (show_links_type ty))
      |> String.concat ", " in

    let name = table.table_name in
    Printf.sprintf "var %s = table \"%s\" with (%s) from db;" name name field_str in

  tables
  |> List.map show_links_table
  |> String.concat "\n\n"


let () =
  let filename =
    if (Array.length Sys.argv < 2) then
      let () = Printf.printf "Usage: ./sql_to_linq <schema>\n" in
      (exit 1) else Sys.argv.(1) in
  Episql.parse_file filename
  |> convert_statements
  |> show_links_tables
  |> Printf.printf "%s\n"

