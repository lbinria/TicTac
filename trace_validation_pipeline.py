from subprocess import Popen, PIPE
import run_impl
import trace_merger
import tla_trace_validation
import clean

print("# Clean up.\n")
clean.clean()

print("# Run.\n")
run_impl.run_all(20.)

print("# Merge trace with config.\n")
trace_tla = trace_merger.run(["."], config="tictac.ndjson.conf", sort=True)
# Write to file
with open("trace-tla.ndjson", "w") as f:
    f.write(trace_tla)

print("# Start TLA+ trace validation\n")
tla_trace_validation.run_tla("spec/tictacTrace.tla","trace-tla.ndjson")

# tla_trace_validation_process = Popen([
    # "python3",
    # "tla_trace_validation.py",
    # "spec/tictacTrace.tla",
    # "trace-tla.ndjson"])
# tla_trace_validation_process.wait()


print("End pipeline.")
