Instructions to run the experiment:

- Create a subfolder with the date of the test

- 'cd' into the subfolder

- Ensure that PLN is configured in your opencog.conf file

- Ensure that the AtomSpace Publisher Module is configured in your opencog.conf file

- Ensure that Attention Allocation is configured in your opencog.conf file

- Ensure that the Hebbian Creation Module is configured in your opencog.conf file

- Ensure that this datafile is preloaded in your opencog.conf file under SCM_PRELOAD: ```test-datasets/pln/tuffy/class/prog.mln```

- Ensure that this datafile is preloaded in your opencog.conf file under SCM_PRELOAD: ```test-datasets/pln/tuffy/class/evidence.mln```

- Ensure that this PLN experiment is in the python extension path in your opencog.conf file under PYTHON_EXTENSION_DIRS: ```../opencog/python/pln/examples/tuffy/class```

- Start the Logger application (from the ```external-tools``` repository) to capture AtomSpace events and store them in MongoDB for later analysis

- Start the cogserver

- Run the tests:
    ../run.sh

- After a while, record the output:
```
    ../atomspace.sh
    ../history.sh
    ../category.sh
```

- Analyze the MongoDB data to detect succussful inferences and perform a statistical analysis of the inference process
