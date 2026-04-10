# Workshop Materials
## Quick start

The installer defaults to **project-local install**: skills go into
`.claude/skills/` inside the directory you run it from. That means the
skills only activate when Claude Code is launched from that project,
and they travel with the project if you commit the `.claude/` folder.

```bash
# 1. cd to the research project you want the skills active in
cd ~/your/research/project

# 2. Run the installer (it finds its own baygent-skills source)
bash /your/research/project/install_skills.sh

# 3. Restart any open Claude Code sessions in this project

# 4. Verify the install
ls .claude/skills/
# Expected: bayesian-workflow  causal-inference

# 5. Test activation with one query
# Paste query #1 from workshop_session4/exercises/track_b1_trigger_queries.md
# into Claude Code and confirm the bayesian-workflow skill activates.
```

## Directory layout

```
workshop_session4/
├── README.md                   This file — master index and quick start
├── slides.pptx                 The workshop slide deck (34 slides)
├── install_skills.sh           Idempotent installer that copies the two
│                               skills into ./.claude/skills/ in the
│                               current working directory (project-local).
│                               Pass --global for ~/.claude/skills/.
├── exercises/                  Hands-on exercise materials (Slide 28 block)
│   ├── README.md               Exercise overview; which track to pick
│   ├── track_a_template.md     Track A: write your own SKILL.md
│   ├── track_b1_trigger_queries.md   Track B1: activation test (21 queries)
│   ├── track_b2_scenarios.md   Track B2: run published benchmarks (7 scenarios)
└── baygent-skills/             Shallow clone of Andorra's repository
                                (MIT license) — the source of the skills
                                and the evaluation material used in Track B
```

## What each artefact is

### `companion.txt`

The slide-by-slide reference document for Session 4. It reproduces every
slide verbatim and adds detailed commentary under each one in an
arxiv-style academic voice. The structure:

- Abstract and seven parts mirroring the slide deck arc
- Part I: opening and motivation (Slides 1–4)
- Part II: agents from first principles (Slides 5–12)
- Part III: skills — definition and rationale (Slides 13–17)
- Part IV: case studies — Bayesian, causal, TDD, math olympiad, ecosystem
  (Slides 18–23), including a full practical-example walkthrough of
  the baygent-skills bayesian-workflow directory
- Part V: authoring skills (Slides 24–27)
- Part VI: hands-on exercise (Slides 28–31)
- Part VII: synthesis and resources (Slides 32–34)
- Appendix A: primary-source reading list (15 entries)
- Appendix B: glossary
- Appendix C: session checklist
- Appendix D: provenance table for every reported evaluation number
- Appendix E: explicit limitations of the companion itself

Specific claims in the companion have been reconciled against Alex
Andorra's two learnbayesstats essays (2026-03-16 and 2026-03-23) and
the baygent-skills repository at v1.2. Where the companion cites a
specific empirical number, Appendix D names the primary source and
the sample size (N = 6 scenarios). Where the companion interprets
beyond what the primary sources say, Appendix E flags the
interpretation as such.

### `slides.pptx`

The 34-slide deck, title: "Coding and Doing Math Faster with LLMs and
Agentic Workflows". The original slide file preserved verbatim. If you
are editing slides day-of, edit this file and the companion's
slide-verbatim blocks do not need to be updated — they are already
aligned.

### `baygent-skills/`

A shallow clone (depth 1) of
`github.com/Learning-Bayesian-Statistics/baygent-skills`, the
reference implementation of the Bayesian workflow skill and the
causal-inference skill. MIT licensed. Author: Alex Andorra. The
repository contains:

- `bayesian-workflow/SKILL.md` — the main skill (v1.2)
- `bayesian-workflow/references/` — seven topical deep-dive markdown
  files loaded on demand (priors, diagnostics, hierarchical, model
  comparison, model criticism, sensitivity, reporting)
- `bayesian-workflow/scripts/` — two Python diagnostic utilities
  the skill invokes during a run
- `causal-inference/` — the companion causal-inference skill
  (thinking-first DAG → identification → estimation → refutation
  workflow)
- `amortized-workflow/` — a third skill covering amortized Bayesian
  inference with BayesFlow
