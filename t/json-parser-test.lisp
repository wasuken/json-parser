(in-package :cl-user)
(defpackage json-parser-test
  (:use :cl :prove :json-parser))
(in-package #:json-parser-test)

(subtest "lexer"
		  (is '(:test "test")
			  (json-parser:parse "{\"test\": \"test\"}"))
		  (is '(:test "test" :test2 "test2")
			  (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\"}"))
		  (is '(:test "test" :test2 "test2")
			  (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\", \"test3\": {\"test4\": \"test4\"}}"))
		  )
