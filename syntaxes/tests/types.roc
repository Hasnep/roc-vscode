# SYNTAX TEST "source.roc" "Types and Type Annotations"

# Type annotations on variables
num : I64
num = 42

list_num : List(U64)
list_num = [1, 2, 3]

generic_list : List(a)

pair : (I64, Str)
pair = (42, "answer")

record_type : { x : I64, y : I64 }
record_type = { x: 1, y: 2 }

fn_simple : I64 -> I64
fn_simple = crash ""

fn_multiple_args : I64, Str -> I64
fn_multiple_args = crash ""

higher_order : ((I64 -> I64) -> I64) -> I64
higher_order = crash ""

where_clause : a -> Str where [a.to_str : a -> Str]
where_clause = crash ""

effectful_type : Str => {}
effectful_type = crash ""

blank_type : List(Str) -> Try(I64, _)
blank_type = crash ""

# Types

TypeAlias := { x : I64, y : I64 }

Color : [Red, Green, Blue]

Result : [Ok(I64), Err(Str)]

Maybe(a) : [Some(a), None]

Letters(others) : [A, B, ..others]
