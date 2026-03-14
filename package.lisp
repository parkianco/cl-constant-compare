;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; package.lisp
;;;; Package definition for cl-constant-compare
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(defpackage #:cl-constant-compare
  (:use #:cl)
  (:export
   ;; Comparison operations
   #:constant-time-equal
   #:secure-compare
   #:timing-safe-equal))
