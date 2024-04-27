import argparse
import os
from subprocess import Popen, TimeoutExpired

def clean():
    trace_files = [f for f in os.listdir(".") if f.endswith('.ndjson')]
    print(f"Cleanup: {trace_files}")
    for trace_file in trace_files:
        os.remove(trace_file)

def run(version, args):
    p = Popen([
        "java",
        "-cp",
        # specify the classpath for the instrumentation library if just copied locally
        # "target/TicTac-1.0-SNAPSHOT-jar-with-dependencies.jar:lib/instrumentation-1.3.jar",
        "target/TicTac-1.0-SNAPSHOT-jar-with-dependencies.jar",
        "org.lbee.clocks."+version,
        args[0], args[1], args[2], args[3]
        ])
    p.wait()
    p.terminate()
    # return p

# deprecated
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
    print("ARGS:",args.args)
    # Clean trace files in current directory
    # clean()
    # run the program (fill with dummy args in case of missing args)
    run(args.version, args.args+["0","0","0"])
