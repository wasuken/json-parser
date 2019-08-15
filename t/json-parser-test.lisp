(in-package :cl-user)
(defpackage json-parser-test
  (:use :cl :prove :json-parser))
(in-package #:json-parser-test)

(subtest "lexer"
  (is (json-parser:parse "{\"test\": \"test\"}")
	  '(:|test| "test"))
  (is (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\"}")
	  '(:|test| "test" :|test2| "test2"))
  (is (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\", \"test3\": {\"test4\": \"test4\"}}")
	  '(:|test| "test" :|test2| "test2" :|test3| (:|test4| "test4")))
  (is (json-parser:parse "{\"test\": \"te,st\", \"test2\": \"t,est2\", \"test3\": {\"test4\": \"test,4\"}}")
	  '(:|test| "te,st" :|test2| "t,est2" :|test3| (:|test4| "test,4")))
  (is (json-parser:parse "{\"test\": \"te:st\", \"test2\": \"t:est2\", \"test3\": {\"test4\": \"test:4\"}}")
	  '(:|test| "te:st" :|test2| "t:est2" :|test3| (:|test4| "test:4")))
  )
