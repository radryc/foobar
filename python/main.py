"""python/main.py — pip component.

Independently assembles and prints 'foobar' using colorama.
Also usable as a library by the Go orchestrator.
"""

import sys
import colorama
from colorama import Fore, Style

colorama.init(autoreset=True)


def main() -> None:
    foo = Fore.RED + Style.BRIGHT + "foo"
    bar = Fore.BLUE + Style.BRIGHT + "bar"
    result = foo + bar + Style.RESET_ALL
    sys.stdout.write(result)
    sys.stdout.flush()


if __name__ == "__main__":
    main()
