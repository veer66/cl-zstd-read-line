;;;; zstd-read-line.asd

(asdf:defsystem #:zstd-read-line
  :description "zstd-read-line is a zstd_read_line's wrapper for Common Lisp"
  :author "Vee Satayamas <5ssgdxltv@relay.firefox.com>"
  :license  "GPL-3.0"
  :version "0.2.0"
  :serial t
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "zstd-read-line"))
  :build-operation "program-op"
  :build-pathname "build.bash")
