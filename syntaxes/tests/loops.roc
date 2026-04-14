# SYNTAX TEST "source.roc" "Loops"

# For loop
simple_for = |list| {
    for item in list {
        echo!(item)
    }
}

# For loop with destructuring
for_destruct = |pairs| {
    var $sum = 0
    for (a, b) in pairs {
        $sum = $sum + a + b
    }
    $sum
}

# While loop
simple_while = |limit| {
    var $count = 0
    while $count < limit {
        $count = $count + 1
    }
    $count
}

# For loop with break
for_break = |items| {
    var $found = False
    for item in items {
        if item == "target" {
            $found = True
            break
        }
    }
    $found
}
