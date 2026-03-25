use colored::Colorize;

fn main() {
    // Print "foo" without a newline so it can be concatenated with "bar"
    print!("{}", "foo".red().bold());
}
