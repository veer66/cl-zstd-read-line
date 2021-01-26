;;;; zstd-read-line.lisp

(in-package #:zstd-read-line)

(print (type-of (namestring
	 (asdf:system-relative-pathname :zstd-read-line
					"zstd_read_line/target/release/zstd_read_line"))))

(define-foreign-library zstd_read_line
  (:win32 #.(namestring
	   (asdf:system-relative-pathname :zstd-read-line
					  "zstd_read_line/target/release/zstd_read_line.dll")))
  (:unix #.(namestring
	  (asdf:system-relative-pathname :zstd-read-line
					 "zstd_read_line/target/release/libzstd_read_line.so")))
  (t (:default "zstd_read_line")))

(use-foreign-library zstd_read_line)

(defcfun ("zstd_line_read_new" create-reader*) :pointer (zstd_archive_path :string))
(defcfun ("zstd_line_read" zstd-read-line*) :pointer (reader :pointer))
(defcfun ("zstd_line_read_delete_line" delete-line) :void (line :pointer))
(defcfun ("zstd_line_read_delete" close-reader) :void (reader :pointer))

(define-condition unable-to-open-archive (error)
  ((archive-path :initarg archive-path
		 :reader archive-path)))

(defun create-reader (zstd-archive-path)
  (let ((reader (create-reader* zstd-archive-path)))
    (if (null-pointer-p reader)
	(error 'unable-to-open-archive :archive-path zstd-archive-path)
	reader)))

(defun zstd-read-line (reader)
  (let ((buf (zstd-read-line* reader)))
    (unless (null-pointer-p buf)
      (let ((line (foreign-string-to-lisp buf)))
	(delete-line buf)
	line))))
