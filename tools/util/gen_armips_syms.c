// Made by AmitabhTechz
// License: GPLv3

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>

#define MAX_LINE 8192
#define RAW_ADDR_BUF 64
#define FILENAME_MAX 4096

typedef struct Symbol {
    char *name;
    unsigned long address;
    char *raw_addr;  // store original address string (with leading zeros)
} Symbol;

static Symbol *symbols = NULL;
static size_t symbols_count = 0;
static size_t symbols_capacity = 0;

static size_t *insertion_order = NULL;  // store indexes into symbols[]
static size_t insertion_count = 0;
static size_t insertion_capacity = 0;

// Trim leading + trailing whitespace in-place
static void trim(char *s) {
    char *end;
    // trim trailing
    end = s + strlen(s) - 1;
    while (end >= s && isspace((unsigned char)*end)) {
        *end = '\0';
        end--;
    }
    // trim leading
    char *start = s;
    while (*start && isspace((unsigned char)*start)) {
        start++;
    }
    if (start != s) {
        memmove(s, start, strlen(start) + 1);
    }
}

// Check if string is a valid C identifier
static int is_valid_c_identifier(const char *s) {
    if (s == NULL || *s == '\0') return 0;
    if (!(isalpha((unsigned char)s[0]) || s[0] == '_')) {
        return 0;
    }
    for (const char *p = s + 1; *p; p++) {
        if (!(isalnum((unsigned char)*p) || *p == '_')) {
            return 0;
        }
    }
    return 1;
}

// Check if looks like a numeric or hex literal
static int looks_like_number(const char *s) {
    if (s == NULL || *s == '\0') return 0;
    if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) {
        const char *p = s + 2;
        if (*p == '\0') return 0;
        for (; *p; p++) {
            if (!isxdigit((unsigned char)*p)) {
                return 0;
            }
        }
        return 1;
    }
    const char *p = s;
    while (*p) {
        if (!isdigit((unsigned char)*p)) {
            return 0;
        }
        p++;
    }
    return 1;
}

// Find candidate address substring
static char *find_address(const char *line) {
    const char *p = line;
    while (*p) {
        if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X')) {
            const char *q = p + 2;
            if (isxdigit((unsigned char)*q)) {
                return (char *)p;
            }
        }
        if (isdigit((unsigned char)*p)) {
            const char *q = p;
            while (isdigit((unsigned char)*q)) q++;
            if ((q - p) >= 1) {
                return (char *)p;
            }
        }
        p++;
    }
    return NULL;
}

// Parse the numeric address
// Returns number of characters consumed, or 0 if failure
static int parse_address(const char *s, unsigned long *out_addr) {
    char *endptr;
    errno = 0;
    if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) {
        *out_addr = strtoul(s, &endptr, 16);
    } else {
        *out_addr = strtoul(s, &endptr, 10);
    }
    if (errno != 0) {
        return 0;
    }
    if (endptr == s) {
        return 0;
    }
    return (int)(endptr - s);
}

static void usage(const char *prog) {
    fprintf(stderr,
        "Usage: %s [options] <input.map> <output.asm>\n"
        "Options:\n"
        "  -f <prefix>         Only accept names starting with <prefix>\n"
        "  --inject-only       Generate only the _inject.asm file\n"
        "  --definelabels-only Generate only the output.asm file\n",
        prog);
}

