Instructions to run the experiment:

- Create a subfolder with the date of the test

- 'cd' into the subfolder

- Ensure that PLN is configured in your opencog.conf file

- Ensure that this datafile is preloaded in your opencog.conf file under SCM_PRELOAD: ```test-datasets/pln/tuffy/smokes/smokes.scm```

- Ensure that this PLN experiment is in the python extension path in your opencog.conf file under PYTHON_EXTENSION_DIRS: ```../opencog/python/pln/examples/tuffy/smokes```

- Start the cogserver

- Run the tests:
    ../run.sh

- After a while, record the output:
```
    ../atomspace.sh
    ../history.sh
    ../cancer.sh
    ../friends.sh
    ../smokes.sh
```
