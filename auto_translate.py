import sys

from potpie.__main__ import translate

# Generate translations using the potpie package
if __name__ == "__main__":

    # Supported potpie translation types
    types = ["mixed", "planguage", "unicode", "brackets", "extend"]

    if len(sys.argv) != 4 or sys.argv[3] not in types:
        print "Usage: auto_translate.py <infile> <outfile> <type>"
        print "type: %s" % types
    else:
        translate(sys.argv[1], sys.argv[2], sys.argv[3])