static int add_symbol(const char *name, unsigned long address, const char *raw_addr) {
    // Check duplicates
    for (size_t i = 0; i < symbols_count; i++) {
        if (strcmp(symbols[i].name, name) == 0) {
            return 0; // duplicate, skip
        }
    }

    // Expand storage if needed
    if (symbols_count >= symbols_capacity) {
        size_t newcap = symbols_capacity ? symbols_capacity * 2 : 64;
        Symbol *tmp = realloc(symbols, newcap * sizeof(Symbol));
        if (!tmp) {
            fprintf(stderr, "Memory allocation failure\n");
            return -1;
        }
        symbols = tmp;
        symbols_capacity = newcap;
    }
    if (insertion_count >= insertion_capacity) {
        size_t newcap = insertion_capacity ? insertion_capacity * 2 : 64;
        size_t *tmp2 = realloc(insertion_order, newcap * sizeof(size_t));
        if (!tmp2) {
            fprintf(stderr, "Memory allocation failure\n");
            return -1;
        }
        insertion_order = tmp2;
        insertion_capacity = newcap;
    }

    symbols[symbols_count].name = strdup(name);
    symbols[symbols_count].raw_addr = strdup(raw_addr);
    if (!symbols[symbols_count].name || !symbols[symbols_count].raw_addr) {
        fprintf(stderr, "Memory allocation failure\n");
        return -1;
    }
    symbols[symbols_count].address = address;

    insertion_order[insertion_count] = symbols_count;

    symbols_count++;
    insertion_count++;

    return 1;
}

static void free_all_symbols(void) {
    for (size_t i = 0; i < symbols_count; i++) {
        free(symbols[i].name);
        free(symbols[i].raw_addr);
    }
    free(symbols);
    free(insertion_order);
    symbols = NULL;
    insertion_order = NULL;
    symbols_count = 0;
    insertion_count = 0;
    symbols_capacity = 0;
    insertion_capacity = 0;
}

static void strip_asm_ext(const char *input, char *output, size_t outsize) {
    size_t len = strlen(input);
    if (len > 4 && strcmp(input + len - 4, ".asm") == 0) {
        if (len - 4 < outsize) {
            memcpy(output, input, len - 4);
            output[len - 4] = '\0';
        } else {
            // too small, just copy whole input (safe fallback)
            strncpy(output, input, outsize - 1);
            output[outsize - 1] = '\0';
        }
    } else {
        strncpy(output, input, outsize - 1);
        output[outsize - 1] = '\0';
    }
}

