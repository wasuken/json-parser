(defsystem "json-parser"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "json-parser/tests"))))

(defsystem "json-parser/tests"
  :author ""
  :license ""
  :depends-on ("json-parser"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for json-parser"
  :perform (test-op (op c) (symbol-call :rove :run c)))
