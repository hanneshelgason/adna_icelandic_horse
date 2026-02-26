# Part B-1 — Section 1: Excellence

*First draft — preliminary. To be revised after reading Ahmed et al. manuscript and MSCA example applications.*
*Target length: ~4 pages in final formatted document.*

---

## 1.1 Objectives and Research Questions

The Icelandic horse is one of the most genetically isolated domestic animal populations in the world. Since Norse settlers brought the first horses to Iceland in the late 9th century CE, the population has remained closed to outside breeding for over a millennium, preserved by one of the oldest livestock import bans in recorded history. Despite this uniquely continuous and well-documented lineage, the ancient genomic history of the Icelandic horse has never been investigated at the resolution required for modern population genomic analysis. No genome-wide study has yet reconstructed how this founding population was established, how it diversified over time, or how sustained geographic isolation shaped its genetic architecture.

This project will generate the first comprehensive ancient genomic dataset for the Icelandic horse, spanning the settlement period (ca. 870 CE) to the late 19th century, and use it to address three interrelated scientific questions:

**Objective 1 — Origins and founding**: What was the genomic composition of the horses that arrived with Norse settlers? Were they introduced in a single founding event or through multiple waves? What Scandinavian and Eurasian populations contributed to the founding stock, and in what proportions?

**Objective 2 — Post-founding demography**: How did the Icelandic horse population change over 1,100 years of isolation? What is the trajectory of inbreeding, genetic diversity, and effective population size through time, and how does this compare to other isolated breeds?

**Objective 3 — Adaptation and trait evolution**: What genomic signatures of local adaptation and selective breeding are detectable in ancient and historical Icelandic horses? How do the genetic variants associated with the breed's most distinctive traits — the tölt gait (DMRT3), metabolic adaptation to low-calorie winters, and disease susceptibility — evolve through time under isolation?

Together, these objectives will produce the first genome-wide reconstruction of the Icelandic horse's evolutionary history, linking Norse-age animal husbandry with a thousand years of island adaptation, and providing a model system for understanding the genomic consequences of extreme geographic isolation in domestic species.

---

## 1.2 Relation to the MSCA Work Programme

This project directly addresses the MSCA-PF programme's core objectives of fostering scientific excellence, supporting researchers at a critical career stage, and enabling knowledge transfer between institutions and disciplines. Dr Ebenesersdóttir brings world-class expertise in ancient DNA methodology and Icelandic population genomics from deCODE Genetics in Iceland; the host laboratory of Prof. Ludovic Orlando at the Centre for Anthropobiology and Genomics of Toulouse (CAGT) provides world-leading expertise in ancient horse genomics and the comparative reference datasets required for this project. The fellowship will create genuine bidirectional knowledge transfer: Dr Ebenesersdóttir will acquire new skills in horse-specific genomic analysis, imputation-based reconstruction, and trait genetics, while contributing her unique methodological expertise and Icelandic sample access to a field where these have been entirely absent.

The project also supports the ERA priority of open science: all genomic data will be deposited in public repositories upon publication, and the analytical pipelines will be made openly available.

---

## 1.3 Methodology

### 1.3.1 Sample collection and ancient DNA extraction

Building on a previously granted sampling permission from the National Museum of Iceland (Þjóðminjasafnið), we will sample up to **90 archaeological horse specimens** spanning the Icelandic settlement period (ca. 870 CE) to ca. 1900 CE, providing a temporal transect of the population across 1,100 years. Specimens include dental remains and cortical bone from well-dated burial contexts (kuml), animal bone deposits (dys), and assemblages from sites across Iceland. We will prioritise teeth (the optimal substrate for ancient DNA preservation) from settlement-period and medieval contexts, supplemented by post-medieval specimens to document later demographic changes.

All aDNA work will be carried out at the dedicated ancient DNA clean-room laboratory at deCODE Genetics, Reykjavík, established and maintained by the applicant. This facility is physically isolated from areas where modern DNA is handled and adheres to strict international contamination-control standards. DNA will be extracted using silica-based protocols optimised for highly degraded Icelandic skeletal material — the same protocols used to generate 201 ancient Icelandic human genomes (Ebenesersdóttir et al., *Science* 2018; manuscript in preparation). In our experience with Icelandic skeletal material, this approach reliably recovers endogenous DNA from specimens over 1,000 years old.

### 1.3.2 Library preparation and sequencing

