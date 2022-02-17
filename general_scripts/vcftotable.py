import optparse
import operator

# Arguments
parser = optparse.OptionParser()
parser.add_option("-v", "--vcffile", action="store",dest="vcffilename")
parser.add_option("-o", "--outfile", action="store",dest="outfilename",default="vcftotable.txt")

options, args = parser.parse_args()

vcffilename=options.vcffilename
outfilename=options.outfilename

## Extraemos el header principal
with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        if vcfline.startswith("#"):
            if "#CHROM" in vcfline:
                header=vcfline
            else:
                pass
        else:
            break
## tratamos el header principal y el índice
header=header[1:-1].split(sep="\t")
infofieldindex = header.index("INFO")

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

header.pop(infofieldindex)

for item in reversed(headerVEP):
    header.insert(infofieldindex, item)



## Aun queda otra, que en info no solo está la info de VEP (CSQ), necesitamos el resto, para ello se obtiene a partir de la
## primera línea que sea informativa (solo se me ocurría eso o a mano, y no se qué es peor)

with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        if vcfline.startswith("#")==False:
            vcfinfo = vcfline.split(sep=";CSQ=")[0].split(sep="\t")[-1].split(sep=";")
            break

## le quitamos los valores y los introducimos en una nueva lista
namesvcfinfo=[]
for infoitem in vcfinfo[0:5]:
    item = infoitem.split(sep="=")[0]
    namesvcfinfo.append(item)

## Los introducimos en el orden que toca, igual que antes, para que el orden sea el mismo exactamente que en el vcf

for item in reversed(namesvcfinfo):
    header.insert(infofieldindex, item)

### Ahora viene la parte divertida, que es sacar la información de los campos
## Cosas a tener en cuenta, el campo VEP aparece varias veces en cada fila, separada por ','. Tendrá que haber tantas repeticiones de cada fila como
## campos de VEP haya (al igual que hacía por ejemplo el VEP en formato tabular), luego se podría restringir a que solo tenga una por ejemplo, porque
## aun restringiendo el filtro a canonicas se repetían variantes

## También tendremos que tener en cuenta mantener el orden exacto de todos los campos, a ver qué tal la vaina
lines=[]
with open(vcffilename, "r", encoding="UTF-8") as vcffile:
    for vcfline in vcffile:
        # escogemos las líneas de información de variantes
        if vcfline.startswith("#")==False:
            # Extraemos la información tabulada
            varinfo = vcfline[:-1].split(sep="\t")
            # Separamos el campo INFO, y lo metemos en una lista donde estará la parte de datos y de vep por separado
            infoinfo = varinfo[infofieldindex].split(sep=";CSQ=")

            # separamos los campos en la data
            vardata = infoinfo[0].split(sep=";")

            datavcfinfo=[] # lista nueva para almacenar los datos
            for infoitem in vardata[0:5]:
                data=infoitem.split(sep="=")[-1]
                datavcfinfo.append(data)
            # introducimos cada anotación de cada variante en una lista y hacemos el conteo de cuantas hay para repetir las variantes
            vepinfo=infoinfo[1].split(sep=",")
            nvar = len(vepinfo)
            # hacemos que cada anotación vep se separe por los |
            vepinfoeach=[]
            for item in vepinfo:
                vepinfoeach.append(item.split(sep="|"))            
            # eliminamos el campo de INFO de la línea de la variante
            varinfo.pop(infofieldindex)
            # habrá que tener tantas variantes copiadas como campos de anotación vep haya
            # generamos un bucle que tenga este rango e itere sobre la lista de anotaciones vep
            # creo una copia para poder resetear la variante al final del bucle
            for i in range(nvar):
                varcopy=varinfo[:]
                for item in reversed(vepinfoeach[i]):
                    varcopy.insert(infofieldindex, item)

                for item in reversed(datavcfinfo):
                    varcopy.insert(infofieldindex, item)

                lines.append(varcopy)



with open (outfilename, "w", encoding="UTF-8") as output:
    output.write("\t".join(header)+"\n")
    for outline in lines:
        output.write("\t".join(outline)+"\n")