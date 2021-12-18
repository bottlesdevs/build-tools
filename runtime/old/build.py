# ---------------------------------------
# build.py
# This script build the Bottles runtime
# this is a set of librarires from Ubuntu latest to ensure compatibility
# ---------------------------------------

import os
import shutil
import json
import tarfile

def check_recipe():
	'''
	Check if the runtime recipe exists and load it, if not
	raise an exception and exit
	'''
	if not os.path.exists('recipe.json'):
		raise Exception('recipe.json not found')

	return json.load(open('recipe.json'))


def create_runtime_structure():
	'''
	Create the runtime directory structure where to store the
	runtime libraries
	'''
	os.makedirs('runtime', exist_ok=True)
	os.makedirs('runtime/lib32', exist_ok=True)
	os.makedirs('runtime/lib64', exist_ok=True)
 

def build_runtime(recipe):
	'''
	Build the runtime from the recipe, copy the libraries
	from the current system to the runtime directory
	'''
	lib32 = []
	lib64 = []
	missed = []
	
	for lib in recipe['32bit'] + recipe['both']:
		_res = search_library(lib, '32')
		if _res:
			lib32.append(_res)
		else:
			missed.append(lib)
	
	for lib in recipe['64bit'] + recipe['both']:
		_res = search_library(lib, '64')
		if _res:
			lib64.append(_res)
		else:
			missed.append(lib)
	
	copy_to_runtime(lib32, '32')
	copy_to_runtime(lib64, '64')
	print(missed)


def copy_to_runtime(libs, arch='32'):
	'''
	Copy the libraries to the runtime directory
	'''
	for lib in libs:
		shutil.copy(lib, f'runtime/lib{arch}')


def search_library(lib, arch='32'):
	'''
	Search for a library in the current system
	'''
	lookup32 = [
		"/lib/i386-linux-gnu",
		"/usr/lib/i386-linux-gnu",
		"/usr/local/lib/i386-linux-gnu"  
	]
	lookup64 = [
		"/lib/x86_64-linux-gnu",
		"/usr/lib/x86_64-linux-gnu",
		"/usr/local/lib/x86_64-linux-gnu"
	]

	lookup = lookup32
	if arch == '64':
		lookup = lookup64
	
	for path in lookup:
		if os.path.exists(f'{path}/{lib}'):
			return f'{path}/{lib}'
	
	return False


def create_runtime_archive():
	'''
	Create the runtime archive
	'''
	tar = tarfile.open('runtime.tar.gz', 'w:gz')
	tar.add('runtime')
	tar.close()
 
 
def cleanup():
	'''
	Cleanup the runtime directory
	'''
	shutil.rmtree('runtime')


if __name__ == '__main__':
	recipe = check_recipe()
	create_runtime_structure()
	build_runtime(recipe)
	create_runtime_archive()
	print('Runtime built!')
