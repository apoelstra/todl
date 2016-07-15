
#Parameters for secp256k1
F = FiniteField (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F)
C = EllipticCurve ([F (0), F (7)])
G = C.lift_x(0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798)


def hex_format(number):
    L = []
    while number > 0:
        L.append(int(number) % (2 ** 32))
        number = integer_floor(int(number) / (2 ** 32))
    L.reverse()
    return " ".join(["%08x" % x for x in L])


def print_point(name, p):
    x, y = p.xy()

    print "$%s$ &" % name
    print "\\texttt{0x%s}, \\newline" % hex_format(x)
    print "\\texttt{0x%s} \\\\" % hex_format(y)
    print "\hline"

def print_list(L, first_skip, reg_skip):
    for i, (name, mult) in enumerate(L):
        if i == first_skip:
            print "\\end{tabularx}"
            print "\\begin{tabularx}{\\textwidth}{||c|X||}"
            print "\\hline"
        elif i > first_skip and i % reg_skip == (first_skip % reg_skip):
            print "\\end{tabularx}"
            print "\\begin{tabularx}{\\textwidth}{||c|X||}"
            print "\\hline"

        print_point(name, mult * G)


### UNCOMMENT WHATEVER YOU WANT TO PRINT. PIPE INTO XSEL TO COPY/PASTE
# 1.1 Powers of Two
#print_list([("2^{%d}G" % i, 2 ** i) for i in xrange(0, 256)], 9, 20)
# 1.2 Base 4 digits
#print_list([("%d \\times 2^{%d}G" % (j, i * 2), j * 2 ** (i * 2)) for i in xrange(0, 128) for j in xrange(1,4)], 9, 20)
# 1.3 Base 16 digits
#print_list([("%d \\times 2^{%d}G" % (j, i * 4), j * 2 ** (i * 4)) for i in xrange(0, 64) for j in xrange(1,16)], 9, 20)
# 1.4 Base 256 digits
print_list([("%d \\times 2^{%d}G" % (j, i * 8), j * 2 ** (i * 8)) for i in xrange(0, 32) for j in xrange(1,256)], 9, 20)



