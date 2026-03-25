// js/index.js  — npm component, prints "bar"
const chalk = require("chalk");

// Write "bar" without a trailing newline so Go can combine it cleanly
process.stdout.write(chalk.blue.bold("bar"));
