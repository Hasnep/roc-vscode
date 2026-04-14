# SYNTAX TEST "source.roc" "Number literals"

inferred = 5
#          ^ constant.numeric.roc

explicit_u8 = 5.U8
#             ^^^^ constant.numeric.roc

char_to_u8 = 'a'.U8
#            ^^^ string.quoted.single.char.roc

hex = 0x5
#     ^^^ constant.numeric.roc

octal = 0o5
#       ^^^ constant.numeric.roc

binary = 0b0101
#        ^^^^^^ constant.numeric.roc
