(in-package #:json-parser)

;;; TODO: 文字列中に,が入っていた場合、死ぬ。
(defun str-to-nodes (str)
  (let ((nodes (ppcre:split "," str)))
	nodes))

;;; TODO: 文字列中に:が入っていると死ぬ。
(defun nodes-to-pair (nodes)
  (mapcar #'(lambda (x) (let* ((sps (ppcre:split ":" x))
							   (left (nth 0 sps))
							   (right (nth 1 sps)))
						  (list (intern left) right)))
		  nodes))

(defun tree-remove-if (tree tar)
  (cond ((null tree) nil)
		((not (listp (car tree)))
		 (if (eql (car tree) tar)
			 (tree-remove-if (cdr tree) tar)
			 (append (list (car tree))
					 (tree-remove-if (cdr tree) tar))))
		((null (car tree)) (tree-remove-if (cdr tree) tar))
		((null (cdr tree)) (list (tree-remove-if (car tree) tar)))
		(t (append (list (tree-remove-if (car tree) tar))
				   (tree-remove-if (cdr tree) tar)))))

(defun to-pair (lst)
  (if (listp lst)
	   (mapcar #'to-pair lst)
	   (nodes-to-pair (str-to-nodes lst))))

(defun parse (str)
  (let ((lst (tree-remove-if (nth 2
				  (nth 3
					   (closure-html:parse
						(ppcre:regex-replace-all "}"
												 (ppcre:regex-replace-all "{" str "<a>")
												 "</a>")
						(closure-html:make-lhtml-builder))))
							 :a)))
	(to-pair lst)))
