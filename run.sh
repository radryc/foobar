#!/usr/bin/env bash
# run.sh — Build all components and launch the foobar app.
# Works both as a plain shell script and as a Bazel sh_binary data runner.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "╔══════════════════════════════╗"
echo "║  FooBar — build & run        ║"
echo "╚══════════════════════════════╝"
echo ""

# ── 1. Rust (cargo) ──────────────────────────────────────────────────────────
echo "▶ [cargo] building rust/foo ..."
(cd "$ROOT/rust" && cargo build --release --quiet)

# ── 2. npm ───────────────────────────────────────────────────────────────────
echo "▶ [npm] installing js/bar dependencies ..."
(cd "$ROOT/js" && npm install --silent)

# ── 3. pip ───────────────────────────────────────────────────────────────────
echo "▶ [pip] installing python dependencies ..."
pip install --quiet -r "$ROOT/python/requirements.txt"

# ── 4. Go ────────────────────────────────────────────────────────────────────
echo "▶ [go] building go/foobar ..."
mkdir -p "$ROOT/bin"
(cd "$ROOT/go" && go mod tidy -quiet && go build -o "$ROOT/bin/foobar" .)

echo ""
echo "═══════════════════════════════"
echo " Running foobar …"
echo "═══════════════════════════════"
echo ""

"$ROOT/bin/foobar"
