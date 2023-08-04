# TicTac

TicTac is a tutorial that aims to show you how use TLA+ trace validation. Throughout the version (see git tags) we introduce some features of instrumentation. 

# How to run 

## Prerequisites

 - Java >= 19.0
 - Apache maven >= 3.6
 - Python >= 3.9

## Build

`mvn package`

## Run pipeline 

Command: 

`python trace_validation_pipeline.py`

Pipeline is compound by following steps:

 - Clean old trace files
 - Run implementation of TicTac
 - Merge trace files / config into one trace file (when different processes produce different trace files for example)
 - Run TLC on the resulting trace file

## Run trace validation on a trace file 

If a trace file (e.g: `trace-tla.ndjson`) already exist you can only run the TLC trace validation process by using this following command:

`python tla_trace_validation.py spec/tictacTrace.tla trace-tla.ndjson`

# Directory structure

 - `spec/**`: contains TicTac spec and trace spec
 - `src/**`: contains TicTac implementation

# Versions / Tags

## v1.0

This version exhibit a very naive implementation of the tictac specification (see `tictac.tla`). We deliberately introduce an error in implementation to show you how the trace spec is able to detect a discrepancy between implementation and specification.