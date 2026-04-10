# Write Your Own SKILL.md

## Step 1 — Choose your workflow

Answer these four questions in writing before you open your editor. A
five-minute answer produces a better skill than a fifteen-minute one,
because writing the answers forces you to commit to scope.

1. **What task do you do repeatedly?**
   (data cleaning, model fitting, literature review, figure generation,
    manuscript writing, code review, reviewing a submission…)

2. **What steps does your advisor or PI always remind you about?**
   → These become your *critical rules*.

3. **What mistakes have you made that you wish you'd been warned about?**
   → These become your *common gotchas*.

4. **What would a new lab member need to know to do this task correctly?**
   → Everything they would need to read is the content of your SKILL.md.

## Step 2 — Write the SKILL.md

Create the directory and file:

```bash
mkdir -p ~/.claude/skills/my-skill
nano ~/.claude/skills/my-skill/SKILL.md
```

Paste the template below and fill in every square-bracketed placeholder.

```markdown
---
name: my-skill
description: >
  [One-sentence description of what this skill does, plus the phrases a
   user would write when asking for this task. The description is how
   Claude decides whether to activate the skill — include the words your
   users actually use.]
---

# [Skill Name]

## Workflow

1. **[Think]** — [What question or setup comes first? State the problem
   in prose before touching code.]
2. **[Think]** — [What assumptions need to be stated? Confirm them with
   the user before proceeding.]  CONFIRM
3. **[Do]** — [First implementation step.]
4. **[Validate]** — [What check must pass before moving on? Be specific
   — name the diagnostic, the threshold, and what to do if it fails.]
5. **[Do]** — [Next implementation step, conditional on step 4 passing.]
6. **[Report]** — [How should the final result look? What format, what
   length, what does a correct report contain?]

## Critical rules

- [What must the agent ALWAYS do? State one iron law.]
- [What must the agent NEVER do? State one forbidden action.]

## Common gotchas

- [What specific thing goes wrong] → [How to detect and fix it]
```

### Alternative: let Claude draft it for you

If writing markdown feels slower than thinking out loud, ask Claude Code
to draft the skill from your answers to Step 1:

> Help me create a skill at `~/.claude/skills/my-skill/SKILL.md` for the
> following workflow: [paste your four answers from Step 1].

Then review, edit, and save. Delegating the drafting lets you focus on
the *content* of the skill rather than its formatting.

## Step 3 — Test it  

Restart Claude Code so it picks up the new skill. Then run your skill
against a realistic prompt:

```
/my-skill
```

Or just describe the task in natural language:

> Help me [do the task your skill encodes] for [a specific example from
> your research].

Watch whether Claude Code activates the skill. If it does not, your
description field is under-specified — add the phrasings a user would
actually write. If it activates but skips a step, your workflow step
wording is too vague — be more imperative ("Always check …" rather than
"Consider checking…").

## Design principles — what makes a good first skill

- **Small.** Three to eight workflow steps. One to three critical rules.
  One or two gotchas. Your first skill should not be 400 lines.
- **Opinionated.** Commit to specific defaults. "Use 94% HDI" is better
  than "use an appropriate credible interval." The default can be
  overridden by the user with full information.
- **Checkpointed.** At least one step should be marked CONFIRM, so
  the agent halts and asks the user before proceeding past a decision
  that depends on domain knowledge it doesn't have.
- **Gotcha-driven.** The gotchas section is where the hard-won
  knowledge lives. If you cannot think of any gotchas, the skill may be
  too generic to be useful yet — come back to it after the first week
  of real use.

## After the workshop

- Run the skill on a real task you actually have this week.
- When it fails, add a gotcha.
- When your advisor corrects the output, add a critical rule.
- Share the skill with your labmates by committing it to a shared repo.

