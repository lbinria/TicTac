import argparse
import os
from subprocess import Popen, TimeoutExpired

def clean():
    trace_files = [f for f in os.listdir(".") if f.endswith('.ndjson')]
    print(f"Cleanup: {trace_files}")
    for trace_file in trace_files:
        os.remove(trace_file)

def run(version):
    p = Popen([
        "java",
        "-cp",
        "target/TicTac-1.0-SNAPSHOT-jar-with-dependencies.jar",
        "org.lbee.clocks."+version
        ])
    return p


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
    parser.add_argument('--version', type=str, required=False,
                        default="Clock11h", help="Version to run")
    args = parser.parse_args()
    # Clean trace files in current directory
    clean()
    # Run the program with timeout
    runWithTimeout(args.version)
