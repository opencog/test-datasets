Instructions to run the experiment:

- Create a subfolder with the date of the test

- 'cd' into the subfolder

- Ensure that PLN is configured in your opencog.conf file

- Ensure that this datafile is preloaded in your opencog.conf file: ```test-datasets/pln/tuffy/smokes/smokes.scm```

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
