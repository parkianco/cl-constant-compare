;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; cl-constant-compare.asd
;;;; Constant-time byte comparison
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(asdf:defsystem #:cl-constant-compare
  :description "Constant-time byte comparison to resist timing attacks"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "0.1.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "constant-compare")))))

(asdf:defsystem #:cl-constant-compare/test
  :description "Tests for cl-constant-compare"
  :depends-on (#:cl-constant-compare)
  :serial t
  :components ((:module "test"
                :components ((:file "test-constant-compare"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-constant-compare.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
