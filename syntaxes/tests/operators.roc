# SYNTAX TEST "source.roc" "Operators"

x = !True or False and True?
#   ^ keyword.operator.roc
#    ^^^^ constant.language.roc
#         ^^ keyword.operator.roc
#            ^^^^^ constant.language.roc
#                  ^^^ keyword.operator.roc
#                      ^^^^ constant.language.roc
#                          ^ keyword.operator.question.roc

# Postfix question mark
maybe = value?
#            ^ keyword.operator.question.roc

# Chained question mark with accessor
nested = data.get("key")?.get("nested")?
#                       ^ keyword.operator.question.roc
#                                      ^ keyword.operator.question.roc

# Question mark with ?? default
with_default = get_value() ?? 0
#                          ^^ keyword.operator.roc
