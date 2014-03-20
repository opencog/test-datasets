;;;; smokes.scm
;;;; PLN representation of the "smokes" sample from Tuffy Markov Logic Networks

;;; More details on this sample are available here:
;;; https://github.com/cosmoharrigan/tuffy/tree/master/samples/smoke
;;; http://hazy.cs.wisc.edu/hazy/tuffy/doc/tuffy-manual.pdf

;;; prog.mln

(cog-set-af-boundary! 1)

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

;; If X smokes, then X has cancer.
;; ForAll(x) Smokes(x) -> Cancer(x)

; Version #1
(ImplicationLink (stv 0.5 1.0)
    (EvaluationLink (stv 1.0 0.0)
        smokes
        (ListLink
            (VariableNode "$X")))
    (EvaluationLink (stv 1.0 0.0)
        cancer
        (ListLink
            (VariableNode "$X"))))

;; In the case that X and Y are friends, if X smokes then so does Y.
;; ForAll(x,y) Friends(x,y) -> (Smokes(x) <-> Smokes(y))

; Version #3
(ImplicationLink (stv 0.4 1.0)
    (EvaluationLink (stv 1.0 0.0)
        friends
        (ListLink
            (VariableNode "$X")
            (VariableNode "$Y")))
    (AndLink
        (ImplicationLink
            (EvaluationLink (stv 1.0 0.0)
                smokes
                (ListLink
                    (VariableNode "$X")))
            (EvaluationLink (stv 1.0 0.0)
                smokes
                (ListLink
                    (VariableNode "$Y"))))
        (ImplicationLink
            (EvaluationLink (stv 1.0 0.0)
                smokes
                (ListLink
                    (VariableNode "$Y")))
            (EvaluationLink (stv 1.0 0.0)
                smokes
                (ListLink
                    (VariableNode "$X"))))))

; If X and Y are friends, then Y and X are friends.
(EquivalenceLink (stv 1.0 1.0)
    (EvaluationLink (stv 1.0 0.0)
        friends
        (ListLink
            (VariableNode "$X")
            (VariableNode "$Y")))
    (EvaluationLink (stv 1.0 0.0)
        friends
        (ListLink
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

;; Note: the 'non-friendships' are not explicitly defined in this version of the file

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
(define hasCancer
    (EvaluationLink
        cancer
        (ListLink
            (VariableNode "$hasCancer"))))

(define query
    (EvaluationLink
        (PredicateNode "query")
        (ListLink
            hasCancer)))

(define rules
    (EvaluationLink
        (PredicateNode "rules")
        (ListLink
            (ConceptNode "DeductionRule")
            (ConceptNode "EvaluationToMemberRule")
            (ConceptNode "MemberToEvaluationRule")
            (ConceptNode "MemberToInheritanceRule")
            (ConceptNode "InheritanceToMemberRule"))))

(cog-set-av! cancer (av 1000 0 0))
