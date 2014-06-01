Instructions to run the experiment:

(To do: generalize these instructions to any experiment)

- Create a subfolder with the date of the test

- 'cd' into the subfolder

- Ensure that PLN is configured in your opencog.conf file ([instructions](https://github.com/opencog/opencog/blob/master/opencog/python/pln/README.md))

- Ensure that the AtomSpace Publisher Module is configured in your opencog.conf file ([instructions](https://github.com/opencog/opencog/blob/master/opencog/persist/zmq/events/README.md))

- Ensure that Attention Allocation is configured in your opencog.conf file

    Add the following to the MODULES section of opencog.conf:

    ```
    opencog/dynamics/attention/libattention.so
    ```

- Ensure that the Hebbian Creation Module is configured in your opencog.conf file

    Add the following to the MODULES section of opencog.conf:

    ```
    opencog/dynamics/attention/libhebbiancreation.so
    ```

- Ensure that this datafile is preloaded in your opencog.conf file under SCM_PRELOAD: 

    ```
    test-datasets/pln/tuffy/class/prog.mln
    ```

- Ensure that this PLN experiment is in the python extension path in your opencog.conf file under PYTHON_EXTENSION_DIRS:     

    ```
    ../opencog/python/pln/examples/tuffy/class
    ```

- Ensure that you have configured OpenCog to work with PostgreSQL and ODBC following the instructions here: https://github.com/opencog/opencog/blob/master/opencog/persist/sql/README

- Import the database dump in PostgreSQL from the ```evidence-notlink.sql``` file

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

