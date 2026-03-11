;;;; cl-constant-compare.asd
;;;; Constant-time byte comparison
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(asdf:defsystem #:cl-constant-compare
  :description "Constant-time byte comparison to resist timing attacks"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "constant-compare")))))
