PLN version of the Tuffy MLN "Relational Classification" dataset
----------------------------------------------------------------

More details on this sample are available here:

- https://github.com/cosmoharrigan/tuffy/tree/master/samples/class
- http://arxiv.org/pdf/1104.3216.pdf

Author: Cosmo Harrigan, March 2014

**In-progress: currently incomplete**

Query:

```
category(p,x)
```

#### Evidence

Evidence is contained in: **evidence.scm**

#### Program

The program describing the rules is contained in: **prog.scm**

#### Todo

- How do we define the set of papers and categories? Since in this example we
  have multiple types of ConceptNodes, whereas in the "smokes" example, all the
  ConceptNodes were people?

  Should we enumerate them using MemberLink?

```
  (MemberLink
      (ConceptNode "Paper1")
      (ConceptNode "Paper"))
  (MemberLink
      (ConceptNode "Paper2")
      (ConceptNode "Paper"))
    etc...
```

- And then, during the assignment of constants to variables to create ground
  formulae, how do we restrict the potential ConceptNode candidates so that
  only candidates that match the type signature of the predicate will be
  chosen? In other words, how are predicate type signatures implemented in
  AtomSpace notation and in PLN?

- For example, given the predicate ```wrote(person,paper)```, how does PLN
  ensure that the grounding of ```person``` only occurs from the set of
  ConceptNodes that belong to the set of people and not those that belong to
  the set of papers?

- How should negation be handled? With an explicit separate ```!category```
  predicate, or with ```NotLink```?
