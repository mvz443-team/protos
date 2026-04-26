.PHONY: help typescript ts golang go gen clean check-out-dir check-clean-dir check-proto-files

PROTO_DIR ?= .
OUT_DIR ?=

PROTO_FILES := $(wildcard $(PROTO_DIR)/*.proto)

help:
	@echo "Usage:"
	@echo "  make typescript OUT_DIR=../frontend/src/pb"
	@echo "  make golang     OUT_DIR=../backend/tools/server/messages/pb"
	@echo ""
	@echo "Optional:"
	@echo "  PROTO_DIR=proto   Override proto source directory. Default: current directory"
	@echo "  make clean OUT_DIR=../frontend/src/pb"

typescript: check-out-dir check-proto-files
	@echo "Generating TypeScript contracts into $(OUT_DIR)..."
	@mkdir -p "$(OUT_DIR)"
	protoc --proto_path="$(PROTO_DIR)" --ts_out="$(OUT_DIR)" $(PROTO_FILES)
	@echo "TypeScript generation complete."

ts: typescript

golang: check-out-dir check-proto-files
	@echo "Generating Go contracts into $(OUT_DIR)..."
	@mkdir -p "$(OUT_DIR)"
	protoc --proto_path="$(PROTO_DIR)" --go_out="$(OUT_DIR)" $(PROTO_FILES)
	@echo "Go generation complete."

go: golang

gen: help

clean: check-out-dir check-clean-dir
	@echo "Cleaning generated files in $(OUT_DIR)..."
	rm -rf "$(OUT_DIR)"/*
	@echo "Cleanup complete."

check-out-dir:
	@if [ -z "$(OUT_DIR)" ]; then \
		echo "OUT_DIR is required."; \
		echo "Example: make typescript OUT_DIR=../frontend/src/pb"; \
		exit 1; \
	fi

check-proto-files:
	@if [ -z "$(PROTO_FILES)" ]; then \
		echo "No .proto files found in $(PROTO_DIR)."; \
		exit 1; \
	fi

check-clean-dir:
	@case "$(OUT_DIR)" in \
		"."|"./"|"/") \
			echo "Refusing to clean OUT_DIR=$(OUT_DIR). Please pass a generated output directory."; \
			exit 1; \
			;; \
	esac
