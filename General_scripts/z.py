import re
import optparse
import operator

# Arguments
parser = optparse.OptionParser()
parser.add_option("-t", "--table", action="store",dest="vartable")
parser.add_option("-o", "--outfile", action="store",dest="output",default="z.tsv")

options, args = parser.parse_args()


vartable=options.vartable
outputname=options.output

#vartable="table.txt"
#outputname="z.tsv"

# Extraemos info de la tabla
with open(vartable, "r") as table:
    header=table.readline()[:-1].split(sep="\t")
    varcontent=[]
    for item in table.readlines():
        varcontent.append(item[:-1].split(sep="\t"))


chrindex=header.index("CHROM")
posindex=header.index("POS")
formatindex=header.index("FORMAT")
muestras=header[formatindex+1:]
muestrasindex=[ header.index(muestra) for muestra in muestras ]


outputLines=[]
for variante in varcontent:
    linea=[]
    var = variante[chrindex] + ":" + variante[posindex]
    linea.append(var)
    for indiv in muestrasindex:
        # hom ref
        if re.search("(0\/0|0\|0)", variante[indiv]):
            herency='0'
        # het
        elif re.search("(0\/1|1\/0|0\|1|1\|0)", variante[indiv]):
            herency='1'
        # hom alt
        elif re.search("(1\/1|1\|1)", variante[indiv]):
            herency='2'
        else:
            herency='9'

        linea.append(herency)
    
    outputLines.append(linea)

outputHeader='\t'
for muestra in muestras:
    outputHeader+=muestra+'\t'

with open (outputname, "w", encoding="UTF-8") as output:
    output.write(outputHeader[:-1] + "\n")
    for outline in outputLines:
        output.write("\t".join(outline)+"\n")
        
