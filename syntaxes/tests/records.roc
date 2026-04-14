# SYNTAX TEST "source.roc" "Records"

# Empty record
empty_rec = {}

# Simple record
point = { x: 10, y: 20 }

# Nested records
nested = { outer: { inner: 1, value: 2 } }

# Record update with spread
updated = { ..point, x: 100 }
