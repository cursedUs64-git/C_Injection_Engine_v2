import os
import re
import sys

MAX_LINE = 8192
RAW_ADDR_BUF = 64
FILENAME_MAX = 4096


class Symbol:
    def __init__(self, name, address, raw_addr):
        self.name = name
        self.address = address
        self.raw_addr = raw_addr


symbols = []
insertion_order = []


def trim(s):
    return s.strip()


def is_valid_c_identifier(s):
    """Check if string is a valid C identifier."""
    if s is None or len(s) == 0:
        return False
    if not s[0].isalpha() and s[0] != '_':
        return False
    for c in s[1:]:
        if not (c.isalnum() or c == '_'):
            return False
    return True


def looks_like_number(s):
    """Check if string looks like a number or hex literal."""
    if s is None or len(s) == 0:
        return False
    if s.startswith('0x') or s.startswith('0X'):
        return all(c in '0123456789abcdefABCDEF' for c in s[2:])
    return s.isdigit()


def find_address(line):
    """Find candidate address substring."""
    pattern = r'(0x[0-9a-fA-F]+|\d+)'
    match = re.search(pattern, line)
    if match:
        return match.group(0)
    return None


def parse_address(s):
    """Parse the numeric address."""
    try:
        if s.startswith('0x') or s.startswith('0X'):
            return int(s, 16)
        return int(s, 10)
    except ValueError:
        return None


def usage(prog):
    print(f"Usage: {prog} [options] <input.map> <output.asm>")
    print("Options:")
    print("  -f <prefix>         Only accept names starting with <prefix>")
    print("  --inject-only       Generate only the _inject.asm file")
    print("  --definelabels-only Generate only the output.asm file")


def add_symbol(name, address, raw_addr):
    """Add symbol to the symbols list."""
    # Check for duplicates
    for symbol in symbols:
        if symbol.name == name:
            return False  # Duplicate symbol

    symbols.append(Symbol(name, address, raw_addr))
    insertion_order.append(len(symbols) - 1)
    return True


def strip_asm_ext(input_str):
    """Remove .asm extension from file name."""
    if input_str.endswith(".asm"):
        return input_str[:-4]
    return input_str


def main():
    prefix_filter = None
    inject_only = False
    definelabels_only = False

    # Command line arguments parsing
    argi = 1
    while argi < len(sys.argv) and sys.argv[argi].startswith('-'):
        if sys.argv[argi] == "-f":
            if argi + 1 >= len(sys.argv):
                print("Error: -f requires argument")
                usage(sys.argv[0])
                return 1
            prefix_filter = sys.argv[argi + 1]
            argi += 2
        elif sys.argv[argi] == "--inject-only":
            inject_only = True
            argi += 1
        elif sys.argv[argi] == "--definelabels-only":
            definelabels_only = True
            argi += 1
        else:
            print(f"Unknown option: {sys.argv[argi]}")
            usage(sys.argv[0])
            return 1

    if inject_only and definelabels_only:
        print("Error: --inject-only and --definelabels-only are mutually exclusive")
        usage(sys.argv[0])
        return 1

    if argi + 2 != len(sys.argv):
        usage(sys.argv[0])
        return 1

    inmap = sys.argv[argi]
    outasm = sys.argv[argi + 1]

    try:
        with open(inmap, "r") as fin:
            outlabel = strip_asm_ext(outasm)
            outlabel_upper = outlabel.upper()

            fout = None
            finject = None

            if not inject_only:
                fout = open(outasm, "w")
                fout.write(f".ifndef _{outlabel_upper}_ASM_\n")
                fout.write(f".definelabel _{outlabel_upper}_ASM_, 1\n\n")

            if not definelabels_only:
                inject_name = f"{strip_asm_ext(outasm)}_inject.asm"
                finject = open(inject_name, "w")
                finject.write(f".ifndef _{outlabel_upper}_INJECT_ASM_\n")
                finject.write(f".definelabel _{outlabel_upper}_INJECT_ASM_, 1\n\n")

            for line in fin:
                addr_pos = find_address(line)
                if addr_pos is None:
                    continue

                addr_val = parse_address(addr_pos)
                if addr_val is None:
                    continue

                raw_addr = addr_pos

                name_start = addr_pos[len(raw_addr):].lstrip()
                if not name_start:
                    continue

                name_end = re.search(r'\s', name_start)
                if name_end:
                    name_end = name_end.start()
                    name_start = name_start[:name_end]
                else:
                    name_end = len(name_start)

                saved = name_start[name_end:]
                name_start = name_start[:name_end]

                if not is_valid_c_identifier(name_start):
                    name_start = saved
                    continue
                if looks_like_number(name_start):
                    name_start = saved
                    continue
                if prefix_filter and not name_start.startswith(prefix_filter):
                    name_start = saved
                    continue

                if not add_symbol(name_start, addr_val, raw_addr):
                    name_start = saved
                    continue

            # Writing the output files
            if fout:
                for idx in insertion_order:
                    sym = symbols[idx]
                    fout.write(f".definelabel {sym.name}, {sym.raw_addr}\n")
                fout.write("\n.endif\n")
                fout.close()

            if finject:
                for idx in insertion_order:
                    curr = symbols[idx]
                    next_sym = symbols[idx + 1] if idx + 1 < len(symbols) else None
                    if next_sym:
                        finject.write(f"/* {curr.name} - {next_sym.name} */\n")
                        finject.write(f".org {curr.raw_addr}\n")
                        finject.write(f".area {next_sym.raw_addr} - {curr.raw_addr}\n")
                        finject.write(".importobj \"\"\n")
                        finject.write(".endarea\n\n")
                    else:
                        finject.write(f"/* {curr.name} - ??? */\n")
                        finject.write(f".org {curr.raw_addr}\n")
                        finject.write("/* .area ??? - {curr.raw_addr} */\n")
                        finject.write("/* .importobj \"\" */\n")
                        finject.write("/* .endarea */\n\n")
                finject.write(".endif\n")
                finject.close()

    except Exception as e:
        print(f"Error: {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())

