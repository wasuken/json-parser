(defpackage json-parser/tests/main
  (:use :cl
        :json-parser
        :rove))
(in-package :json-parser/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :json-parser)' in your Lisp.
(deftest base-tests
	(testing "based test"
			 (ok (equal (json-parser:parse "{\"test\": \"test\"}")
						'(:|test| "test")))
			 (ok (equal (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\"}")
						'(:|test| "test" :|test2| "test2")))
			 (ok (equal (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\", \"test3\": {\"test4\": \"test4\"}}")
						'(:|test| "test" :|test2| "test2" :|test3| (:|test4| "test4"))))
			 (ok (equal (json-parser:parse "{\"test\": \"te,st\", \"test2\": \"t,est2\", \"test3\": {\"test4\": \"test,4\"}}")
						'(:|test| "te,st" :|test2| "t,est2" :|test3| (:|test4| "test,4"))))
			 (ok (equal (json-parser:parse "{\"test\": \"te:st\", \"test2\": \"t:est2\", \"test3\": {\"test4\": \"test:4\"}}")
						'(:|test| "te:st" :|test2| "t:est2" :|test3| (:|test4| "test:4"))))
			 (ok (equal (json-parser:parse "{\"test\": 1, \"test2\": 2}")
						'(:|test| 1 :|test2| 2)))
			 (ok (equal (json-parser:parse "{\"test\": true, \"test2\": false}")
						'(:|test| t :|test2| nil)))
			 (ok (equal (json-parser:parse "{null: null}")
						'(:|null| nil)))
			 (ok (equal (json-parser:parse "{}")
						'()))
			 (ok (equal (json-parser:parse "{\"test\" : [\"test\", 1, 2, 3 ]}")
						'(:|test| ("test" 1 2 3))))
			 (ok (equal (json-parser:parse "1")
						1))
			 ))

(deftest errors
	(testing "error mechanism"
			 (ok (signals (json-parser:parse "{\"test\":")))
			 (ok (signals (json-parser:parse "")))
			 (ok (signals (json-parser:parse "}}}}}}}")))
			 (ok (signals (json-parser:parse "{,}")))
			 (ok (signals (json-parser:parse ",,,,,,,{}")))
			 (ok (signals (json-parser:parse "{{}:{}}")))
			 (ok (signals (json-parser:parse "{{}:\"test\"}")))
			 (ok (signals (json-parser:parse "{{\"test\": \"test\"}:\"test\"}")))
			 (ok (signals (json-parser:parse "{,:,}")))
			 (ok (signals (json-parser:parse "{.,mo23qrjo:ijiojdiiorngirjt43}")))
			 ))
