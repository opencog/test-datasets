**March 7, 2014**

Testing a PLN version of the Tuffy MLN "smokes" sample.

More details on this sample are available here:

- https://github.com/cosmoharrigan/tuffy/tree/master/samples/smoke
- http://hazy.cs.wisc.edu/hazy/tuffy/doc/tuffy-manual.pdf

The current test is intended to check the inference activity of PLN for correctness. The Inference History Repository was enabled to store inferences in the main atomspace.

The following subset of rules and link types were chosen for the forward chaining agent:

```
rules.DeductionRule
rules.InversionRule
rules.ModusPonensRule
rules.PreciseModusPonensRule
rules.SymmetricModusPonensRule
rules.TermProbabilityRule
rules.TransitiveSimilarityRule
rules.EvaluationToMemberRule
rules.InheritanceRule
rules.InheritanceToMemberRule
rules.MemberToEvaluationRule
rules.MemberToInheritanceRule
rules.NegatedSubsetEvaluationRule
rules.OrEvaluationRule
rules.SimilarityRule
rules.SubsetEvaluationRule
rules.AndEvaluationRule
```

```
types.InheritanceLink
types.EvaluationLink
types.ImplicationLink
types.PredictiveImplicationLink
types.SimilarityLink
types.EquivalenceLink
types.OrLink
types.AndLink
types.SimultaneousAndLink
types.ExtensionalSimilarityLink
types.IntensionalSimilarityLink
types.IntensionalInheritanceLink
types.ListLink
types.SubsetLink
types.SetLink
types.MemberLink
types.NotLink
types.FalseLink
types.TrueLink
```
