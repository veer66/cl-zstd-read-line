;;;; package.lisp

(defpackage #:zstd-read-line
  (:use #:cl #:cffi)
  (:export #:create-reader
	   #:zstd-read-line
	   #:delete-line
	   #:close-reader
	   #:with-read-line
	   #:unable-to-open-archive))
