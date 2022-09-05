library(clusterProfiler)
library(enrichplot)
library(org.Hs.eg.db)
library(ggplot2)
pacman::p_load(GO.db)
pacman::p_load(EnrichmentBrowser)
pacman::p_load(ggupset)

# Script para ir sacando los ORA

# aquí voy a poner lo único que me apetecería modificar sinceramente
setwd("~/ibv/resultados_estudios_asociacion")

### Common vars ###
file = "Merged_results_rare_variants.tsv"

GODIR = "/home/ruben/ibv/analisis/Enrichment/ORAGO/"
KEGGDIR = "/home/ruben/ibv/analisis/Enrichment/ORAKEGG/"
#####
# Lectura
table = read.table (file, sep = "\t", header = T)
pval = 0.05
# table = table[table$P < 0.05,]
all_genes = table$GENE
## este lo cambiaremos para ir sacando los diferntes
table = table[(table$AD.control > pval & table$AD.MCI < pval & table$MCI.control > pval),]
genes = table$GENE

## ORA GO
group_go <- groupGO(gene = genes,
                    OrgDb = org.Hs.eg.db,
                    ont = "BP",
                    keyType = "SYMBOL",
                    readable = F)


ora <- enrichGO(gene        = genes,
                OrgDb         = org.Hs.eg.db,
                keyType       = 'SYMBOL',
                ont           = "BP",
                pAdjustMethod = "none",
                universe = all_genes,
                qvalueCutoff = 1,
                pvalueCutoff = 0.05,
                minGSSize = 2, # se considera demasiado específico
                maxGSSize = 500, # se considera demasiado general para un proceso biológico
)
dim(ora)
dotplot(ora, showCategory = 20, x = "GeneRatio")
ggsave(paste0("aaaa-GO", ".png"))

upsetplot(ora, n = 15)

## ORA KEGG
genesEntrez = mapIds(org.Hs.eg.db,
                     keys=genes,
                     column="ENTREZID",
                     keytype="SYMBOL",
                     multiVals="first")
all_genesEntrez = mapIds(org.Hs.eg.db,
                         keys=all_genes,
                         column="ENTREZID",
                         keytype="SYMBOL",
                         multiVals="first")

orakegg <- enrichKEGG(genesEntrez,
                      organism = "hsa",
                      keyType = "ncbi-geneid",
                      pAdjustMethod = "none",
                      qvalueCutoff = 1,
                      pvalueCutoff = 1,
                      universe = all_genesEntrez,
                      minGSSize = 1,
                      maxGSSize = 500)
dim(orakegg)
dotplot(orakegg, showCategory = 20, x = "GeneRatio")
upsetplot(orakegg, n = 15)

ggsave(ggsave(paste0(KEGGDIR, result, "-KEGG", ".png")))



