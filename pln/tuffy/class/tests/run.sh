../oc.sh agents-start opencog::ImportanceUpdatingAgent
../oc.sh agents-start opencog::ImportanceDiffusionAgent
../oc.sh agents-start opencog::HebbianUpdatingAgent
../oc.sh loadpy class_agent
../oc.sh agents-start class_agent.InferenceAgent
../oc.sh sql-load

