;; (require \'asdf)
 
 (in-package :cl-user)
 (defpackage json-parser-asd
 (:use :cl :asdf))
 (in-package :json-parser-asd)
 
 (defsystem :json-parser
 :version "1.0.0"
 :author "wasu"
 :license "MIT"
 :components ((:file "package")
 (:module "src" :components ((:file "json-parser")))))

