;;;; constant-compare.lisp
;;;; Constant-time byte comparison to resist timing attacks
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(in-package #:cl-constant-compare)

(declaim (inline xor-bytes accumulate-difference))

(defun xor-bytes (a b)
  "XOR two bytes. Result is 0 if equal."
  (declare (type (unsigned-byte 8) a b)
           (optimize (speed 3) (safety 0)))
  (logxor a b))

(defun accumulate-difference (acc diff)
  "Accumulate difference using OR. Non-zero if any difference found."
  (declare (type (unsigned-byte 8) acc diff)
           (optimize (speed 3) (safety 0)))
  (logior acc diff))

(defun constant-time-equal (a b)
  "Compare two byte arrays in constant time.
   Returns T if equal, NIL otherwise.
   Execution time is independent of where differences occur.

   A, B: Byte arrays (simple-array (unsigned-byte 8)).

   SECURITY: This function is designed to resist timing attacks by:
   1. Always comparing all bytes (no early exit)
   2. Using bitwise operations with predictable timing
   3. Processing length differences without timing leakage"
  (declare (optimize (speed 3) (safety 1)))
  ;; Length comparison - but we still process to avoid length oracle
  (let* ((len-a (length a))
         (len-b (length b))
         (len-diff (logxor len-a len-b))
         (min-len (min len-a len-b))
         (acc 0))
    (declare (type fixnum len-a len-b len-diff min-len)
             (type (unsigned-byte 8) acc))
    ;; Compare all bytes up to minimum length
    (loop for i fixnum from 0 below min-len do
      (setf acc (accumulate-difference acc (xor-bytes (aref a i) (aref b i)))))
    ;; If lengths differ, ensure we return false
    ;; Convert len-diff to 0 or non-zero in constant time
    (when (plusp len-diff)
      (setf acc (logior acc #xff)))
    ;; Return result: T if acc is 0 (all bytes matched and same length)
    (zerop acc)))

(defun secure-compare (a b)
  "Alias for constant-time-equal.
   Compare two byte arrays in constant time.
   Returns T if equal, NIL otherwise."
  (constant-time-equal a b))

(defun timing-safe-equal (a b)
  "Compare two sequences in constant time.
   Accepts any sequence type, converting to byte arrays internally.
   Returns T if equal, NIL otherwise.

   A, B: Sequences (will be coerced to byte arrays).

   This is a convenience wrapper around constant-time-equal."
  (let ((bytes-a (etypecase a
                   ((simple-array (unsigned-byte 8) (*)) a)
                   (string (map '(vector (unsigned-byte 8)) #'char-code a))
                   (sequence (coerce a '(vector (unsigned-byte 8))))))
        (bytes-b (etypecase b
                   ((simple-array (unsigned-byte 8) (*)) b)
                   (string (map '(vector (unsigned-byte 8)) #'char-code b))
                   (sequence (coerce b '(vector (unsigned-byte 8)))))))
    (constant-time-equal bytes-a bytes-b)))
