The non-friendships were being used as input by an odd implementation of the modusPonensFormula to produce output that incorrectly indicated that everyone was a smoker.

I removed the non-friendships from the evidence, which removed that symptom; the underlying issue is recorded in: https://github.com/opencog/opencog/issues/598

In this version, I also removed the other rules, leaving us with only the two rules below.

Acive rules are:

```
ModusPonensRule
AndEliminationRule
```

The output produced is much closer to the Tuffy example:

```
cancer(Bob)    <.39, 1>
cancer(Frank)  <.36, 1>
cancer(Anna)   <.50, 1>
cancer(Edward) <.50, 1>
```

