.PHONY: all build build-rust build-js build-python build-go run clean

# ── Default ──────────────────────────────────────────────────────────────────
all: build

# ── Individual build steps ────────────────────────────────────────────────────
build-rust:
	@echo "▶ [cargo] building rust/foo ..."
	cd rust && cargo build --release

build-js:
	@echo "▶ [npm] installing js dependencies ..."
	cd js && npm install

build-python:
	@echo "▶ [pip] installing python dependencies ..."
	pip install --quiet -r python/requirements.txt

build-go: build-rust build-js build-python
	@echo "▶ [go] building go/foobar ..."
	mkdir -p bin
	cd go && go mod tidy && go build -o ../bin/foobar .

# ── Full build ────────────────────────────────────────────────────────────────
build: build-rust build-js build-python build-go
	@echo ""
	@echo "✔ All components built successfully."

# ── Run ───────────────────────────────────────────────────────────────────────
run: build
	@echo ""
	./bin/foobar

# ── Bazel (alternative full build) ───────────────────────────────────────────
bazel-build:
	bazel build //...

bazel-run:
	bazel run //:run

# ── Clean ─────────────────────────────────────────────────────────────────────
clean:
	cd rust && cargo clean
	rm -rf js/node_modules
	rm -rf bin
	cd go && go clean
