import run_impl
import trace_merger
import tla_trace_validation
import clean
import argparse

# Read program args
parser = argparse.ArgumentParser(description="")
parser.add_argument('version', type=str, help="Version of algorithm")
args = parser.parse_args()

print("# Clean up.\n")
clean.clean()

print("# Run.\n")
run_impl.run_all(args.version, 20.)

print("# Merge trace with config.\n")
trace_tla = trace_merger.run(["."], config=f"tictac.{args.version}.ndjson.conf", sort=True, remove_meta=True)
# Write to file
with open("trace-tla.ndjson", "w") as f:
    f.write(trace_tla)

print("# Start TLA+ trace validation\n")
tla_trace_validation.run_tla(f"spec/{args.version}/tictacTrace.tla","trace-tla.ndjson")


print("End pipeline.")
