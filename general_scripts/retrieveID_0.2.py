import optparse
import operator

# cambios de la versión 0.2:
#   Le he puesto entrada por argumentos (que no solo sea posicional)
#   ahora los IDs que sean missing pillan la forma chr:pos

parser = optparse.OptionParser()
parser.add_option("-v", "--vcffile", action="store",dest="vcffilename")
parser.add_option("-o", "--outfile", action="store",dest="outfilename",default="vcftotable.txt")

options, args = parser.parse_args()

vcffilename=options.vcffilename
outputfilename=options.outfilename

# vcffilename="variants_ADgenesconscan.vcf"
# outputfilename="try"

newvcflines = []
## Extraemos el header principal
with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        if vcfline.startswith("#"):
            newvcflines.append(vcfline[:-1].split(sep="\t"))
            
        else:
            infoheader = newvcflines[-1]
            break

## Extraemos el header de VEP
with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        if vcfline.startswith("#"):
            if "##INFO=<ID=CSQ" in vcfline:
                headerVEP=vcfline
            else:
                pass
        else:
            break

## Seleccionamos solo la información necesaria del header
headerVEP=headerVEP.split(sep="Format: ")[1][:-3].split(sep="|")
varindex = headerVEP.index("Existing_variation")
chromindex = infoheader.index("#CHROM")
posindex = infoheader.index("POS")

with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        # escogemos las líneas de información de variantes
        if vcfline.startswith("#")==False:
            # Extraemos la información tabulada
            varinfo = vcfline[:-1].split(sep="\t")
            # print(varinfo)
            vepinfo = varinfo[7].split(sep=";CSQ=")[1]
            rsID = vepinfo.split(sep="|")[varindex].split(sep="&")[0]
            if rsID.startswith("rs"):
                varinfo.pop(2)
                varinfo.insert(2, rsID)
            else:
                varinfo.pop(2)
                norsID = str(varinfo[chromindex] + ":" + varinfo[posindex])
                varinfo.insert(2, norsID)

            newvcflines.append(varinfo)

with open(outputfilename, "w") as output:

    for outline in newvcflines:
        
        output.write("\t".join(outline)+"\n")