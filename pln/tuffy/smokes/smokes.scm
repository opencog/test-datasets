;;;; smokes.scm
;;;; PLN representation of the "smokes" sample from Tuffy Markov Logic Networks

;;; More details on this sample are available here:
;;; https://github.com/cosmoharrigan/tuffy/tree/master/samples/smoke
;;; http://hazy.cs.wisc.edu/hazy/tuffy/doc/tuffy-manual.pdf

;;; prog.mln:

;; Evidence and query predicates and concepts:

(define friends (PredicateNode "friends"))
(define smokes (PredicateNode "smokes"))
(define cancer (PredicateNode "cancer"))

(define Anna (ConceptNode "Anna"))
(define Bob (ConceptNode "Bob"))
(define Edward (ConceptNode "Edward"))
(define Frank (ConceptNode "Frank"))
(define Gary (ConceptNode "Gary"))
(define Helen (ConceptNode "Helen"))

;; Rules:

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

; In the case that X and Y are friends, if X smokes, then Y smokes.
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

; ?
(ImplicationLink (stv 0.4 1.0)
	(EvaluationLink (stv 1.0 1.0)
	    friends
	    (ListLink
	        (VariableNode "$X")
	        (VariableNode "$Y")))
    (AndLink
		(ImplicationLink
		    (EvaluationLink (stv 1.0 1.0)
				smokes
				(ListLink
				    (VariableNode "$X")))
			(EvaluationLink (stv 1.0 1.0)
				smokes
				(ListLink
				    (VariableNode "$Y"))))
		(ImplicationLink
		    (EvaluationLink (stv 1.0 1.0)
				smokes
				(ListLink
				    (VariableNode "$Y")))
			(EvaluationLink (stv 1.0 1.0)
				smokes
				(ListLink
				    (VariableNode "$X"))))))

; If X and Y are friends, then Y and X are friends
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

;;; evidence.db:

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

(NotLink (stv 1.0 1.0)
    (EvaluationLink (stv 1.0 1.0)
        friends
        (ListLink
            Gary
            Frank)))

(EvaluationLink (stv 1.0 1.0)
    smokes
    (ListLink
        Anna))

(EvaluationLink (stv 1.0 1.0)
    smokes
    (ListLink
        Edward))

;;; query.db:

(EvaluationLink (stv 1.0 1.0)
    cancer
        (ListLink
            (VariableNode "$X")))