- `evals/` — the complete evaluation harness used to benchmark each
  skill, including `trigger_eval_set.json` (21 activation queries for
  the Bayesian skill) and `iteration-1/` through `iteration-3/`
  scenario directories with prompts, assertion rubrics, and
  real `with_skill` and `without_skill` Python outputs

### `install_skills.sh`

A small bash script that copies `bayesian-workflow/` and
`causal-inference/` from the clone into `.claude/skills/` inside the
current working directory — i.e., it makes the skills project-local
to whatever directory you run the script from. The script is
idempotent: running it twice will overwrite any earlier copy with
the versions from the clone, so you can use it to reset to a clean
state if you or a participant has edited the skills during testing.

Pass `--global` to install into `~/.claude/skills/` instead, which
makes the skills active in every Claude Code session on the machine
regardless of current directory. Global is what you want on your own
laptop for daily use; project-local is what you want for reproducible
research projects where the skills should travel with the code.

### `exercises/`

Hands-on materials for the 25-minute block on Slide 28. Two tracks,
three sub-exercises in Track B. See `exercises/README.md` for the
full guide.

## Source provenance

Every piece of material in this directory traces to a primary source:

| Artefact | Source |
|---|---|
| Slides | Author's own drafting (preserved from `/Users/cy/dev/hdsi/workshop_april10.pptx`) |
| Companion | Author's own drafting, reconciled against primary sources listed in companion Appendix A |
| bayesian-workflow skill | Andorra, `github.com/Learning-Bayesian-Statistics/baygent-skills` v1.2, MIT license |
| causal-inference skill | Andorra, same repository, MIT license |
| Track B1 activation queries | `baygent-skills/evals/bayesian-workflow/trigger_eval_set.json`, verbatim |
| Track B2 scenario prompts | `baygent-skills/evals/bayesian-workflow/iteration-1/*/eval_metadata.json`, verbatim |
| Track B2 scenario assertions | Same files, verbatim |
| 100% / 90.5% evaluation numbers | Andorra (2026-03-16), *Bayesian Workflow Agent Skill: PyMC + ArviZ*, learnbayesstats.com. Independently re-verified by aggregating `baygent-skills/evals/bayesian-workflow/iteration-1/benchmark.json`: 53/53 with skill, 48/53 without (90.6%, slide rounds to 90.5%). |
| +29% time / +87% token costs | Same source. Re-verified from the same `benchmark.json`: with-skill total 1158 s / 206,143 tokens, without-skill total 897 s / 110,137 tokens. Time ratio +29.1%, token ratio +87.2%, both rounded as on the slide. |
| Soccer Factor Model stress test | Andorra (2026-03-23), *Bayesian Workflow Skill: Real-World Stress Test (v1.1)*, learnbayesstats.com |
| Radical-minimalism counterargument | Zechner, via `small_ideas_advanced.pptx` (Imagination in Action, MIT/Harvard, 2026-04-09) |
| Session 3 prior-session bridge | Stubbs, `astrostubbs.github.io/GenAI-for-Scholarship/session3-power-user.html` |
| Session 2 prior-session bridge | Audirac, `audiracmichelle.github.io/huggingface_workshop/` |
| Simon Willison "LLM in a loop with tools" framing | Willison (2025), `simonwillison.net/2025/Sep/18/agents/` |

## Licensing

- `baygent-skills/` is MIT licensed; see `baygent-skills/LICENSE`.
- Workshop slides, companion, and exercise materials: author's
  discretion. The companion and exercise files are distributed under
  CC BY-NC 4.0 matching the broader Generative AI for Scholarship
  series unless otherwise noted.

## Maintenance

If Andorra updates baygent-skills before the workshop, refresh the
clone:

```bash
cd baygent-skills && git pull && cd ..
bash install_skills.sh
```

And re-read the companion Slide 19 commentary to see whether any new
bug fixes or critical rules have landed since the Soccer Factor Model
stress test. The companion's Appendix E explicitly notes that the
skills ecosystem is a snapshot in time; update the companion's version
number notes if a v1.3 or later ships.

## Contact and questions

Post-session issues should go to the Harvard HDSI workshop feedback
form (link on the closing slide). Issues with the baygent-skills
repository itself should go to the GitHub issue tracker at
`github.com/Learning-Bayesian-Statistics/baygent-skills/issues`.
