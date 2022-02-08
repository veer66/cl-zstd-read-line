;;;; zstd-read-line.lisp

(in-package #:zstd-read-line)

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
(defcfun ("zstd_line_read" zstd-read-line*)
    :int (reader :pointer) (line-ptr :pointer) (line-len-ptr :pointer))
(defcfun ("zstd_line_read_delete_line" delete-line) :void (line :pointer))
(defcfun ("zstd_line_read_delete" close-reader) :void (reader :pointer))

(define-condition unable-to-open-archive (error)
  ((archive-path :initarg archive-path
		 :reader archive-path)))

(define-condition unable-to-read-archive (error)
  ((archive-path :initarg archive-handler
		 :reader archive-handler)))

(defun create-reader (zstd-archive-path)
  (let ((reader (create-reader* zstd-archive-path)))
    (if (null-pointer-p reader)
	(error 'unable-to-open-archive :archive-path zstd-archive-path)
	reader)))

(defun zstd-read-line (reader)
  (with-foreign-objects ((line-len-ptr :pointer) (line-ptr :pointer))
    (let ((status-code (zstd-read-line* reader line-ptr line-len-ptr)))
      (when (/= status-code 0)
	(error 'unable-to-read-archive :archive-handler reader))
      (let* ((line-len (mem-ref line-len-ptr :int))
	     (line (mem-ref line-ptr :pointer)))
	(unless (null-pointer-p line)
	  (let ((lisp-line (foreign-string-to-lisp line :count line-len)))
	    (delete-line line)
	    lisp-line))))))
