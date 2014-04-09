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
;;     authorships
;;     referrals
;;
;; Additionally, these find-* queries are defined to assist in variable
;; guided chaining:
;;
;;     find-referrals-to-paper
;;     find-common-author-to-paper
;;
;; Unifiers are created for the rules:
;;
;;     unifier-rule-1
;;     unifier-rule-2
;;
;; Then, the following rule application shortcuts are defined:
;;
;;     apply-rule-1
;;     apply-rule-2

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
; find-authorships
; count-authorships
;
; Authorships are instances of the wrote(person, paper) relation

(define find-authorships-result
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
      (ListLink
        (VariableNode "$person")
        (VariableNode "$paper")))))

(define (find-authorships)
    (map cog-outgoing-set
        (cog-outgoing-set (cog-bind find-authorships-result))))

(define (count-authorships) (length (find-authorships)))

; ---------------------------------------------------------------------------
; find-referrals
; count-referrals
;
; Referrals are instances of the refers(paper1, paper2) relation

(define find-referrals-result
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
      (ListLink
        (VariableNode "$paper1")
        (VariableNode "$paper2")))))

(define (find-referrals)
    (map cog-outgoing-set
        (cog-outgoing-set (cog-bind find-referrals-result))))

(define (count-referrals) (length (find-referrals)))

; ---------------------------------------------------------------------------
; find-referrals-to-paper
;
; Matches with rule #2 in prog.scm
; Takes paper2 as argument. The other 2 variables are ungrounded.
; Returns a list of papers.

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
; Returns a list of papers.

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

; ===========================================================================
; Rule definitions
; ===========================================================================

; ---------------------------------------------------------------------------
; unifer-rule-1
; Variable unifier for rule #1 in prog.scm
; Takes paper2 as argument. The other 3 variables are ungrounded.
; Returns a list of ImplicationLinks for ModusPonens to use as input for a
; given paper

(define (unifier-rule-1 paper2)
    (cog-bind
        (BindLink
            (ListLink
                (VariableNode "$paper1")
                (VariableNode "$person1")
                (VariableNode "$category"))
            (ImplicationLink

                ;; Rule #1 antecedent
                ;; Pattern to unify
                (AndLink
                    (EvaluationLink
                        (PredicateNode "wrote")
                        (ListLink
                            (VariableNode "$person1")
                            (VariableNode "$paper1")))
                    (EvaluationLink
                        (PredicateNode "wrote")
                        (ListLink
                            (VariableNode "$person1")
                            paper2))
                    (EvaluationLink
                        (PredicateNode "category")
                        (ListLink
                            (VariableNode "$paper1")
                            (VariableNode "$category"))))

                ;; Create instantiations of rule #1 that will be the input
                ;; for ModusPonens
                (ImplicationLink (stv 0.73106 1)
                    ; Note: AndCreationRule is omitted here for simplicity
                    ; since in this example the truth value of the AndLink
                    ; will simply be (stv 1 1)
                    (AndLink (stv 1 1)
                        (EvaluationLink
                            (PredicateNode "wrote")
                            (ListLink
                                (VariableNode "$person1")
                                (VariableNode "$paper1")))
                        (EvaluationLink
                            (PredicateNode "wrote")
                            (ListLink
                                (VariableNode "$person1")
                                paper2))
                        (EvaluationLink
                            (PredicateNode "category")
                            (ListLink
                                (VariableNode "$paper1")
                                (VariableNode "$category"))))
                    (EvaluationLink
                        (PredicateNode "category")
                        (ListLink
                            paper2
                            (VariableNode "$category"))))))))

; ---------------------------------------------------------------------------
; unifer-rule-2
;
; Variable unifier for rule #2 in prog.scm
; Takes paper2 as argument. The other 2 variables are ungrounded.
; Returns a list of ImplicationLinks for ModusPonens to use as input for a
; given paper

(define (unifier-rule-2 paper2)
    (cog-bind
        (BindLink
            (ListLink
                (VariableNode "$paper1")
                (VariableNode "$category"))
            (ImplicationLink

                ;; Rule #2 antecedent
                ;; Pattern to unify
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

                ;; Create instantiations of rule #2 that will be the input
                ;; for ModusPonens
                (ImplicationLink (stv 0.88080 1)
                    ; Note: AndCreationRule is omitted here for simplicity
                    ; since in this example the truth value of the AndLink
                    ; will simply be (stv 1 1)
                    (AndLink (stv 1 1)
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
                    (EvaluationLink
                        (PredicateNode "category")
                        (ListLink
                            paper2
                            (VariableNode "$category"))))))))

; ---------------------------------------------------------------------------
; apply-rule-1
; apply-rule-2
;
; Defines shortcut functions that will call the generic rule engine rule
; application function with the available rules, grounding each uncategorized
; paper against the template for the corresponding rule and applying the rule
; to the unifiers that are found

(define (apply-rule-1)
    (apply-rule PLNRuleModusPonens unifier-rule-1 (find-uncategorized-papers)))

(define (apply-rule-2)
    (apply-rule PLNRuleModusPonens unifier-rule-2 (find-uncategorized-papers)))

; ==========================================================================
; Compile the rule application functions to improve performance
; ==========================================================================

(define functions-list (list
    'apply-rule-1
    'apply-rule-2
))

(for-each
	(lambda (f) (compile f #:env (current-module)))
	functions-list)