int main(int argc, char *argv[]) {
    const char *prefix_filter = NULL;
    int inject_only = 0;
    int definelabels_only = 0;

    int argi = 1;
    while (argi < argc && argv[argi][0] == '-') {
        if (strcmp(argv[argi], "-f") == 0) {
            if (argi + 1 >= argc) {
                fprintf(stderr, "Error: -f requires argument\n");
                usage(argv[0]);
                return 1;
            }
            prefix_filter = argv[argi + 1];
            argi += 2;
        } else if (strcmp(argv[argi], "--inject-only") == 0) {
            inject_only = 1;
            argi++;
        } else if (strcmp(argv[argi], "--definelabels-only") == 0) {
            definelabels_only = 1;
            argi++;
        } else {
            fprintf(stderr, "Unknown option: %s\n", argv[argi]);
            usage(argv[0]);
            return 1;
        }
    }

    if (inject_only && definelabels_only) {
        fprintf(stderr, "Error: --inject-only and --definelabels-only are mutually exclusive\n");
        usage(argv[0]);
        return 1;
    }

    if (argi + 2 != argc) {
        usage(argv[0]);
        return 1;
    }

    const char *inmap = argv[argi];
    const char *outasm = argv[argi + 1];

    FILE *fin = fopen(inmap, "r");
    if (!fin) {
        perror("fopen input");
        return 1;
    }

    FILE *fout = NULL;
    FILE *finject = NULL;

    // Prepare output label prefix (strip .asm)
    char outlabel[FILENAME_MAX];
    strip_asm_ext(outasm, outlabel, sizeof(outlabel));
    // Convert outlabel to uppercase for use in .ifndef guards
    char outlabel_upper[FILENAME_MAX];
    snprintf(outlabel_upper, sizeof(outlabel_upper), "%s", outlabel);
    for (size_t i = 0; outlabel_upper[i]; i++) {
        outlabel_upper[i] = toupper((unsigned char)outlabel_upper[i]);
    }


    if (!inject_only) {
        fout = fopen(outasm, "w");
        if (!fout) {
            perror("fopen output");
            fclose(fin);
            return 1;
        }
        // Write .ifndef guard and .definelabel at start of output.asm
        fprintf(fout, ".ifndef _%s_ASM_\n", outlabel_upper);
        fprintf(fout, ".definelabel _%s_ASM_, 1\n\n", outlabel_upper);
    }

    if (!definelabels_only) {
        char inject_name[FILENAME_MAX];
	char inject_base[FILENAME_MAX];
	strip_asm_ext(outasm, inject_base, sizeof(inject_base));
	snprintf(inject_name, sizeof(inject_name), "%s_inject.asm", inject_base);

        finject = fopen(inject_name, "w");
        if (!finject) {
            perror("fopen inject output");
            if (fout) fclose(fout);
            fclose(fin);
            return 1;
        }
        // Write .ifndef guard and .definelabel at start of inject file
        fprintf(finject, ".ifndef _%s_INJECT_ASM_\n", outlabel_upper);
        fprintf(finject, ".definelabel _%s_INJECT_ASM_, 1\n\n", outlabel_upper);
    }

    char line[MAX_LINE];
    while (fgets(line, sizeof(line), fin)) {
        char *addr_pos = find_address(line);
        if (!addr_pos) continue;

        unsigned long addr_val;
        int consumed = parse_address(addr_pos, &addr_val);
        if (consumed <= 0) continue;

        char raw_addr[RAW_ADDR_BUF];
        int i;
        for (i = 0; i < consumed && i < RAW_ADDR_BUF - 1; i++) {
            raw_addr[i] = addr_pos[i];
        }
        raw_addr[i] = '\0';

        char *name_start = addr_pos + consumed;
        while (*name_start && isspace((unsigned char)*name_start)) {
            name_start++;
        }
        if (*name_start == '\0') continue;

        char *name_end = name_start;
        while (*name_end && !isspace((unsigned char)*name_end)) {
            name_end++;
        }

        char saved = *name_end;
        *name_end = '\0';

        if (!is_valid_c_identifier(name_start)) {
            *name_end = saved;
            continue;
        }
        if (looks_like_number(name_start)) {
            *name_end = saved;
            continue;
        }
        if (prefix_filter != NULL) {
            if (strncmp(name_start, prefix_filter, strlen(prefix_filter)) != 0) {
                *name_end = saved;
                continue;
            }
        }

        int addres = add_symbol(name_start, addr_val, raw_addr);
        *name_end = saved;
        if (addres < 0) {
            // Memory error, break parsing
            break;
        }
        // If duplicate (0), skip silently
    }

    // Write output.asm .definelabels (original order)
    if (fout) {
        for (size_t i = 0; i < insertion_count; i++) {
            Symbol *sym = &symbols[insertion_order[i]];
            fprintf(fout, ".definelabel %s, %s\n", sym->name, sym->raw_addr);
        }
        fprintf(fout, "\n.endif\n");
        fclose(fout);
    }

    // Write _inject.asm in original order with comments
    if (finject) {
        for (size_t i = 0; i < insertion_count; i++) {
            Symbol *curr = &symbols[insertion_order[i]];
            Symbol *next = (i + 1 < insertion_count) ? &symbols[insertion_order[i + 1]] : NULL;
            if (next) {
                fprintf(finject,
                    "/* %s - %s */\n"
                    ".org %s\n"
                    ".area %s - %s\n"
                    ".importobj \"\"\n"
                    ".endarea\n\n",
                    curr->name, next->name,
                    curr->raw_addr,
                    next->raw_addr, curr->raw_addr);
            } else {
                // Last symbol: no next address known
                fprintf(finject,
                    "/* %s - ??? */\n"
                    ".org %s\n"
                    "/* .area ??? - %s */\n"
                    "/* .importobj \"\" */\n"
                    "/* .endarea */\n\n",
                    curr->name,
                    curr->raw_addr,
                    curr->raw_addr);
            }
        }
        fprintf(finject, ".endif\n");
        fclose(finject);
    }

    fclose(fin);
    free_all_symbols();

    return 0;
}

