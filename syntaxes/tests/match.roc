# SYNTAX TEST "source.roc" "Match expressions"

# Simple match on tags, payload and wildcard
simple_match = |color| {
    match color {
        Red => "Red"
        Ok(value) => "Success: ${value}"
        Bar => "Just Bar"
        _ => "other"
    }
}

# Multiple patterns and guards
multi_pattern = |x| {
    match x {
        1 | 2 | 3 => "small"
        n if n > 10 => "big"
        _ => "medium"
    }
}

# Match on records
match_record = |person| {
    match person {
        { name: "Alice" } => "Hi Alice"
        { name: "Bob", age: a } if a > 30 => "Old Bob"
        { x, y } => x + y
        _ => "Someone else"
    }
}

# Match on tuples
match_tuple = |pair| {
    match pair {
        (1, 2) => "one two"
        (x, _) => x
    }
}

# Match on lists with spread and pattern alias
match_list = |lst| {
    match lst {
        [] => "empty"
        [x] => "single: ${x}"
        [1, ..] => "starts with 1"
        [.., 1] => "ends with 1"
        [x, .. as tail] => "head: ${x}"
        _ => "other list"
    }
}
