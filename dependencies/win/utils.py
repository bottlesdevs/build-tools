import yaml
import requests


def get_manifest(file=None, url=None, plain=False):
    if not file and not url:
        print("You must provide either a file or an url")
        exit(1)
    
    # read yaml file
    if file:
        try:
            with open(file, 'r') as stream:
                if not plain:
                    manifest = yaml.safe_load(stream)
                else:
                    manifest = stream.read()
        except FileNotFoundError:
            print("File not found")
            exit(1)
    
    elif url:
        try:
            manifest = requests.get(url).text
            if not plain:
                manifest = yaml.safe_load(requests.get(url).text)
        except requests.exceptions.RequestException:
            print("Unable to read the manifest url")
            exit(1)
    
    return manifest
