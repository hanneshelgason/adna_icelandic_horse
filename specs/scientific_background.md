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

Full submission in `background/Ahmed_et_al/`. Key relevance:
- Demonstrates Sunna and Orlando's active scientific collaboration
- Uses Orlando's horse imputation reference panel — the same panel Sunna would use in the MSCA project
- Provides methodological precedent and shows feasibility of imputation approach on diverse horse populations
- Tables S1–S7 contain detailed sample and population data

## Relevant Reference Papers (`background/papers/`)

- `science.pdf` — Ebenesersdóttir et al. 2018, Science: ancient Icelandic human genomes (Sunna's key prior publication)
- `aar2625-ebenesersdottir-sm.pdf` — Supplementary material for the Science paper
- `sexing_icelandicHorses_Palsdottir.pdf` — Pálsdóttir et al.: sexing ancient Icelandic horses; only prior aDNA work on this population
- `The_Horse_and_the_Norse_Reconstructing_t.pdf` — Horse and Norse reconstruction paper
- `1746-6148-7-21.pdf` — TBC (BMC Vet Research format)
- `1471-2156-7-46.pdf` — TBC (BMC Genetics format)
