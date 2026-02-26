# MSCA Postdoctoral Fellowship Application
## Ancient Horse Genomics of Iceland

This repository contains the working files for a Marie Curie Postdoctoral Fellowship (MSCA-PF) application.

**Applicant**: Sigríður Sunna Ebenesersdóttir
**Host institution**: Centre for Anthropobiology and Genomics of Toulouse (CAGT), University of Toulouse, France
**Host supervisor**: Prof. Ludovic Orlando
**Application type**: MSCA-PF European Postdoctoral Fellowship
**Target deadline**: September 2026 (MSCA-PF 2026 call)

---

## Folder Structure

### `specs/` — Project specifications *(Hannes + Sunna own)*
Contains the project concept, master plan, phase task lists, and section briefs that guide Claude's drafting work. These files define *what* should be written; Claude works *from* them but does not alter them without explicit permission.

- `PLAN.md` — Master plan and phase overview
- `project_concept.md` — Title, aims, methodology, key decisions
- `scientific_background.md` — Key facts and claims to draw on when drafting
- `section_briefs/` — Per-section instructions and requirements for Claude
- `phases/` — Phase-specific task lists

### `background/` — Reference material *(read-only, not in git)*
Original source documents: CVs, manuscripts, datasets, example MSCA applications, scientific papers. No one edits these — they are the source of truth for facts and context.

- `CV_Ebenesersdottir_2026.doc` — Sunna's CV
- `Iceland2_manuscript.docx` — Draft manuscript on 201 ancient Icelandic human genomes
- `icelandic_horse.docx` — Early draft project description (source for `specs/project_concept.md`)
- `Ludovic_Orlando.docx` — Profile of host supervisor
- `mergeInfofreeze_horsesIceland.xlsx` — Genomic data on Icelandic horse libraries
- `horse_samples_decode.docx` — Lab notes on remaining bone powder and sequencing libraries
- `Horses.docx` — Full sample list from the National Museum of Iceland
- `summary_sites_120625.docx` — Summary of archaeological sampling sites
- `Ahmed_et_al/` — Full submission package of the Sunna+Orlando co-authored paper (under review)
- `examples/` — Three MSCA example applications (all by Hannes Schroeder) + Sunna's old PhD grant
- `papers/` — Scientific reference papers

### `pipeline/` — Bioinformatics scripts *(Claude edits with permission)*
Shell scripts for the aDNA processing and analysis pipeline.

- `aDNAfastqMAPpe.sh` — deCODE aDNA pipeline: adapter trimming, BWA mapping, deduplication, mapDamage rescaling, sex estimation, contamination checks

### `drafts/` — Application text drafts *(Claude edits freely)*
Work-in-progress drafts of the Part B-1 and Part B-2 application sections. Claude iterates here; Hannes and Sunna review and approve.

---

## Editing Rules

| Location | Owner | Claude may edit? |
|---|---|---|
| `README.md` | Hannes + Sunna | Only with explicit permission |
| `specs/` | Hannes + Sunna | Only with explicit permission |
| `background/` | Nobody — read-only | Never |
| `pipeline/` | Hannes + Sunna | Only with explicit permission |
| `drafts/` | Claude | Freely |

---

## GitHub Collaboration

This repository is tracked in git. **`background/` and `from_google_drive/` are not tracked** (see `.gitignore`) because they contain large binary files. If you are setting up a fresh session (e.g., Sunna pulling the repo on a different machine):

1. Clone the repository: `git clone <repo-url>`
2. Obtain background files from the shared Google Drive folder and place them in `background/`
3. The `specs/`, `pipeline/`, and `drafts/` folders are fully tracked and will be current after pulling

---

## Diagrams

Where applicable, diagrams in Markdown files use [Mermaid](https://mermaid.js.org/) syntax, which renders natively on GitHub and in most modern Markdown editors. This includes Gantt charts in `drafts/section3_implementation.md` and any flowcharts or pipeline diagrams added during the project.

Example block:
````
```mermaid
gantt
    title Example
    dateFormat YYYY-MM
    ...
```
````

---

## Current Status

See `specs/PLAN.md` for the current phase and active task list.
