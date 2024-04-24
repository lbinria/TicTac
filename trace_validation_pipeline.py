import os
import subprocess
import run_impl
import trace_merger
import tla_trace_validation
import argparse
import ndjson

def get_files(version):
    files = [version+".ndjson"]
    return files

parser = argparse.ArgumentParser("")
parser.add_argument('-c', '--compile', type=bool, action=argparse.BooleanOptionalAction)
parser.add_argument('--version', type=str, required=False, default="tictac", help="Version")
args = parser.parse_args()

files = get_files(args.version)

# Clean up
print("# Clean up")
trace_files = files + ["trace.ndjson"]
print(f"Cleanup: {files}")
for trace_file in trace_files:
    if os.path.isfile(trace_file):
        os.remove(trace_file)

if args.compile:
    print("# Compile.\n")
    subprocess.run(["mvn", "package"])

# Run
print("# Start implementation.\n")
run_impl.run()

# Merge traces 
print("# Merge traces.\n")
trace_merger.run(files, sort=True, remove_meta=True, out="trace.ndjson")

# Validate trace
print("# Start TLA+ trace spec.\n")
tla_trace_validation.run_tla("spec/"+args.version+".tla","trace.ndjson")

# print("End pipeline.")