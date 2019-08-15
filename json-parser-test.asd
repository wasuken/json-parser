;; (require \'asdf)
 
 (in-package :cl-user)
 (defpackage json-parser-test-asd
 (:use :cl :asdf))
 (in-package :json-parser-test-asd)
 
 (defsystem json-parser-test
 :depends-on (:json-parser)
 :version "1.0.0"
 :author "wasu"
 :license "MIT"
 :components ((:module "t" :components ((:file "json-parser-test"))))
 :perform (test-op :after (op c)
 (funcall (intern #.(string :run) :prove) c)))

