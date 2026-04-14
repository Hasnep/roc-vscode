# SYNTAX TEST "source.roc" "Functions and Lambdas"

# Simple function
simple = |x| x + 1
#        ^ punctuation.other.roc
#          ^ punctuation.other.roc

# Zero-parameter function
zero_param = || {
    #        ^ punctuation.other.roc
    #         ^ punctuation.other.roc
    1 + 1
}

# Function with type annotation
with_type : I64 -> I64
with_type = |x| x * 2

# Multi-parameter type annotation
complex_type : I64, I64 -> I64
complex_type = |x, y| x + y

# Lambda with destructuring
lambda_destruct = |(a, b)| a + b
#                  ^ punctuation.brackets.round.roc
#                       ^ punctuation.brackets.round.roc

# Lambda with record destructuring
lambda_rec_destruct = |{ x, y }| x + y
#                      ^ punctuation.brackets.curly.roc
#                             ^ punctuation.brackets.curly.roc

# Anonymous function in call
inline_lambda = List.map([1, 2, 3], |x| x * 2)
#                                   ^ punctuation.other.roc
#                                     ^ punctuation.other.roc

# Tag construction (call-shaped)
success = Ok(100)

# Chained lambdas
chained = |x|
    x
        |> List.map(|n| n + 1)
        |> List.filter(|n| n > 5)
