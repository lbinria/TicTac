This is a tutorial that aims to show how use TLA+ [	trace validation
tools](https://github.com/lbinria/trace_validation_tools).

<!-- Throughout the version (see git tags) we introduce some
features of instrumentation. -->

# Prerequisites

 - Java >= 17
 - Apache maven >= 3.6
 - Python >= 3.9
 - TLA+ >= 1.8.0 (The Clarke release)

### Install the trace validation tools (and TLA+)

See README at https://github.com/lbinria/trace_validation_tools

### Install python librairies

The `ndjson` Python library is needed in order to perform the
validation; it can be installed with:

`pip install ndjson` 

We suppose that `python` and `pip` are the commands for Python and
its package installer, if otherwise you should change the above line
and some of the following accordingly.

# Build the Java program

Change the version of the dependency `org.lbee.instrumentation` in the
file [pom.xml](pom.xml) according to the one you use (in .m2 or on the
github maven registry) and run

`mvn package`

# Perform trace validation

To check the conformity of the trace produced by the program, the
script [trace_validation_pipeline.py](trace_validation_pipeline.py)
can be used:

`python trace_validation_pipeline.py` 

It consists of the following steps:
 - clean old trace files
 - run implementation of TicTac
 - [merge trace files / config into one trace file (when different processes produce different trace files)]
 - Run TLC on the resulting trace file

### Perform trace validation on a trace file 

Alternatively, we can run the implementation with the command

`mvn exec:java`

or

`python run_impl.py`

and then perform the trace validation on the obtained trace file
`trace-tla.ndjson` by using the command:

`python tla_trace_validation.py spec/tictacTrace.tla --trace trace-tla.ndjson`

# Directory structure

 - `spec/**`: contains TicTac specification and trace specification
 - `src/**`: contains TicTac implementation

# Versions / Tags

## v1.0

This version proposes a very naive implementation of the tictac
specification [tictac.tla](spec/v1/tictac.tla). An error was deliberately
introduced in the implementation to show how the trace specification
is able to detect a discrepancy between the implementation and the
specification.
