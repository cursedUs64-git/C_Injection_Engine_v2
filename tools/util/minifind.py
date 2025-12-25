import os
import fnmatch
import sys

class FileType:
    ANY = 0
    FILE = 1
    DIR = 2

class Options:
    def __init__(self):
        self.want_type = FileType.ANY
        self.name_pattern = None

def usage(prog):
    print(f"Usage: {prog} <path> [-type f|d] [-name pattern]")
    sys.exit(1)

def match_type(path, file_type):
    """Match the file type (regular file or directory)."""
    if file_type == FileType.ANY:
        return True
    try:
        stat_info = os.lstat(path)
        if file_type == FileType.FILE and os.path.isfile(path):
            return True
        if file_type == FileType.DIR and os.path.isdir(path):
            return True
    except OSError:
        return False
    return False

def traverse(path, opt):
    """Traverse the directory and print matching files."""
    try:
        stat_info = os.lstat(path)
        basename = os.path.basename(path)
        name_ok = True

        # Check if the basename matches the pattern
        if opt.name_pattern and fnmatch.fnmatch(basename, opt.name_pattern) == False:
            name_ok = False

        # If the name matches and the type is correct, print the path
        if name_ok and match_type(path, opt.want_type):
            print(path)

        # If it's a directory, recursively traverse it
        if os.path.isdir(path):
            try:
                for entry in os.listdir(path):
                    full_path = os.path.join(path, entry)
                    if entry != '.' and entry != '..':
                        traverse(full_path, opt)
            except OSError:
                pass

    except OSError as e:
        print(f"Error: {e.strerror} - {path}")

def main():
    if len(sys.argv) < 2:
        usage(sys.argv[0])

    # Initialize the options
    opt = Options()
    start = None

    # Parse arguments
    i = 1
    while i < len(sys.argv):
        if sys.argv[i][0] != '-':
            if not start:
                start = sys.argv[i]
            else:
                usage(sys.argv[0])
        elif sys.argv[i] == "-type":
            if i + 1 >= len(sys.argv):
                usage(sys.argv[0])
            i += 1
            if sys.argv[i] == "f":
                opt.want_type = FileType.FILE
            elif sys.argv[i] == "d":
                opt.want_type = FileType.DIR
            else:
                usage(sys.argv[0])
        elif sys.argv[i] == "-name":
            if i + 1 >= len(sys.argv):
                usage(sys.argv[0])
            i += 1
            opt.name_pattern = sys.argv[i]
        else:
            usage(sys.argv[0])
        i += 1

    if not start:
        usage(sys.argv[0])

    traverse(start, opt)

if __name__ == "__main__":
    main()

