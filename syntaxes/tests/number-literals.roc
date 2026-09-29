# SYNTAX TEST "source.roc" "Number literals"

inferred = 5
#          ^ constant.numeric.roc

explicit_u8 = 5.U8
#             ^^^^ constant.numeric.roc

char_to_u8 = 'a'.U8
#            ^^^ string.quoted.single.char.roc

hex = 0x5
#     ^^^ constant.numeric.roc

hex_with_explicit_type = 0x5.U8
#                        ^^^^^^ constant.numeric.roc

octal = 0o5
#       ^^^ constant.numeric.roc

octal_with_explicit_type = 0o5.U8
#                          ^^^^^^ constant.numeric.roc

binary = 0b0101
#        ^^^^^^ constant.numeric.roc

binary_with_explicit_type = 0b0101.U8
#                           ^^^^^^^^^ constant.numeric.roc
