# SYNTAX TEST "source.roc" "Imports"

import "../README.md" as readme : Str
# <------ keyword.control.roc
#      ^^^^^^^^^^^^^^ string.quoted.double.roc
#                     ^^ keyword.control.roc
#                        ^^^^^^ variable.other.roc
#                               ^  punctuation.colon.roc
#                                 ^^^ storage.type.roc

import pkg.MyModule exposing [my_function, MyType]
# <---- keyword.control.roc
#      ^^^ variable.other.roc
#                   ^^^^^^^^ keyword.control.roc
#                             ^^^^^^^^^^^ variable.other.roc
#                                          ^^^^^^ storage.type.roc
