;;;; zstd-read-line.lisp

(in-package #:zstd-read-line)

(define-foreign-library zstd_read_line
  (:win32 (:default "zstd_read_line/target/release/zstd_read_line"))
  (t (:default "zstd_read_line/target/release/libzstd_read_line")))

(use-foreign-library zstd_read_line)

(defcfun ("zstd_line_read_new" create-reader) :pointer (zstd_archive_path :string))
(defcfun ("zstd_line_read" zstd-read-line) :string (reader :pointer))
(defcfun ("zstd_line_read_delete_line" delete-line) :void (line :string))
(defcfun ("zstd_line_read_delete" close-reader) :void (reader :pointer))


