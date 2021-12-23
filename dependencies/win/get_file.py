# ---------------------------------------
# get_file.py
# This script get the manifest to build from
# latest commit.
# Author: mirkobrombin
# License: MIT
# ---------------------------------------
import subprocess


look_ext = ".yml"
exclude = ["commit ", "author:", "Date:"]

def get_commit():
    try:
        _proc = subprocess.Popen(
            "git rev-parse --short HEAD",
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        stdout, stderr = _proc.communicate()
        return stdout.decode('utf-8').strip()
    except Exception as e:
        print("Unable to get commit")
        exit(1)


def list_commit_files(commit: str):
    try:
        _proc = subprocess.Popen(
            f"git show {commit} --name-only",
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        stdout, stderr = _proc.communicate()
        return stdout.decode('utf-8').strip().split("\n")
    except Exception as e:
        print("Unable to list commit files")
        exit(1)


def get_manifest(commit: str):
    files = list_commit_files(commit)
    for file in files:
        for exc in exclude:
            if file.startswith(exc):
                continue

        if file.startswith(" "):
            continue

        if file.endswith(look_ext):
            return file
    return None


if __name__ == "__main__":
    commit = get_commit()
    manifest = get_manifest(commit)
    print(manifest)
