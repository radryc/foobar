package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"

	"github.com/fatih/color"
)

func main() {
	header := color.New(color.FgCyan, color.Bold)
	success := color.New(color.FgGreen, color.Bold)
	label := color.New(color.FgYellow)

	header.Println("╔══════════════════════════════╗")
	header.Println("║    FooBar Application v1.0   ║")
	header.Println("╚══════════════════════════════╝")
	fmt.Println()

	// Locate the repo root (one directory above this binary's location)
	exe, _ := os.Executable()
	root := filepath.Dir(filepath.Dir(exe))
	if _, err := os.Stat(filepath.Join(root, "rust")); os.IsNotExist(err) {
		// Running from source via `go run` — root is one level up from go/
		_, file, _, _ := runtime.Caller(0)
		root = filepath.Dir(filepath.Dir(file))
	}

	// ── Rust component → prints "foo" ───────────────────────────────────────
	label.Print("[rust/cargo]  ")
	rustBin := filepath.Join(root, "rust", "target", "release", "foo")
	fooOut := runComponent(rustBin)
	fmt.Printf("output: %q\n", fooOut)

	// ── Node.js component → prints "bar" ────────────────────────────────────
	label.Print("[js/npm]      ")
	jsScript := filepath.Join(root, "js", "index.js")
	barOut := runComponentArgs("node", jsScript)
	fmt.Printf("output: %q\n", barOut)

	// ── Python component → prints combined "foobar" ─────────────────────────
	label.Print("[python/pip]  ")
	pyScript := filepath.Join(root, "python", "main.py")
	pyOut := runComponentArgs("python3", pyScript)
	fmt.Printf("output: %q\n", pyOut)

	fmt.Println()
	success.Print("▶ Combined result: ")
	color.New(color.FgMagenta, color.Bold).Println(fooOut + barOut)
	fmt.Println()
	label.Println("Built with: Go · npm · pip · cargo · Bazel")
}

func runComponent(bin string) string {
	cmd := exec.Command(bin)
	out, err := cmd.Output()
	if err != nil {
		return "<error: " + err.Error() + ">"
	}
	return string(out)
}

func runComponentArgs(prog string, args ...string) string {
	cmd := exec.Command(prog, args...)
	out, err := cmd.Output()
	if err != nil {
		return "<error: " + err.Error() + ">"
	}
	return string(out)
}
