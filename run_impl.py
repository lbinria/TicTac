import os
from subprocess import Popen, PIPE, TimeoutExpired
import ndjson
import clean

def run():
    p = Popen([
        "java",
        "-jar",
        "target/TicTac-1.0-SNAPSHOT-jar-with-dependencies.jar"
        ])
    return p


def run_all(timeout=5.):
    # Run all processes
    p = run()
    try:
        p.wait(timeout)
    except TimeoutExpired:
        print("Timeout reach.\n")
        p.terminate()


if __name__ == "__main__":
    # Clean directory
    clean.clean()
    run_all(20.)
