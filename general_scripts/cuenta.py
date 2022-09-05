import re
import optparse
import operator

# Arguments
parser = optparse.OptionParser()
parser.add_option("-t", "--table", action="store",dest="vartable")
parser.add_option("-o", "--outfile", action="store",dest="output",default="varcount_bien.txt")

options, args = parser.parse_args()


vartable=options.vartable
outputname=options.output


vartable="selected-variants.tsv"
output="pitoculocuenta.tsv"

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
# symbolindex=header.index("SYMBOL")
variationidindex=header.index("ID")

outputLines=[]
for variante in varcontent:
    # inicializamos contadores
    ADhetcount=0
    ADhomcount=0
    ADhomrefcount = 0
    ADtotal=0

    MCIhetcount=0
    MCIhomcount=0
    MCIhomrefcount = 0
    MCItotal=0

    Controlhetcount=0
    Controlhomcount=0
    Controlhomrefcount = 0
    Controltotal=0

    ACtotal=0


    # Extraemos la información de las variantes
    var= variante[chrindex] + "_" + variante[posindex] + "_" + variante[refindex] + "/" + variante[altindex]
    # symbol=variante[symbolindex]
    varid=variante[variationidindex]
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
    ADALTS = 2*ADhomcount + ADhetcount
    ADREFS = 2*ADhomrefcount + ADhetcount
    ADtotal=ADhetcount+ADhomcount+MCIhomrefcount
    for j in MCIindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[j]):
            MCIhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[j]):
            MCIhomcount+=1
        # hom ref
        elif re.search("(0\/0|0\|0)", variante[j]):
            MCIhomrefcount+=1
        else:
            pass
    MCItotal=MCIhetcount+MCIhomcount+MCIhomrefcount
    MCIALTS=2*MCIhomcount + MCIhetcount
    MCIREFS=2*MCIhomrefcount + MCIhetcount
    for k in Controlindex:
        # het
        if re.search("(0\/1|1\/0|0\|1|1\|0)", variante[k]):
            Controlhetcount+=1
        # hom
        elif re.search("(1\/1|1\|1)", variante[k]):
            Controlhomcount+=1
        # hom ref
        elif re.search("(0\/0|0\|0)", variante[k]):
            Controlhomrefcount+=1
        else:
            pass
    Controltotal=Controlhetcount+Controlhomcount+Controlhomrefcount
    ControlALTS = 2*Controlhomcount + Controlhetcount
    ControlREFS = 2*Controlhomrefcount + Controlhetcount


    ACtotal=ADtotal+MCItotal+Controltotal

    # linea=[var, varid, str(ADhetcount), str(ADhomcount), str(ADhomrefcount),str(ADtotal), str(MCIhetcount), str(MCIhomcount), str(MCIhomrefcount), str(MCItotal), str(Controlhetcount), str(Controlhomcount), str(Controlhomrefcount),str(Controltotal), str(ACtotal)]
    

    linea = [var, varid, str(ADALTS), str(ADREFS), str(MCIALTS), str(MCIREFS), str(ControlALTS), str(ControlREFS)]
    outputLines.append(linea)

# outputHeader=["variante", "varid", "AD het count", "AD hom count", "AD hom ref count", "AD total", "MCI het count", "MCI hom count","MCI hom ref count", "MCI total", "Control het count", "Control hom count", "Control hom ref count", "Control total", "AC total"]
outputHeader=["variante", "varid", "AD ALTS", "AD REFS", "MCI ALTS", "MCI REFS", "Control ALTS", "Control REFS"]

with open (outputname, "w", encoding="UTF-8") as output:
    output.write("\t".join(outputHeader)+"\n")
    for outline in outputLines:
        output.write("\t".join(outline)+"\n")