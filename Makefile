.PHONY: all docs test compile upload_to_pypi typecheck clean

LIBRARY_DIR := epic_kitchens
SRC_FILES := $(shell find epic_kitchens) 
SRC_FILES += setup.py

all: test

docs:
	$(MAKE) html -C docs 

test: compile
	tox

compile:
	python -m compileall $(LIBRARY_DIR)

dist: $(SRC_FILES) compile
	rm -rf dist
	python setup.py sdist

upload_to_pypi: dist
	twine upload dist/*

typecheck:
	mypy $(LIBRARY_DIR) --ignore-missing-imports

clean:
	rm -rf dist
