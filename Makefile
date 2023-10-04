PATH_THIS:=$(realpath $(dir $(lastword ${MAKEFILE_LIST})))

PATH_DIST:=${PATH_THIS}/dist

PYTHON_VIRTUAL_ENV:=${PATH_THIS}/venv
PYTHON:=${PYTHON_VIRTUAL_ENV}/bin/python3
PIP:=${PYTHON_VIRTUAL_ENV}/bin/pip

.PHONY: generate
generate: ${PYTHON_VIRTUAL_ENV}/bin/activate
	@mkdir -p ${PATH_DIST}
	@${PYTHON} \
	  -m grpc_tools.protoc \
	  -I${PATH_THIS}/proto \
	  --python_out=${PATH_DIST} \
	  --grpc_python_out=${PATH_DIST} \
	  --plugin=protoc-gen-mypy=${PYTHON_VIRTUAL_ENV}/bin/protoc-gen-mypy \
	  --mypy_out=${PATH_DIST} \
	  ${PATH_THIS}/proto/*.proto

${PYTHON_VIRTUAL_ENV}/bin/activate: ${PATH_THIS}/requirements.txt
	@echo "Create python virual enviroment ..."
	@python -m venv ${PYTHON_VIRTUAL_ENV}
	@echo "Install python dependencies ..."
	@${PIP} install --disable-pip-version-check -q -r ${PATH_THIS}/requirements.txt


.PHONY: bump_version
bump_version:
	@echo "not implemented"; exit 1

.PHONY: publish
publish:
	@echo "not implemented"; exit 1

.PHONY: clean
clean:
	@rm -rf ${PYTHON_VIRTUAL_ENV} ${PATH_DIST}
