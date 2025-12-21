#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fnmatch.h>
#include <errno.h>

enum FileType { FT_ANY = 0, FT_FILE, FT_DIR };

struct Options {
    enum FileType want_type;
    const char *name_pattern;
};

static void usage(const char *prog) {
    fprintf(stderr, "Usage: %s <path> [-type f|d] [-name pattern]\n", prog);
    exit(1);
}

static int match_type(const struct stat *st, enum FileType t) {
    if (t == FT_ANY) return 1;
    if (t == FT_FILE && S_ISREG(st->st_mode)) return 1;
    if (t == FT_DIR && S_ISDIR(st->st_mode)) return 1;
    return 0;
}

static void traverse(const char *path, struct Options *opt) {
    struct stat st;
    if (lstat(path, &st) < 0) {
        perror(path);
        return;
    }

    const char *basename = strrchr(path, '/');
    basename = basename ? (basename + 1) : path;

    int name_ok = 1;
    if (opt->name_pattern) {
        if (fnmatch(opt->name_pattern, basename, 0) != 0) {
            name_ok = 0;
        }
    }

    if (name_ok && match_type(&st, opt->want_type)) {
        printf("%s\n", path);
    }

    if (S_ISDIR(st.st_mode)) {
        DIR *dp = opendir(path);
        if (!dp) {
            perror(path);
            return;
        }
        struct dirent *de;
        while ((de = readdir(dp))) {
            if (strcmp(de->d_name, ".") == 0 || strcmp(de->d_name, "..") == 0)
                continue;
            char buf[PATH_MAX];
            snprintf(buf, sizeof(buf), "%s/%s", path, de->d_name);
            traverse(buf, opt);
        }
        closedir(dp);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) usage(argv[0]);

    struct Options opt = { FT_ANY, NULL };
    const char *start = NULL;

    // simple parsing: first non-option is path
    int i;
    for (i = 1; i < argc; i++) {
        if (argv[i][0] != '-') {
            if (!start) start = argv[i];
            else usage(argv[0]);
        } else if (strcmp(argv[i], "-type") == 0) {
            if (i + 1 >= argc) usage(argv[0]);
            i++;
            if (argv[i][0] == 'f') opt.want_type = FT_FILE;
            else if (argv[i][0] == 'd') opt.want_type = FT_DIR;
            else usage(argv[0]);
        } else if (strcmp(argv[i], "-name") == 0) {
            if (i + 1 >= argc) usage(argv[0]);
            i++;
            opt.name_pattern = argv[i];
        } else {
            usage(argv[0]);
        }
    }

    if (!start) usage(argv[0]);
    traverse(start, &opt);
    return 0;
}

