# Hands-On Guide

## Before you start

1. You need a working Claude Code CLI from Session 3. If `claude --version`
   does not print a version number, install Claude Code first and come back.

2. `cd` to a scratch project directory where you want the skills active,
   then install them into `.claude/skills/` in that directory:

   ```bash
   cd ~/scratch/workshop-playground      # or any project of yours
   bash ~/scratch/workshop-playground/install_skills.sh
   ```

   Then restart any open Claude Code sessions in that directory. The
   skills are project-local. They only activate when Claude Code is
   launched from this directory.

3. Verify the skills are in place:

   ```bash
   ls .claude/skills/
   # You should see: bayesian-workflow  causal-inference
   ```


## Track A — Write your own SKILL.md from scratch

Recommended if you already know which workflow from your research you want
to encode. Deliverable: a new directory in `.claude/skills/` (or
`~/.claude/skills/` for global) containing a SKILL.md file.

See `track_a_template.md` for the template and timing.

## Track B — Run Andorra's published benchmark

Recommended if you want to see the skill in action before writing your own.
Track B has three sub-exercises; do as many as time allows.

- **B1** — Activation test. Paste queries from
  `track_b1_trigger_queries.md` into Claude Code and verify which ones
  trigger the skill. Measures whether the SKILL.md description field
  correctly discriminates Bayesian from adjacent-but-unrelated questions.

- **B2** — Run one real benchmark scenario. Pick one of the
  seven scenarios in `track_b2_scenarios.md` (logistic-regression-churn is
  the most approachable), paste the prompt into Claude Code with the skill
  active, and grade the agent's output against the 8–14 rubric assertions.

- **B3** — Write your own scenario in the same
format: a prompt from your research, 8–12 assertions, run it against the
  installed skill, and open a GitHub issue on baygent-skills with your
  findings if the skill fails.

See `track_b1_trigger_queries.md` and `track_b2_scenarios.md` for the
materials.


## Source of the exercise material

All of Track B is built directly from Alex Andorra's published evaluation
suite for the baygent-skills bayesian-workflow skill:

- Trigger queries: `baygent-skills/evals/bayesian-workflow/trigger_eval_set.json`
- Scenario prompts and assertions: `baygent-skills/evals/bayesian-workflow/iteration-1/*/eval_metadata.json`
- Actual with_skill / without_skill outputs: `baygent-skills/evals/bayesian-workflow/iteration-1/*/with_skill/` and `.../without_skill/`
- Aggregate benchmark JSON: `baygent-skills/evals/bayesian-workflow/iteration-1/benchmark.json`
- License: MIT. See `baygent-skills/LICENSE`.
