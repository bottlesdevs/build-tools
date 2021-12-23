# ---------------------------------------
# build.py
# This script build a Bottles dependency bundle
# from a given manifest file.
# Author: mirkobrombin
# License: MIT
# ---------------------------------------
import os
import uuid
import shutil
import hashlib
import argparse
import subprocess
from glob import glob

from utils import get_manifest

class Dependency:

    def __init__(self, manifest):
        self.manifest = manifest
        self.name = self.manifest['Name']
        self.build = self.manifest['Build']
        self.artifact = self.manifest['Artifact']
    
    def __str__(self):
        return self.name
    

class Builder:

    def __init__(self, manifest, keep_build_dir=False):
        self.dependency = Dependency(manifest)
        self.build_dir = f"build__{uuid.uuid4()}"
        self.artifact_dir = f"__artifacts"
        self.keep_build_dir = keep_build_dir
    
    def create_dirs(self):
        print("Creating build directory {}".format(self.build_dir))
        os.makedirs(self.build_dir)
        print("Creating artifact directory {}".format(self.artifact_dir))
        os.makedirs(self.artifact_dir, exist_ok=True)

    def run_build_command(self):
        print("Building {}".format(self.dependency))
        try:
            subprocess.run(self.dependency.build, shell=True, check=True, cwd=self.build_dir)
            return True
        except Exception as e:
            print("Unable to build {}".format(self.dependency))
            exit(1)

    def find_artifact(self):
        print("Searching for {}".format(self.dependency.artifact))
        files = glob(f"{self.build_dir}/**/{self.dependency.artifact}", recursive=True)
        if len(files) == 0:
            print("Unable to find {}".format(self.dependency.artifact))
            exit(1)
        
        # move artifact to artifact directory
        artifact = files[0]
        print("Found {}".format(artifact))
        shutil.move(artifact, self.artifact_dir)
        print("Artifact moved to {}".format(self.artifact_dir))
        artifact = os.path.join(self.artifact_dir, os.path.basename(artifact))
        return artifact
    
    def hash_artifact(self, artifact):
        print("Hashing {}".format(artifact))
        with open(artifact, 'rb') as f:
            return hashlib.md5(f.read()).hexdigest()
    
    def clear_build_dir(self):
        print("Clearing build directory {}".format(self.build_dir))
        shutil.rmtree(self.build_dir)
    
    def run(self):
        self.create_dirs()
        if self.run_build_command():
            artifact = self.find_artifact()
            print("{} built successfully".format(self.dependency))
            print("Artifact: {}".format(artifact))
            print("Hash (MD5): {}".format(self.hash_artifact(artifact)))

            if not self.keep_build_dir:
                self.clear_build_dir()
            exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Build a dependency')
    parser.add_argument('-f', '--file', help='The manifest file to validate')
    parser.add_argument('-u', '--url', help='The url of the manifest file to validate')
    parser.add_argument('-k', '--keep', help='Keep the build directory')
    args = parser.parse_args()

    # build dependency
    manifest = get_manifest(file=args.file, url=args.url)
    builder = Builder(manifest, args.keep)
    builder.run()
    exit(0)