Double-stranded Illumina sequencing libraries will be prepared with unique dual indexing for multiplexed sequencing. Libraries will undergo initial quality assessment by shallow shotgun sequencing (MiSeq, deCODE Genetics) to determine endogenous DNA content, characteristic ancient DNA damage patterns (cytosine deamination), and library complexity. Samples yielding >1% endogenous horse DNA will proceed to deep sequencing on the Illumina NovaSeq platform. We target an average raw sequencing depth of 2–5× per individual prior to imputation, consistent with current best practice in ancient horse genomics.

### 1.3.3 Bioinformatic processing and genotype imputation

Raw reads will be processed using the deCODE Anthropology group's validated aDNA pipeline (adapter trimming with AdapterRemoval2; mapping to the horse reference genome EquCab3 with BWA; duplicate removal with Picard MarkDuplicates; base quality rescaling with mapDamage2). Sex will be estimated from X:Y chromosome read ratios; contamination will be assessed using mtDNA and nuclear methods.

Low-coverage genomes will be imputed to high density using GLIMPSE2, leveraging the imputation reference panel of >900 modern and ancient horse genomes developed by Prof. Orlando's laboratory (Cell, Nature). This panel has been validated for imputing ancient horse genomes at low coverage, making it directly applicable to our Icelandic dataset. Imputation substantially increases the number of analysable variants per individual and enables robust population genomic inference from low-coverage ancient data.

### 1.3.4 Population genomic analyses

*Objectives 1 and 2* will be addressed using a suite of established population genomic methods:

- **Principal components analysis (PCA)** and **ADMIXTURE** to characterise the ancestry composition of ancient Icelandic horses relative to modern and ancient horses from Scandinavia, the British Isles, continental Europe, and the Eurasian steppe
- **f-statistics and admixture graph modelling** (ADMIXTOOLS2) to formally test ancestry models and quantify the contributions of source populations to the founding stock
- **Identity-by-descent (IBD) analysis** (hap-IBD) to reconstruct genealogical relationships between individuals and track the accumulation of inbreeding through time
- **Runs of homozygosity (ROH)** analysis to quantify inbreeding at the individual and population level across the temporal transect
- **Demographic modelling** (PSMC, SMC++) to reconstruct changes in effective population size

*Objective 3* will be addressed using:

- **Genome-wide selection scans** (XP-EHH, iHS, PBS) comparing ancient Icelandic horses to Eurasian outgroups to identify regions under selection specific to the Icelandic lineage
- **Targeted genotyping** of known functional variants, including DMRT3 (gait), ASIP and MC1R (coat colour), and variants associated with metabolic traits and immune function
- **ROH-based identification** of potentially deleterious recessive variants that may have risen in frequency under isolation

---

## 1.4 Originality and Innovative Aspects

This project is innovative in three distinct respects.

**First**, it fills a critical geographic and temporal gap in the genomic history of domestic horses. Despite major recent advances in ancient horse genomics — including the sequencing of horses from Central Asia, the Pontic steppe, Scandinavia, and the Iberian Peninsula — no genomic data exist for the Icelandic horse prior to the modern era. Iceland represents a unique endpoint in the story of Norse horse husbandry, and the temporal depth of our dataset (1,100 years) is unmatched for any island horse population.

**Second**, the Icelandic horse is a globally exceptional model system. It is one of the only domestic animals in the world with a clean, uninterrupted, and legally enforced population history from the medieval period to the present, free from admixture with outside populations. This makes it uniquely suited to quantifying the genomic consequences of isolation, founder effects, and drift — questions that are central to conservation biology, island biogeography, and the evolutionary biology of domestic species, but which can rarely be addressed with such clarity.

**Third**, the project combines two complementary methodological strengths that have not previously been brought to bear on the Icelandic horse: (i) the aDNA extraction and sequencing protocols of the deCODE Anthropology group, which have been specifically optimised for degraded Icelandic skeletal material, and (ii) the ancient horse imputation reference panel and analytical framework of the Orlando laboratory, which enables high-resolution population genomic inference from low-coverage ancient genomes. Neither resource alone would be sufficient; together, they make the project feasible and scientifically powerful.

---

## 1.5 Open Science

All sequencing data generated in this project will be deposited in the European Nucleotide Archive (ENA) under open access conditions upon publication, in accordance with FAIR data principles. Genotype data and population genomic results will additionally be made available through appropriate repositories (e.g., the European Variation Archive). All bioinformatic pipelines will be documented and made publicly available via GitHub under open-source licences. We will publish results in open-access journals where possible and will make preprints available on bioRxiv prior to formal publication.
