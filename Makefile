ifdef OS
   export PYTHON_COMMAND=python
else
   export PYTHON_COMMAND=python3.8
endif


setup:
	$(PYTHON_COMMAND) -m pip install poetry
	poetry env use $(PYTHON_COMMAND)
	poetry run pip install --upgrade pip

install:
	poetry lock
	poetry install

build-docs:
	mkdocs build

serve-docs:
	mkdocs serve
