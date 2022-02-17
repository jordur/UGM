
import optparse
import operator

# Arguments
parser = optparse.OptionParser()
parser.add_option("-t", "--table", action="store",dest="vartable")
parser.add_option("-o", "--outfile", action="store",dest="output",default="SetID.tsv")

options, args = parser.parse_args()


vartable=options.vartable
outputname=options.output

# Extraemos info de la tabla
with open(vartable, "r") as table:
    header=table.readline()[:-1].split(sep="\t")
    varcontent=[]
    for item in table.readlines():
        varcontent.append(item[:-1].split(sep="\t"))


chrindex=header.index("CHROM")
posindex=header.index("POS")
symbolindex=header.index("SYMBOL")



outputLines=[]
for variante in varcontent:
    linea=[]
    symbol = variante[symbolindex]
    var = variante[chrindex] + ":" + variante[posindex]
    
    outputLines.append([symbol, var])



with open (outputname, "w", encoding="UTF-8") as output:

    for outline in outputLines:
        output.write("\t".join(outline)+"\n")
        
