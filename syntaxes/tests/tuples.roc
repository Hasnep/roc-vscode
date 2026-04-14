# SYNTAX TEST "source.roc" "Tuples"

# Tuple with 2 elements
pair = ("Roc", 1)
#      ^ punctuation.brackets.round.roc
#               ^ punctuation.brackets.round.roc

# Nested tuples
nested_tuple = ((1, 2), (3, 4))
#              ^       punctuation.brackets.round.roc
#               ^       punctuation.brackets.round.roc
#                    ^    punctuation.brackets.round.roc
#                       ^     punctuation.brackets.round.roc
#                            ^  punctuation.brackets.round.roc
#                             ^  punctuation.brackets.round.roc
