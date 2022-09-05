library(ggplot2)
library(ggpubr)
pacman::p_load(PCAtools)

wd <- "/home/ruben/ibv/resultados_estudios_asociacion/rePRS/ordinalreglog"
setwd(wd)
prs <- read.table("./prueba-validacion/validation-scoring.profile", header = T)

prs$PHENO <- as.factor(prs$PHENO)
levels(prs$PHENO) <- c("Control", "MCI", "AD")

prs2 <- prs[,c(3,6)]

# prs <- subset(prs, prs$PHENO != "Control")
ggplot(data = prs, aes(x= PHENO, y = SCORE, fill = PHENO)) + 
  geom_boxplot() +
  geom_point()



### wilcox
df<-prs2
compare_means(SCORE ~ PHENO, df, method = "t.test")


my_comparisons <- list( c("Control", "MCI"), c("MCI", "AD"), c("Control", "AD"))
ggboxplot(df, x = "PHENO", y = "SCORE",
          color = "PHENO")+ 
  geom_jitter(width = 0.1) +
  stat_compare_means(method = "t.test", comparisons = my_comparisons)+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 0.11) +    # Add global p-val
  labs(x = "Phenotype", y = "Disease Risk", colour = "Phenotype")


### Figura en Español


prs$PHENO <- as.factor(prs$PHENO)
levels(prs$PHENO) <- c("Control", "DCL", "EA")

prs2 <- prs[,c(3,6)]

# prs <- subset(prs, prs$PHENO != "Control")
ggplot(data = prs, aes(x= PHENO, y = SCORE, fill = PHENO)) + 
  geom_boxplot() +
  geom_point()



### wilcox
df<-prs2
compare_means(SCORE ~ PHENO, df, method = "wilcox.test")


my_comparisons <- list( c("Control", "DCL"), c("DCL", "EA"), c("Control", "EA"))
box <- ggboxplot(df, x = "PHENO", y = "SCORE",
          color = "PHENO")+ 
  geom_jitter(width = 0.1) +
  stat_compare_means(method = "t.test", comparisons = my_comparisons)+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 0.11) +    # Add global p-val
  labs(x = "Fenotipo", y = "Riesgo de Patología", colour = "Fenotipo")

ggsave("boxplot-esp.png", box, dpi = 300, height = 7, width = 9)
