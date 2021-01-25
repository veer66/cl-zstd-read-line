;;;; zstd-read-line.asd

(asdf:defsystem #:zstd-read-line
  :description "Describe zstd-read-line here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "zstd-read-line")))
