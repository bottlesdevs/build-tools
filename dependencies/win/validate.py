# ---------------------------------------
# validate.py
# This script validate an input yaml manfiest file
# to ensure that its structure is correct.
# Author: mirkobrombin
# License: MIT
# ---------------------------------------
import argparse
from schema import Schema, And, Use, SchemaError

from utils import get_manifest


expected_schema = Schema({
    "Name": And(Use(str)),
    "Description": And(Use(str)),
    "Provider": And(Use(str)),
    "License": And(Use(str)),
    "License_url": And(Use(str)),
    "Dependencies": And(Use(list)),
    "Build": And(Use(str)),
    "Artifact": And(Use(str)),
    "Steps": And(Use(list))
})

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Validate a manifest file')
    parser.add_argument('-f', '--file', help='The manifest file to validate')
    parser.add_argument('-u', '--url', help='The url of the manifest file to validate')
    args = parser.parse_args()

    if not args.file and not args.url:
        print("You must provide either a file or an url")
        exit(1)

    # validate yaml file
    manifest = get_manifest(file=args.file, url=args.url)
    try:
        expected_schema.validate(manifest)
    except SchemaError as e:
        print("Manifest file is not valid: {}".format(e))
        exit(1)

    print("Manifest file is valid")
    exit(0)
