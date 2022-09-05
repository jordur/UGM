import sys

vcffilename = sys.argv[1]
outputfilename = sys.argv[2]
# vcffilename = "variants_ADgenesconscan.vcf"

newvcflines = []
## Extraemos el header principal
with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        if vcfline.startswith("#"):
            newvcflines.append(vcfline[:-1].split(sep="\t"))
        else:
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

## Seleccionamos solo la información necesaria del header y lo introducimos donde estaba el campo INFO
headerVEP=headerVEP.split(sep="Format: ")[1][:-3].split(sep="|")
varindex = headerVEP.index("Existing_variation")

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

            newvcflines.append(varinfo)

with open(outputfilename, "w") as output:

    for outline in newvcflines:
        
        output.write("\t".join(outline)+"\n")
