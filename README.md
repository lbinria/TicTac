# TicTac

This is a tutorial that aims to show how use TLA+ [trace validation
tools](https://github.com/lbinria/trace_validation_tools).

[comment]: <> (Throughout the version (see git tags) we introduce some
features of instrumentation.)

# How to run 

## Prerequisites

 - Java >= 17
 - Apache maven >= 3.6
 - Python >= 3.9
 - TLA+ >= 1.8.0 (The Clarke release)

### Install TLA+

See README at https://github.com/lbinria/trace_validation_tools

### Install python librairies

Some python libraries are needed to execute the pipeline.

`pip install ndjson` 

(note that in some cases `pip` may be `pip3`)

## Build

`mvn package`

## Run pipeline 

Command: 

`python trace_validation_pipeline.py` 

(note that in some cases `python` may be `python3`)

Pipeline is compound by following steps:

 - Clean old trace files
 - Run implementation of TicTac
 - Merge trace files / config into one trace file (when different processes produce different trace files for example)
 - Run TLC on the resulting trace file

## Run trace validation on a trace file 

If a trace file (e.g: `trace-tla.ndjson`) already exist you can only run the TLC trace validation process by using this following command:

`python tla_trace_validation.py spec/tictacTrace.tla trace-tla.ndjson`

(note that in some cases `python` may be `python3`)

# Directory structure

 - `spec/**`: contains TicTac spec and trace spec
 - `src/**`: contains TicTac implementation

# Versions / Tags

## v1.0

This version exhibit a very naive implementation of the tictac specification (see `tictac.tla`). We deliberately introduce an error in implementation to show you how the trace spec is able to detect a discrepancy between implementation and specification.
