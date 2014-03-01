;;;; smokes.scm
;;;; PLN representation of the "smokes" sample from Tuffy Markov Logic Networks

;;; More details on this sample are available here:
;;; https://github.com/cosmoharrigan/tuffy/tree/master/samples/smoke
;;; http://hazy.cs.wisc.edu/hazy/tuffy/doc/tuffy-manual.pdf

;;; prog.mln

;; Evidence and query predicates and concepts:

(define friends (PredicateNode "friends"))
(define smokes (PredicateNode "smokes"))
(define cancer (PredicateNode "cancer"))

(define Anna (ConceptNode "Anna" (stv 0.1667 1)))
(define Bob (ConceptNode "Bob" (stv 0.1667 1)))
(define Edward (ConceptNode "Edward" (stv 0.1667 1)))
(define Frank (ConceptNode "Frank" (stv 0.1667 1)))
(define Gary (ConceptNode "Gary" (stv 0.1667 1)))
(define Helen (ConceptNode "Helen" (stv 0.1667 1)))

;; Rules

; If X smokes, then X has cancer.
(ImplicationLink (stv 0.5 1.0)
	(EvaluationLink (stv 1.0 1.0)
	    smokes
	    (ListLink
	        (VariableNode "$X")))
	(EvaluationLink (stv 1.0 1.0)
	    cancer
	    (ListLink
	        (VariableNode "$X"))))

; In the case that X and Y are friends, if X smokes then so does Y.
(ImplicationLink (stv 0.4 1.0)
	(EvaluationLink (stv 1.0 1.0)
	    friends
	    (ListLink
	        (VariableNode "$X")
	        (VariableNode "$Y")))
	(ImplicationLink
		(EvaluationLink (stv 1.0 1.0)
		    smokes
		    (ListLink
		        (VariableNode "$X")))
		(EvaluationLink (stv 1.0 1.0)
		    smokes
		    (ListLink
		        (VariableNode "$Y")))))

; If X and Y are friends, then Y and X are friends.
(EquivalenceLink (stv 1.0 1.0)
    (EvaluationLink (stv 1.0 1.0)
        friends
        (ListLink
            (VariableNode "$X")
            (VariableNode "$Y")))
    (EvaluationLink (stv 1.0 1.0)
        friends
        (ListLink (stv 1.0 1.0)
            (VariableNode "$Y")
            (VariableNode "$X"))))

;;; evidence.db

; Anna and Bob are friends.
(EvaluationLink (stv 1.0 1.0)
	friends
	(ListLink
		Anna
		Bob))

(EvaluationLink (stv 1.0 1.0)
	friends
	(ListLink
		Anna
		Edward))

(EvaluationLink (stv 1.0 1.0)
	friends
	(ListLink
	    Anna
		Frank))

(EvaluationLink (stv 1.0 1.0)
	friends
	(ListLink
		Edward
		Frank))

(EvaluationLink (stv 1.0 1.0)
	friends
	(ListLink
		Gary
		Helen))

; Anna and Gary are not friends.
(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Anna
		Gary))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Anna
		Helen))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Bob
		Edward))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Bob
		Frank))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Bob
		Gary))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Bob
		Helen))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Edward
		Gary))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Edward
		Helen))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Frank
		Gary))

(EvaluationLink (stv 0.0 1.0)
	friends
	(ListLink
		Frank
		Helen))

; Anna smokes.
(EvaluationLink (stv 1.0 1.0)
    smokes
    (ListLink
        Anna))

(EvaluationLink (stv 1.0 1.0)
    smokes
    (ListLink
        Edward))

;;; query.db

; Who has cancer?
(EvaluationLink
    cancer
        (ListLink
            (VariableNode "$X")))
