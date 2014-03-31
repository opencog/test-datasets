;;;; Relational Classification Dataset
;;;; PLN representation of the "RC" sample from Tuffy Markov Logic Networks
;;;; prog.scm

;;; More details on this sample are available here:
;;; https://github.com/cosmoharrigan/tuffy/tree/master/samples/class
;;; http://arxiv.org/pdf/1104.3216.pdf

;; ===========================================================================
;; Configuration
;; ===========================================================================

(cog-set-af-boundary! 25)

;; ===========================================================================
;; Observed predicates
;; ===========================================================================

; *wrote(person,paper)

(define wrote (PredicateNode "wrote" (av 20000 0 0)))

; *refers(paper,paper)

(define refers (PredicateNode "refers" (av 20000 0 0)))

; *sameCat(cat,cat)

(define sameCat (PredicateNode "sameCat"))

;; ===========================================================================
;; Hidden predicates
;; ===========================================================================

; category(paper,cat)

(define category (PredicateNode "category"))

; List of categories:

(define category-av (av 0 0 0))

(ConceptNode "Programming" category-av)
(ConceptNode "Operating_Systems" category-av)
(ConceptNode "Hardware_and_Architecture" category-av)
(ConceptNode "Data_Structures__Algorithms_and_Theory" category-av)
(ConceptNode "Encryption_and_Compression" category-av)
(ConceptNode "Information_Retrieval" category-av)
(ConceptNode "Databases" category-av)
(ConceptNode "Artificial_Intelligence" category-av)
(ConceptNode "Human_Computer_Interaction" category-av)
(ConceptNode "Networking" category-av)

;; TODO: In this version, we will attempt to use NotLink to express negation
;;       of a predicate

;; ===========================================================================
;; Rules
;; ===========================================================================

; Note: Tuffy required rules to be specified in clausal normal form
; (a disjunction of positive or negative literals). However, I find
; clausal form to be harder to read than propositional formulae.
;
; Therefore, I have attempted to demonstrate both versions below.

; ============================================================================
; Rule #1
; ----------------------------------------------------------------------------
; 1  !wrote(a1,a3) v !wrote(a1,a2) v category(a3,a4) v !category(a2,a4)
;
; wrote(Person1,Paper1), wrote(Person1,Paper2), category(Paper1,Category1)
;   => category(Paper2,Category1)
;
; - If Person_1 wrote Paper_1 AND
;   Person_1 wrote Paper_2 AND
;   Paper_1 is in Category
;   then Paper_2 is probably also in Category
; ============================================================================

(define rule1_antecedent
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
                (VariableNode "$Category")))))

(define rule1_consequent
    (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$Paper2")
                (VariableNode "$Category"))))

(ImplicationLink (stv .73106 1)
    rule1_antecedent
    rule1_consequent)

; ============================================================================
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
; But, isn't the following representation sufficient? And if so, how should
; those two rule weights of '2' be combined? Should the probability be based
; on a rule weight of '2' or of '4'?
; ============================================================================

(define rule2_antecedent
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
                (VariableNode "$Paper2")))))

(define rule2_consequent
    (EvaluationLink
        (PredicateNode "category")
        (ListLink
            (VariableNode "$Paper2")
            (VariableNode "$Category1"))))

(ImplicationLink (stv 0.88080 1)
    rule2_antecedent
    rule2_consequent)

; ============================================================================
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
;
; TODO: Should we use an ImplicationLink or clausal normal form?
; Alternative version using clausal normal form:
;
;(OrLink (stv 0.99995 1)
;    (EvaluationLink
;        (PredicateNode "sameCat")
;        (ListLink
;            (VariableNode "$Y1")
;            (VariableNode "$Y2")))
;    (NotLink
;        (EvaluationLink
;            (PredicateNode "category")
;            (ListLink
;                (VariableNode "$X")
;                (VariableNode "$Y1"))))
;    (NotLink
;        (EvaluationLink
;            (PredicateNode "category")
;            (ListLink
;                (VariableNode "$X")
;                (VariableNode "$Y2")))))
; ============================================================================

(define rule3_antecedent
    (AndLink
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$Paper")
                (VariableNode "$Category1")))
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$Paper")
                (VariableNode "$Category2")))))

(define rule3_consequent
    (EvaluationLink
        (PredicateNode "sameCat")
        (ListLink
            (VariableNode "$Category1")
            (VariableNode "$Category2"))))

(ImplicationLink (stv 0.99995 1)
    rule3_antecedent
    rule3_consequent)
