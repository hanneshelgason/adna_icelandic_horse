# Instructions for Claude — Read This First

Hello. This project is a **Marie Curie Postdoctoral Fellowship (MSCA-PF) application** being prepared by **Sigríður Sunna Ebenesersdóttir** (the person talking to you), with guidance from **Hannes Schroeder** (her collaborator, not always present).

Your job is to help write and refine the application text.

---

## The Project in One Paragraph

Sunna wants to use ancient DNA from archaeological horse remains to reconstruct the genomic history of the Icelandic horse — one of the most isolated domestic animal populations in the world. The proposed host is **Prof. Ludovic Orlando** at the Centre for Anthropobiology and Genomics of Toulouse (CAGT), University of Toulouse, France. Sunna and Orlando already co-author a paper under review on horse genetic diversity. The fellowship is for 24 months. Target deadline: September 2026.

---

## How to Get Up to Speed

Read these files in order — they give you everything you need:

1. `README.md` — folder structure and editing rules (2 min read)
2. `specs/PLAN.md` — master plan and current phase (2 min read)
3. `specs/project_concept.md` — the three scientific aims, narrative, and key selling points (5 min read)
4. `specs/scientific_background.md` — key facts, existing data, methods, and references (5 min read)
5. `specs/sunna_tasks.md` — what Sunna still needs to decide or provide

If you want deeper context on specific topics:
- **Sunna's track record**: `background/CV_Ebenesersdottir_2026.doc` (convert with `textutil -convert txt background/CV_Ebenesersdottir_2026.doc -output /tmp/CV.txt`, then read `/tmp/CV.txt`)
- **The project draft Sunna started**: `background/icelandic_horse.docx` (same conversion method)
- **The Orlando collaboration paper**: `background/Ahmed_et_al/Ahmed-20260128-Manuscript.docx`
- **An example MSCA application (best reference)**: `background/examples/MONNEREAU_MSCA_IF_THAIS_2022.pdf`

---

## Editing Rules — Important

| Folder / File | You may edit? |
|---|---|
| `drafts/` | **Yes, freely.** This is your working area. |
| `specs/` | **Only with Sunna's explicit permission.** These define the brief. |
| `pipeline/` | **Only with explicit permission.** |
| `background/` | **Never.** Read-only reference material. |
| `README.md`, `FOR_CLAUDE.md` | **Only with explicit permission.** |

When in doubt, draft in `drafts/` and ask before touching anything in `specs/`.

---

## Background Files Are Not in Git

If you don't see files in `background/`, they are not tracked in git (they are large binary files). Sunna can download them from the shared Google Drive folder and place them in `background/`. The specs, phases, pipeline, and drafts folders are all fully tracked.

---

## To Convert Binary Files (macOS)

`.doc` and `.docx` files cannot be read directly. Convert them first:
```bash
textutil -convert txt background/CV_Ebenesersdottir_2026.doc -output /tmp/CV.txt
```
Then read `/tmp/CV.txt`. You can do this for any `.doc` or `.docx` file.

---

## Current Status

We are in **Phase 1 — Preparation**. See `specs/phases/phase1_preparation/PLAN.md` for the open task list.

The section briefs in `specs/section_briefs/` still need to be filled in by Sunna before drafting can begin. Once they are filled in, you can start drafting the application sections into `drafts/`.

---

## What Sunna Will Ask You to Do

- Read background documents and extract key facts or arguments
- Draft sections of the MSCA application (Part B-1: Excellence, Impact, Implementation)
- Revise and improve draft text based on feedback
- Help Sunna think through the scientific framing and structure
- Fill in section briefs together before drafting begins

When drafting, always write for an **EU evaluator who is a scientist but not an ancient DNA specialist**. Aim for clear, confident, well-structured English. Use the THAIS (2022) example as the primary format reference (`background/examples/MONNEREAU_MSCA_IF_THAIS_2022.pdf`).
