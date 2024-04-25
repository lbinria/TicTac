This is a tutorial that aims to show how use TLA+ 
[trace validation tools](https://github.com/lbinria/trace_validation_tools).
It uses the specification of a 
[StopWach](spec/StopWatch.tla)
and of resetable 
[TicTac clock](spec/TicTac.tla). 
An error was deliberately introduced in each of the corresponding implementations of 
[StopWatch](src/main/java/org/lbee/clocks/StopWatch.java) 
and 
[TicTac](src/main/java/org/lbee/clocks/TicTac.java) 
to show how the trace specification is able to detect a discrepancy between the implementation and the specification.

## Prerequisites

 - Java >= 17
 - Apache maven >= 3.6
 - Python >= 3.9
 - TLA+ >= 1.8.0 (The Clarke release)

### Install the trace validation tools (and TLA+)

See README at [trace validation tools](https://github.com/lbinria/trace_validation_tools).

### Install python librairies

The `ndjson` Python library is needed in order to perform the
validation; it can be installed with:

`pip install ndjson` 

We suppose that `python` and `pip` are the commands for Python and
its package installer, if otherwise you should change the above line
and some of the following accordingly.

## Build the Java program

Change the version of the dependency `org.lbee.instrumentation` in the
file [pom.xml](pom.xml#L22) according to the one you use (in .m2 or on the
github maven registry) and run

`mvn package`

## Perform trace validation

To check the conformity of the trace produced by the program, the
script [trace_validation_pipeline.py](trace_validation_pipeline.py)
can be used. It consists of the following steps:
 - clean old trace files
 - run implementation of the program
 - merge trace files into one trace file and strip off unnecessary information 
 - Run TLC on the resulting trace file

Arguments:
- `--version`: Name of the implementation to test: `StopWatch` or `TicTac`
- `--compile`: compile the source code before running
- `--dfs`: use depth-first search (if not specified breadth-first search is used)
- `args`: arguments for the implementation

Examples:

`python trace_validation_pipeline.py -dfs -v StopWatch 22 0 1 0` 

`python trace_validation_pipeline.py -v TicTac 100` 

### Perform trace validation on a trace file 

Alternatively, we can run the implementation with the script [run_impl.py](run_impl.py). Arguments:
- `--version`: Name of the implementation to test: `StopWatch` or `TicTac`
- `args`: arguments for the implementation

Eample: `python run_impl.py -v TicTac 100`

Then clean the trace file by using the script [trace_merger.py](trace_merger.py). Arguments:
- `files`: Trace files to merge (or directories containg `ndjson` files to be merged)
- `--config`: Config file (default=`conf.ndjson`)
- `--sort`: Sort by clock (default=`True`)
- `--remove_meta`: Remove clock and sender data (default=`True`)
- `--out`: Output file (default=`trace.ndjson`)

Example: `python trace_merger.py tictac.ndjson `

The validation can then be performed with the script 
[tla_trace_validation.py](tla_trace_validation.py).
Arguments:
- `spec`: Specification file
- `--config`: Config file (default=`conf.ndjson`)
- `--trace`: Trace file (default=`trace.ndjson`)
- `--dfs`: use depth-first search (if not specified breadth-first search is used)

Example: `python tla_trace_validation.py spec/TicTacTrace.tla`

## Directory structure

 - `spec/**`: contains TicTac specification and trace specification
 - `src/**`: contains TicTac implementation
