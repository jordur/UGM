import re
import optparse
import operator

# Arguments
parser = optparse.OptionParser()
parser.add_option("-t", "--table", action="store",dest="vartable")
parser.add_option("-o", "--outfile", action="store",dest="output",default="varcount.tsv")

options, args = parser.parse_args()


vartable=options.vartable
outputname=options.output


#vartable="table.txt"
#outputname="varcuentecita.tsv"

ADfile="AD.args"
MCIfile="MCI.args"
Controlfile="control.args"


# Extraemos info de la tabla
with open(vartable, "r") as table:
    header=table.readline()[:-1].split(sep="\t")
    varcontent=[]
    for item in table.readlines():
        varcontent.append(item[:-1].split(sep="\t"))


# Extraemos las muestras por grupos y otenemos los índices que tienen en la tabla
with open(ADfile, "r") as AD:
    ADargs=[]
    for item in AD:
        ADargs.append(item.strip())
    ADindex=[]
    for item in ADargs:
        index=header.index(item)
        ADindex.append(index)

with open(MCIfile, "r") as MCI:
    MCIargs=[]
    for item in MCI:
        MCIargs.append(item.strip())
    MCIindex=[]
    for item in MCIargs:
        index=header.index(item)
        MCIindex.append(index)

with open(Controlfile, "r") as Control:
    Controlargs= []
    for item in Control:
        Controlargs.append(item.strip())
    Controlindex=[]
    for item in Controlargs:
        index=header.index(item)
        Controlindex.append(index)




chrindex=header.index("CHROM")
posindex=header.index("POS")
refindex=header.index("REF")
altindex=header.index("ALT")
symbolindex=header.index("SYMBOL")
variationidindex=header.index("Existing_variation")
gnomADindex=header.index("gnomAD_NFE_AF")

outputLines=[]
for variante in varcontent:
    # inicializamos contadores
    ADhomrefcount=0
    ADhetcount=0
    ADhomcount=0

    MCIhomrefcount=0
    MCIhetcount=0
    MCIhomcount=0

    Controlhomrefcount=0
    Controlhetcount=0
    Controlhomcount=0

    # Extraemos la información de las variantes
    var= variante[chrindex] + "_" + variante[posindex] + "_" + variante[refindex] + "/" + variante[altindex]
    symbol=variante[symbolindex]
    varid=variante[variationidindex]
    gnomAD=variante[gnomADindex]
    for i in ADindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[i]):
            ADhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[i]):
            ADhomcount+=1
        # hom ref
        elif re.search("(0\/0|0\|0)", variante[i]):
            ADhomrefcount+=1
        else:
            pass

    for j in MCIindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[j]):
            MCIhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[j]):
            MCIhomcount+=1
        # hom ref
        elif re.search("(0\/0|0\|0)", variante[i]):
            MCIhomrefcount+=1
        else:
            pass

    for k in Controlindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[k]):
            Controlhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[k]):
            Controlhomcount+=1
        # hom ref
        elif re.search("(0\/0|0\|0)", variante[i]):
            Controlhomrefcount+=1
        else:
            pass

    linea=[var, symbol, varid, str(gnomAD), str(ADhomrefcount), str(ADhetcount), str(ADhomcount), str(MCIhomrefcount), str(MCIhetcount), str(MCIhomcount), str(Controlhomrefcount), str(Controlhetcount), str(Controlhomcount)]
    outputLines.append(linea)

outputHeader=["variante", "symbol", "varid", "gnomAD_NFE_AF", "AD hom ref count", "AD het count", "AD hom count", "MCI hom ref count", "MCI het count", "MCI hom count", "Control hom ref count", "Control het count", "Control hom count"]

with open (outputname, "w", encoding="UTF-8") as output:
    output.write("\t".join(outputHeader)+"\n")
    for outline in outputLines:
        output.write("\t".join(outline)+"\n")
