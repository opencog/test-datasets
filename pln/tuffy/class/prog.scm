;;;; Relational Classification Dataset
;;;; PLN representation of the "RC" sample from Tuffy Markov Logic Networks
;;;; prog.scm

;;; More details on this sample are available here:
;;; https://github.com/cosmoharrigan/tuffy/tree/master/samples/class
;;; http://arxiv.org/pdf/1104.3216.pdf

;; Observed predicates

; *wrote(person,paper)
(define wrote (PredicateNode "wrote"))

; *refers(paper,paper)
(define refers (PredicateNode "refers"))

; *sameCat(cat,cat)
(define sameCat (PredicateNode "sameCat"))

;; Hidden predicates

; category(paper,cat)
(define category (PredicateNode "category"))

;; Rules

; Note: Tuffy required rules to be specified in clausal normal form
; (a disjunction of positive or negative literals). However, I find
; clausal form to be harder to read than propositional formulae.
;
; Therefore, I have attempted to include both versions below.

; Rule #1
; ----------------------------------------------------------------------------
; 1  !wrote(a1,a3) v !wrote(a1,a2) v category(a3,a4) v !category(a2,a4)
;
; wrote(x,p1), wrote(x,p2), category(p1,c) => category(p2,c)
;
; - If Person_1 wrote Paper_1 AND
;   Person_1 wrote Paper_2 AND
;   Paper_1 is in Category
;   then Paper_2 is probably also in Category

; TODO: Need to assign TruthValue to the rule below based on rule weight of 1

(ImplicationLink
    (AndLink
        (EvaluationLink
            (PredicateNode "wrote")
            (ListLink
                (VariableNode "$Person1")
                (VariableNode "$Paper1")))
        (EvaluationLink
            (PredicateNode "wrote")
            (ListLink
                (VariableNode "$Person1")
                (VariableNode "$Paper2")))
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$Paper1")
                (VariableNode "$Category"))))
    (EvaluationLink
        (PredicateNode "category")
        (ListLink
            (VariableNode "$Paper2")
            (VariableNode "$Category"))))

; Rule #2
; ----------------------------------------------------------------------------
; cat(p1,c), refers(p1,p2) => cat(p2,c)
;
; If Paper_1 is in Category AND
; Paper_1 refers to Paper_2
; then Paper_2 is probably in Category
;
; Note: the prog.mln file contains this as the following two rules:
;   2  !refers(a1,a2) v category(a2,a3) v !category(a1,a3)
;   2  !refers(a1,a2) v category(a1,a3) v !category(a2,a3)
; But, isn't the following representation sufficient?

; TODO: Need to assign TruthValue to the rule below based on rule weight of 2

(ImplicationLink
    (AndLink
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$Paper1")
                (VariableNode "$Category1")))
        (EvaluationLink
            (PredicateNode "refers")
            (ListLink
                (VariableNode "$Paper1")
                (VariableNode "$Paper2")))
    (EvaluationLink
        (PredicateNode "category")
        (ListLink
            (VariableNode "$Paper2")
            (VariableNode "$Category2")))))

; ****************************************************************************
; TODO - define the following rules:

; Rule #3
; ----------------------------------------------------------------------------
; 10  sameCat(a2,a3) v !category(a1,a3) v !category(a1,a2)
;
; In other words:
; cat(p,c1), cat(p,c2) => c1=c2
;
; - A paper is usually in only one category.
; - category_1 and category_2 are the same category OR
;   paper_1 is not in category_1 OR
;   paper_1 is not in category_2



; Rule #4
; ----------------------------------------------------------------------------
; TODO: Why does 'Networking' appear twice, and what is the meaning of the
;       letter 'a' instead of 'a1'?
; -3  category(a,Networking)



; Rule #5
; ----------------------------------------------------------------------------
; 0.14  category(a1,Programming)



; Rule #6
; ----------------------------------------------------------------------------



; Rule #7
; ----------------------------------------------------------------------------
; 0.09  category(a1,Operating_Systems)



; Rule #8
; ----------------------------------------------------------------------------
; 0.04  category(a1,Hardware_and_Architecture)



; Rule #9
; ----------------------------------------------------------------------------
; 0.11  category(a1,Data_Structures__Algorithms_and_Theory)



; Rule #10
; ----------------------------------------------------------------------------
; 0.04  category(a1,Encryption_and_Compression)



; Rule #11
; ----------------------------------------------------------------------------
; 0.02  category(a1,Information_Retrieval)



; Rule #12
; ----------------------------------------------------------------------------
; 0.05  category(a1,Databases)



; Rule #13
; ----------------------------------------------------------------------------
; 0.39  category(a1,Artificial_Intelligence)



; Rule #14
; ----------------------------------------------------------------------------
; 0.06  category(a1,Human_Computer_Interaction)



; Rule #15
; ----------------------------------------------------------------------------
; TODO: (see note on rule #4)
; 0.06  category(a,Networking)


