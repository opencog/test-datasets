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
(define Edward (ConceptNode "Edward"))
(define Gary (ConceptNode "Gary"))
(define Helen (ConceptNode "Helen"))

;; Rules:

(ImplicationLink (stv 0.5 1.0)
	(EvaluationLink
	    smokes
	    (ListLink
	        (VariableNode "$X")))
	(EvaluationLink
	    cancer
	    (ListLink
	        (VariableNode "$X"))))

(ImplicationLink (stv 0.4 1.0)
	(EvaluationLink
	    friends
	    (ListLink
	        (VariableNode "$X")
	        (VariableNode "$Y")))
	(ImplicationLink
		(EvaluationLink
		    smokes
		    (ListLink
		        (VariableNode "$X")))
		(EvaluationLink
		    smokes
		    (ListLink
		        (VariableNode "$Y")))))

(ImplicationLink (stv 0.4 1.0)
	(EvaluationLink
	    friends
	    (ListLink
	        (VariableNode "$X")
	        (VariableNode "$Y")))
    (AndLink
		(ImplicationLink
		    (EvaluationLink
				smokes
				(ListLink
				    (VariableNode "$X")))
			(EvaluationLink
				smokes
				(ListLink
				    (VariableNode "$Y"))))
		(ImplicationLink
		    (EvaluationLink
				smokes
				(ListLink
				    (VariableNode "$Y")))
			(EvaluationLink
				smokes
				(ListLink
				    (VariableNode "$X"))))))

;;; evidence.db:

(EvaluationLink
	friends
	(ListLink
		Anna
		Bob))

(EvaluationLink
	friends
	(ListLink
		Anna
		Edward))

(EvaluationLink
	friends
	(ListLink
	    Anna
		Frank))

(EvaluationLink
	friends
	(ListLink
		Edward
		Frank))

(EvaluationLink
	friends
	(ListLink
		Gary
		Helen))

(NotLink
    (EvaluationLink
        friends
        (ListLink
            Gary
            Frank)))

(EvaluationLink
    smokes
    (ListLink
        Anna))

(EvaluationLink
    smokes
    (ListLink
        Edward))

;;; query.db:

(EvaluationLink
    cancer
        (ListLink
            (VariableNode "$X")))
