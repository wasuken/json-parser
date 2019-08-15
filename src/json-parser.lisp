(in-package #:json-parser)

;;; TODO: 文字列中に,が入っていた場合、死ぬ。
(defun str-to-nodes (str)
  (let ((nodes (ppcre:split "," str)))
	nodes))

(defun node-to-pair (node)
  (let* ((sps (ppcre:split ":" node))
		 (left (string-trim '(#\Space) (ppcre:regex-replace-all "\"" (nth 0 sps) "")))
		 (right (ppcre:regex-replace-all
				 "\""
				(ppcre:scan-to-strings "\".*?\"" (nth 1 sps)) "")))
	(list (intern left :keyword) right)))

;;; TODO: 文字列中に:が入っていると死ぬ。
(defun nodes-to-pair (nodes)
  (mapcan #'node-to-pair nodes))

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

(defun tree-to-pair (tree)
  (cond ((null tree) nil)
		((listp (car tree))
		 (cons (tree-to-pair (car tree))
			   (tree-to-pair (cdr tree))))
		(t (append (nodes-to-pair (str-to-nodes (car tree)))
				   (tree-to-pair (cdr tree))))))

(defun parse (str)
  (let ((lst (tree-remove-if (nth 2
				  (nth 3
					   (closure-html:parse
						(ppcre:regex-replace-all "}"
												 (ppcre:regex-replace-all "{" str "<a>")
												 "</a>")
						(closure-html:make-lhtml-builder))))
							 :a)))
	(tree-remove-if (tree-to-pair lst) nil)))
