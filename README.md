# cl-constant-compare

Constant-time byte comparison for Common Lisp to resist timing attacks.

## Features

- Constant-time comparison regardless of where differences occur
- No early exit on mismatch
- Length-safe comparison
- Zero external dependencies

## Installation

```lisp
(asdf:load-system :cl-constant-compare)
```

## Usage

```lisp
(use-package :cl-constant-compare)

;; Compare byte arrays
(constant-time-equal received-mac computed-mac)

;; Alias
(secure-compare token1 token2)

;; Works with strings and sequences too
(timing-safe-equal "secret1" "secret2")
```

## Security

These functions are designed to prevent timing attacks by:

1. Always comparing all bytes (no early exit)
2. Using bitwise operations with predictable timing
3. Handling length differences without timing leakage

## API

- `constant-time-equal a b` - Compare byte arrays
- `secure-compare a b` - Alias for constant-time-equal
- `timing-safe-equal a b` - Compare any sequences (converts internally)

## When to Use

- MAC verification
- Password/token comparison
- Any security-sensitive comparison where timing could leak information

## License

BSD-3-Clause. Copyright (c) 2024-2026 Parkian Company LLC
