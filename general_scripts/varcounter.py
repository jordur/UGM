import re
import optparse
import operator

# Arguments
parser = optparse.OptionParser()
parser.add_option("-t", "--table", action="store",dest="vartable")
parser.add_option("-o", "--outfile", action="store",dest="output",default="varcount.txt")

options, args = parser.parse_args()


vartable=options.vartable
outputname=options.output


#vartable="table.txt"
#output="varcount.txt"

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

outputLines=[]
for variante in varcontent:
    # inicializamos contadores
    ADhetcount=0
    ADhomcount=0
    ADtotal=0

    MCIhetcount=0
    MCIhomcount=0
    MCItotal=0

    Controlhetcount=0
    Controlhomcount=0
    Controltotal=0

    ACtotal=0

    # Extraemos la información de las variantes
    var= variante[chrindex] + "_" + variante[posindex] + "_" + variante[refindex] + "/" + variante[altindex]
    symbol=variante[symbolindex]
    varid=variante[variationidindex]
    for i in ADindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[i]):
            ADhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[i]):
            ADhomcount+=1
        else:
            pass
    ADtotal=ADhetcount+ADhomcount
    for j in MCIindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[j]):
            MCIhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[j]):
            MCIhomcount+=1
        else:
            pass
    MCItotal=MCIhetcount+MCIhomcount
    for k in Controlindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[k]):
            Controlhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[k]):
            Controlhomcount+=1
        else:
            pass
    Controltotal=Controlhetcount+Controlhomcount

    ACtotal=ADtotal+MCItotal+Controltotal

    linea=[var, symbol, varid, str(ADhetcount), str(ADhomcount), str(ADtotal), str(MCIhetcount), str(MCIhomcount), str(MCItotal), str(Controlhetcount), str(Controlhomcount), str(Controltotal), str(ACtotal)]
    outputLines.append(linea)

outputHeader=["variante", "symbol", "varid", "AD het count", "AD hom count", "AD total", "MCI het count", "MCI hom count", "MCI total", "Control het count", "Control hom count", "Control total", "AC total"]

with open (outputname, "w", encoding="UTF-8") as output:
    output.write("\t".join(outputHeader)+"\n")
    for outline in outputLines:
        output.write("\t".join(outline)+"\n")