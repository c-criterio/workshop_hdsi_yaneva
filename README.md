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


## Licensing

- `baygent-skills/` is MIT licensed; see `baygent-skills/LICENSE`.
- Workshop slides, companion, and exercise materials: author's
  discretion. The companion and exercise files are distributed under
  CC BY-NC 4.0 matching the broader Generative AI for Scholarship
  series unless otherwise noted.
