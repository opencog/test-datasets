(define Kermit (ConceptNode "Kermit" (stv 0.001 0.9)))
(define Frog (ConceptNode "Frog" (stv 0.01 0.9)))
(define Animal (ConceptNode "Animal" (stv 0.1 0.9)))
(define alive (PredicateNode "alive" (stv 0.01 0.9)))

; Premises:
; Kermit is a frog.
; Frogs are animals.
; Animals are alive.
(define kermit_frog (InheritanceLink Kermit Frog (stv 0.9 0.9)))
(define frog_animal (InheritanceLink Frog Animal (stv 0.9 0.9)))
(define animal_alive (EvaluationLink alive (ListLink Animal) (stv 0.9 0.9)))

; Query #1
; is kermit an animal?
(define kermit_animal (InheritanceLink Kermit Animal))
(EvaluationLink (PredicateNode "query1") (ListLink kermit_animal))

; Query #2
; is kermit alive?
(define kermit_alive (EvaluationLink alive (ListLink Kermit)))
(EvaluationLink (PredicateNode "query2") (ListLink kermit_alive))

; Rules
(EvaluationLink (PredicateNode "rules") (ListLink (ConceptNode "DeductionRule")))
