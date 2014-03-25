;;;; Relational Classification Dataset
;;;; PLN representation of the "RC" sample from Tuffy Markov Logic Networks
;;;; prog.scm

;;; More details on this sample are available here:
;;; https://github.com/cosmoharrigan/tuffy/tree/master/samples/class
;;; http://arxiv.org/pdf/1104.3216.pdf

;; ===========================================================================
;; Observed predicates
;; ===========================================================================

; *wrote(person,paper)

(define wrote (PredicateNode "wrote"))

; *refers(paper,paper)

(define refers (PredicateNode "refers"))

; *sameCat(cat,cat)

(define sameCat (PredicateNode "sameCat"))

;; ===========================================================================
;; Hidden predicates
;; ===========================================================================

; category(paper,cat)

(define category (PredicateNode "category"))

;; Define the relation between the negation predicate and the hidden predicate
;; TODO: How to express the negation relationship between the two predicates?
;;       We were going to use NotLink instead, but there is an outstanding
;;       bug with the ModusPonensFormula that will cause nonsensical results:
;;         https://github.com/opencog/opencog/issues/598

(define notCategory (PredicateNode "!category"))

; TODO: Test if this relationship between Category and NotCategory works as
;       expected

(ImplicationLink (stv 1 1)
    (EvaluationLink
        (PredicateNode "!category")
        (ListLink
            (VariableNode "$X")
            (VariableNode "$Y")))
    (NotLink
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$X")
                (VariableNode "$Y")))))

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
; wrote(x,p1), wrote(x,p2), category(p1,c) => category(p2,c)
;
; - If Person_1 wrote Paper_1 AND
;   Person_1 wrote Paper_2 AND
;   Paper_1 is in Category
;   then Paper_2 is probably also in Category
; ============================================================================

(ImplicationLink (stv .73106 1)
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

(ImplicationLink (stv 0.88080 1)
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
            (VariableNode "$Category1")))))

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
;                (VariableNode "$Y2"))))
; ============================================================================

(ImplicationLink (stv 0.99995 1)
    (AndLink
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$X")
                (VariableNode "$Y1")))
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$X")
                (VariableNode "$Y2"))))
    (EvaluationLink
        (PredicateNode "sameCat")
        (ListLink
            (VariableNode "$Y1")
            (VariableNode "$Y2"))))

; ============================================================================
; Rule #4
; ----------------------------------------------------------------------------
; TODO: Why does 'Networking' appear twice, and what is the meaning of the
;       letter 'a' instead of 'a1'?
; -3  category(a,Networking)
; ============================================================================

; TODO: Define this rule. It doesn't make sense to define the 'Networking'
; strength twice. How should this alter the overall probability?

; ============================================================================
; TODO: Why did they have the following rule weights add up to 1? That might
; make sense if the rule weights were probabilities, but they're not. They have
; to be converted to probabilities.
;
; For now, we'll just go ahead and use them as probabilities, and they can be
; adjusted later if necessary.
; ============================================================================

; ============================================================================
; Rule #5
; ----------------------------------------------------------------------------
; 0.14  category(a1,Programming)
; ============================================================================

; Programming is a fuzzy member of degree 0.14 of the categories that papers have
(MemberLink (stv 0.14 1)
    (ConceptNode "Programming")
    (SatisfyingSetLink
        (VariableNode "$Y")
        (EvaluationLink
            (PredicateNode "category")
            (ListLink
                (VariableNode "$X")
                (VariableNode "$Y")))))

; Define that as a macro so that we can re-use it without typing it again
(define CategoriesThatPapersHave
    (SatisfyingSetLink
            (VariableNode "$Y")
            (EvaluationLink
                (PredicateNode "category")
                (ListLink
                    (VariableNode "$X")
                    (VariableNode "$Y")))))

; ============================================================================
; Rule #6
; ----------------------------------------------------------------------------
; 0.09  category(a1,Operating_Systems)
; ============================================================================

(MemberLink (stv 0.09 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #7
; ----------------------------------------------------------------------------
; 0.04  category(a1,Hardware_and_Architecture)
; ============================================================================

(MemberLink (stv 0.04 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #8
; ----------------------------------------------------------------------------
; 0.11  category(a1,Data_Structures__Algorithms_and_Theory)
; ============================================================================

(MemberLink (stv 0.11 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #9
; ----------------------------------------------------------------------------
; 0.04  category(a1,Encryption_and_Compression)
; ============================================================================

(MemberLink (stv 0.04 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #10
; ----------------------------------------------------------------------------
; 0.02  category(a1,Information_Retrieval)
; ============================================================================

(MemberLink (stv 0.02 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #11
; ----------------------------------------------------------------------------
; 0.05  category(a1,Databases)
; ============================================================================

(MemberLink (stv 0.05 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #12
; ----------------------------------------------------------------------------
; 0.39  category(a1,Artificial_Intelligence)
; ============================================================================

(MemberLink (stv 0.39 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #13
; ----------------------------------------------------------------------------
; 0.06  category(a1,Human_Computer_Interaction)
; ============================================================================

(MemberLink (stv 0.06 1)
    CategoriesThatPapersHave)

; ============================================================================
; Rule #14
; ----------------------------------------------------------------------------
; TODO: (see note on rule #4)
; 0.06  category(a,Networking)
; ============================================================================

(MemberLink (stv 0.06 1)
    CategoriesThatPapersHave)
