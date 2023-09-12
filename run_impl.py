import os
from subprocess import Popen, TimeoutExpired
import clean

def run(version):
    p = Popen([
        "java",
        "-jar",
        "target/TicTac-1.0-SNAPSHOT-jar-with-dependencies.jar",
        version
        ])
    return p


def run_all(version, timeout=20.):
    # Run all processes
    p = run(version)
    try:
        p.wait(timeout)
    except TimeoutExpired:
        print("Timeout reach.\n")
        p.terminate()

if __name__ == "__main__":
    # Clean directory
    clean.clean()
    run_all(20.)
