# ---------------------------------------
# package.py
# This script package a Bottles dependency bundle
# into a manifest file.
# Author: mirkobrombin
# License: MIT
# ---------------------------------------
import hashlib
import argparse

from utils import get_manifest


class Packager:

    '''
    Placeholders:
    - #ARTIFACT_NAME#
        The name of the artifact
    - #ARTIFACT_URL#
        The public accessible url of the artifact
    - #ARTIFACT_MD5#
        The md5 checksum of the artifact
    '''

    def __init__(self, manifest, artifact_url, artifact_md5, output):
        self.manifest = manifest
        self.artifact_url = artifact_url
        self.artifact_md5 = artifact_md5
        self.output = output
    
    def replace_placeholders(self):
        self.manifest = self.manifest.replace('#ARTIFACT_NAME#', self.artifact_url.split('/')[-1])
        self.manifest = self.manifest.replace('#ARTIFACT_URL#', self.artifact_url)
        self.manifest = self.manifest.replace('#ARTIFACT_MD5#', self.artifact_md5)

    def write_manifest(self):
        try:
            with open(self.output, 'w') as stream:
                stream.write(self.manifest)
                print("Output written to {}".format(self.output))
                return True
        except Exception as e:
            print("Unable to write output: {}".format(self.output))
            exit(1)
        
    
    def run(self):
        self.replace_placeholders()
        self.write_manifest()
    

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Package a Bottles dependency bundle')
    parser.add_argument('-u', '--url', help='The url of the manifest file to validate')
    parser.add_argument('-a', '--artifactUrl', help='The public accessible url to the artifact')
    parser.add_argument('-o', '--output', help='The output manifest file')
    
    args = parser.parse_args()

    manifest = get_manifest(file=None, url=args.url, plain=True)
    artifact_url = args.artifactUrl
    artifact_md5 = hashlib.md5(manifest.encode('utf-8')).hexdigest()
    output = args.output

    packager = Packager(manifest, artifact_url, artifact_md5, output)
    packager.run()
    exit(0)
