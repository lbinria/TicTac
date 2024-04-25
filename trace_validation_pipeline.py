import os
import subprocess
import run_impl
import trace_merger
import tla_trace_validation
import argparse
import ndjson

def get_files(version):
    files = [version.lower()+".ndjson"]
    return files

parser = argparse.ArgumentParser("")
parser.add_argument('-c', '--compile', type=bool, action=argparse.BooleanOptionalAction)
parser.add_argument('-v', '--version', type=str, required=False, default="tictac", help="Version")
parser.add_argument('-dfs', '--dfs', type=bool, action=argparse.BooleanOptionalAction, help="depth-first search")
parser.add_argument('args', type=str, nargs="*", help="args")
args = parser.parse_args()

print(args)

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
# run the program (fill with dummy args in case of missing args)
run_impl.run(args.version, args.args+["0","0","0"])

# Merge traces 
print("# Merge traces.\n")
trace_merger.run(files, sort=True, remove_meta=True, out="trace.ndjson")

# Validate trace
print(f"# Start TLA+ trace validation.\n")
tla_trace_validation.run_tla("spec/"+args.version+"Trace.tla","trace.ndjson","",args.dfs)

# print("End pipeline.")