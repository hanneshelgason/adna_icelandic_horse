# Scientific Background

*This file is owned by Hannes + Sunna. Claude draws on this when drafting but should not edit it without explicit permission.*

---

## The Icelandic Horse

- Descended from horses brought by Norse settlers to Iceland in the late 9th century CE
- One of the world's oldest livestock import bans (~10th century, strengthened legally over time) has kept the population isolated for ~1,000 years
- All modern Icelandic horses derive from this founding stock with no outside admixture
- Known for unique gaits: tölt and pace (controlled by DMRT3 mutations)
- Generally robust but shows signs of inbreeding-related health vulnerabilities (sweet itch, EMS-like metabolic profiles, uveitis susceptibility)
- Population size: ~80,000–100,000 registered horses in Iceland; ~100,000 more abroad
- Key prior genetic work: Pálsdóttir et al. (see `background/papers/sexing_icelandicHorses_Palsdottir.pdf`) — first genetic insights but insufficient depth for population genomics

## The Applicant's Track Record (Sunna)

- PhD: Biological Anthropology, University of Iceland (2023)
- Research Scientist at deCODE Genetics (2013–2026), specialising in population structure and ancient DNA
- Key publication: Ebenesersdóttir et al. (2018), Science 360:1028–1032 — 88 ancient Icelandic genomes, methods directly transferable to horse project (see `background/papers/science.pdf`)
- Iceland2 manuscript (under preparation): 201 ancient Icelandic human genomes (870–2000 CE); Norse:Gaelic ancestry shift from 57:43 → 70:30 by ~1300 CE; IBD-based genealogical analysis
- Co-author on Ahmed et al. (under review) — horse genetic diversity paper with Orlando (see `background/Ahmed_et_al/`)

## The Host (Ludovic Orlando)

- CNRS Silver Medal laureate
- Founding director of the Centre for Anthropobiology and Genomics of Toulouse (CAGT), University of Toulouse, France
- World leader in ancient horse genomics: published key horse domestication papers in Nature, Science, Cell
- Developed a reference panel of >900 modern + ancient horse genomes for imputation-based analyses
- Co-author on Ahmed et al. (under review) with Sunna and Helgason

## Existing Icelandic Horse Data

**Sequencing libraries (from `background/horse_samples_decode.docx`):**
Seven samples with >10% endogenous DNA and remaining bone powder:

| Sample ID | Site | % Endogenous | Bone powder (g) |
|---|---|---|---|
| VHR031 | Granastaðir | 33.9 | 0.46 |
| VHR085 | Ytra-Garðshorn | 11.6 | 0.86 |
| VHR089 | Brimnes (Dalvík) | 39.8 | 1.15 |
| VHR093 | Sturluflötur | 10.4 | 0.78 |
| VHR100 | Böggvistaðir | 14.2 | 0.85 |
| VHR102 | Berufjörður | 31.7 | 0.63 |
| VHR105 | Leynir Cave | 29.5 | 0.55 (chunk) |

VHR105 has 3 existing libraries (VHR105E1bL2, VHR105E1bL3, VHR105E1bL4). Additional libraries may exist for other samples (check `background/mergeInfofreeze_horsesIceland.xlsx`).

**National Museum sample list (`background/Horses.docx`):**
~25 previously sampled/sequenced specimens with museum accession numbers; ~50+ additional candidates (burial contexts, cave deposits, medieval and modern). Dates range from settlement period (AD 800–1000) to 20th century. Compiled 2.6.2021.

## Key Methods

- **aDNA extraction**: Silica-based methods optimised for degraded material; clean-lab protocols (deCODE Anthropology group)
- **Library preparation**: Illumina indexed libraries; adapter sequences per `pipeline/aDNAfastqMAPpe.sh`
- **Mapping pipeline**: AdapterRemoval2 → BWA aln → Picard MarkDuplicates → mapDamage rescaling; runs on SLURM cluster
- **Genotype imputation**: GLIMPSE2 framework (used for humans in Iceland2; same approach applicable to horses with Orlando's reference panel)
- **Population genomics**: PCA, ADMIXTURE, IBD (hap-IBD), F-statistics, TreeMix
- **Sex estimation**: ry method (X:Y chromosome read ratio)
- **Contamination**: ANGSD X-chromosome contamination

## Ahmed et al. (Under Review)

Full submission in `background/Ahmed_et_al/`. Authors: Ahmed, Renaud, Moore, **Ebenesersdóttir S.S.**, …Stefánsson, **Helgason A.**$, **Orlando L.**$ (*$ = co-corresponding*). Note: Gabriel Renaud (co-author) was himself a Marie Curie Individual Fellow — a useful precedent to mention.

**Key findings relevant to the MSCA proposal:**
- Dataset: 901 modern horse genomes + 376 ancient specimens; 25.9 million phased genotypes
- Identifies **7 genetic ancestries** shaping modern horse breeds worldwide
- **NORD ancestry** (the primary component of Icelandic horses, Scandinavian breeds) emerged at **~810 CE, coincident with the Viking era** — directly sets up the historical context of the Icelandic horse founding
- Modern European horse bloodlines only diverged in the last **700–1,350 years** — most breed differentiation is very recent
- Outside Asia, horse mobility declined after ~550 CE (fall of Rome), then increased in the Early Middle Ages — relevant to Norse-era horse transport
- Inbreeding only became widespread in the **20th century** — ancient horses had low F; isolation in Iceland would be an exceptional counter-example
- **Imputation approach**: GLIMPSE2 + BEAGLE phasing; validated at ≥0.75× coverage for ancient specimens (R² >0.956); this is exactly the method the MSCA project will apply to Icelandic horse specimens
- Reference panel of 901 modern genomes available for imputing new ancient genomes — directly usable in the MSCA project

**Key framing hook for the application**: The NORD ancestry cluster — which defines the Icelandic horse — emerged at the precise moment of Norse expansion (~810 CE). Our project will be the first to trace, from inside Iceland, how that founding stock arrived, diversified, and evolved over 1,100 years of isolation. Ahmed et al. provides the global backdrop; this project provides the Icelandic close-up.

## Relevant Reference Papers (`background/papers/`)

- `science.pdf` — Ebenesersdóttir et al. 2018, Science: ancient Icelandic human genomes (Sunna's key prior publication)
- `aar2625-ebenesersdottir-sm.pdf` — Supplementary material for the Science paper
- `sexing_icelandicHorses_Palsdottir.pdf` — Pálsdóttir et al.: sexing ancient Icelandic horses; only prior aDNA work on this population
- `The_Horse_and_the_Norse_Reconstructing_t.pdf` — Horse and Norse reconstruction paper
- `1746-6148-7-21.pdf` — TBC (BMC Vet Research format)
- `1471-2156-7-46.pdf` — TBC (BMC Genetics format)
