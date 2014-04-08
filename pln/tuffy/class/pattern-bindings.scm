;;;; Pattern matcher binding utilities for class and rc1000 problems

;; find-* and count-* queries are defined for the following entity types:
;;
;;     categories
;;     people
;;     papers
;;     categorized-papers
;;     uncategorized-papers
;;     referral-sources
;;     referral-targets
;;     categorizations
;;
;; Additionally, these find-* queries are defined to assist in variable
;; guided chaining:
;;
;;     find-referrals-to-paper
;;     find-common-author-to-paper

; ---------------------------------------------------------------------------
; find-categories
; count-categories
;
; Categories are entities that participate in the category(paper, category)
; relation as the second argument

(define find-categories-result
  (BindLink
    (ListLink
        (VariableNode "$paper")
        (VariableNode "$category"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "category")
        (ListLink
          (VariableNode "$paper")
          (VariableNode "$category")))
      (VariableNode "$category"))))

(define (find-categories)
    (delete-duplicates (cog-outgoing-set (cog-bind find-categories-result))))

(define (count-categories)
    (length (find-categories)))

; ---------------------------------------------------------------------------
; find-people
; count-people
;
; People are entities that participate in the wrote(person, paper) relation
; as the first argument

(define find-people-result
  (BindLink
    (ListLink
        (VariableNode "$person")
        (VariableNode "$paper"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "wrote")
        (ListLink
          (VariableNode "$person")
          (VariableNode "$paper")))
      (VariableNode "$person"))))

(define (find-people)
    (delete-duplicates (cog-outgoing-set (cog-bind find-people-result))))

(define (count-people)
    (length (find-people)))

; ---------------------------------------------------------------------------
; find-papers
; count-papers
;
; Papers are entities that participate in the wrote(person, paper) relation
; as the second argument

(define find-papers-result
  (BindLink
    (ListLink
        (VariableNode "$person")
        (VariableNode "$paper"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "wrote")
        (ListLink
          (VariableNode "$person")
          (VariableNode "$paper")))
      (VariableNode "$paper"))))

(define (find-papers)
    (delete-duplicates (cog-outgoing-set (cog-bind find-papers-result))))

(define (count-papers)
    (length (find-papers)))

; ---------------------------------------------------------------------------
; find-categorized-papers
; count-categorized-papers
;
; Categorized papers are entities that participate in the
; category(paper, category) relation as the first argument
(define find-categorized-papers-result
  (BindLink
    (ListLink
        (VariableNode "$paper")
        (VariableNode "$category"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "category")
        (ListLink
          (VariableNode "$paper")
          (VariableNode "$category")))
      (VariableNode "$paper"))))

(define (find-categorized-papers)
    (delete-duplicates
        (cog-outgoing-set (cog-bind find-categorized-papers-result))))

(define (count-categorized-papers)
    (length (find-categorized-papers)))

; ---------------------------------------------------------------------------
; find-uncategorized-papers
; count-uncategorized-papers
;
; Uncategorized papers are the set difference of all papers and categorized
; papers

(define (find-uncategorized-papers)
    (lset-difference equal? (find-papers) (find-categorized-papers)))

(define (count-uncategorized-papers)
    (length (find-uncategorized-papers)))

; ---------------------------------------------------------------------------
; find-referral-sources
; count-referral-sources
;
; Referral sources are entities that participate in the refers(paper, paper)
; relation as the first argument

(define find-referral-sources-result
  (BindLink
    (ListLink
        (VariableNode "$paper1")
        (VariableNode "$paper2"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "refers")
        (ListLink
          (VariableNode "$paper1")
          (VariableNode "$paper2")))
      (VariableNode "$paper1"))))

(define (find-referral-sources)
    (delete-duplicates
        (cog-outgoing-set (cog-bind find-referral-sources-result))))

(define (count-referral-sources)
    (length (find-referral-sources)))

; ---------------------------------------------------------------------------
; find-referral-targets
; count-referral-targets
;
; Referral targets are entities that participate in the refers(paper, paper)
; relation as the second argument

(define find-referral-targets-result
  (BindLink
    (ListLink
        (VariableNode "$paper1")
        (VariableNode "$paper2"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "refers")
        (ListLink
          (VariableNode "$paper1")
          (VariableNode "$paper2")))
      (VariableNode "$paper2"))))

(define (find-referral-targets)
    (delete-duplicates
        (cog-outgoing-set (cog-bind find-referral-targets-result))))

(define (count-referral-targets) (length (find-referral-targets)))

; ---------------------------------------------------------------------------
; find-categorizations
; count-categorizations
;
; Categorizations are instances of the category(paper, category) relation

(define find-categorizations-result
  (BindLink
    (ListLink
        (VariableNode "$paper")
        (VariableNode "$category"))
    (ImplicationLink
      (EvaluationLink
        (PredicateNode "category")
        (ListLink
          (VariableNode "$paper")
          (VariableNode "$category")))
      (ListLink
        (VariableNode "$paper")
        (VariableNode "$category")))))

(define (find-categorizations)
    (map cog-outgoing-set
        (cog-outgoing-set (cog-bind find-categorizations-result))))

(define (count-categorizations) (length (find-categorizations)))

; ---------------------------------------------------------------------------
; find-referrals-to-paper
;
; Matches with rule #2 in prog.scm
; Takes paper2 as argument. The other 2 variables are ungrounded.

(define (find-referrals-to-paper paper2)
  (cog-bind
      (BindLink
        (ListLink
            (VariableNode "$paper1")
            (VariableNode "$category"))
        (ImplicationLink
          (AndLink
              (EvaluationLink
                (PredicateNode "refers")
                (ListLink
                  (VariableNode "$paper1")
                  paper2))
              (EvaluationLink
                (PredicateNode "category")
                (ListLink
                    (VariableNode "$paper1")
                    (VariableNode "$category"))))
          (VariableNode "$paper1")))))

; ---------------------------------------------------------------------------
; find-common-author-to-paper
;
; Matches with rule #1 in prog.scm
; Takes paper2 as argument. The other 3 variables are ungrounded.

(define (find-common-author-to-paper paper2)
  (cog-bind
      (BindLink
        (ListLink
            (VariableNode "$paper1")
            (VariableNode "$person")
            (VariableNode "$category"))
        (ImplicationLink
          (AndLink
              (EvaluationLink
                (PredicateNode "wrote")
                (ListLink
                  (VariableNode "$person")
                  (VariableNode "$paper1")))
              (EvaluationLink
                (PredicateNode "wrote")
                (ListLink
                  (VariableNode "$person")
                  paper2))
              (EvaluationLink
                (PredicateNode "category")
                (ListLink
                    (VariableNode "$paper1")
                    (VariableNode "$category"))))
          (VariableNode "$paper1")))))
