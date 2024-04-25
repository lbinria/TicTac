import argparse
import os
from subprocess import Popen, TimeoutExpired

def clean():
    trace_files = [f for f in os.listdir(".") if f.endswith('.ndjson')]
    print(f"Cleanup: {trace_files}")
    for trace_file in trace_files:
        os.remove(trace_file)

def run(version, sh = 15, sm = 0, eh = 3, em = 0):
    p = Popen([
        "java",
        "-cp",
        "target/TicTac-1.0-SNAPSHOT-jar-with-dependencies.jar",
        "org.lbee.clocks."+version,
        sh, sm, eh, em
        ])
    p.wait()
    p.terminate()
    # return p

def runWithTimeout(version, timeout=5):
    # Run all processes
    p = run(version)
    try:
        p.wait(timeout)
    except TimeoutExpired:
        print("Timeout reach.\n")
        p.terminate()

if __name__ == "__main__":
    # Read program args
    parser = argparse.ArgumentParser(description="")
    parser.add_argument('-v', '--version', type=str, required=False,
                        default="StopWatch", help="Version to run")
    parser.add_argument('args', type=str, nargs="*", help="args")
    args = parser.parse_args()
    print("ARGS:",args)
    # Clean trace files in current directory
    clean()
    # run
    if args.version == "StopWatch":
        run(args.version, args.args[0], args.args[1], args.args[2], args.args[3])
    # Run the program with timeout
    # runWithTimeout(args.version)
