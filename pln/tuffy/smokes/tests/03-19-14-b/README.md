The non-friendships were being used as input by an odd implementation of the modusPonensFormula to produce output that incorrectly indicated that everyone was a smoker.

I removed the non-friendships from the evidence, which removed that symptom; the underlying issue is recorded in: https://github.com/opencog/opencog/issues/598

Acive rules are:

```
EvaluationToMemberRule
MemberToEvaluationRule
MemberToInheritanceRule
InheritanceToMemberRule
GeneralEvaluationToMemberRule
AndEliminationRule
ModusPonensRule
```

The output produced is much closer to the Tuffy example:

```
cancer(Bob)    <.38, 1>
cancer(Frank)  <.39, 1>
cancer(Anna)   <.43, 1>
cancer(Edward) <.5, 1>
```

