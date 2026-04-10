# Track B2 — Benchmark Scenarios

These seven scenarios are from Alex Andorra's published evaluation suite
at `baygent-skills/evals/bayesian-workflow/iteration-1/`. Each scenario
has a prompt and a list of assertions the agent's output must satisfy.
Andorra has published the actual with-skill and without-skill outputs
for each scenario (look in `with_skill/outputs/` and
`without_skill/outputs/` inside each scenario directory) so you can
compare your agent's response against a published run.

## How to run a scenario

1. Pick one scenario below. `logistic-regression-churn` is the most
   approachable if this is your first time.
2. Open Claude Code in a scratch directory.
3. Paste the scenario's **Prompt** as your first message.
4. Watch the agent work. If the skill is installed, it should follow
   the ten-step workflow (generative story → priors → prior
   predictive checks → inference → diagnostics → criticism →
   sensitivity → comparison → reporting).
5. When the agent finishes, grade its output against the
   **Assertions** list. Mark each assertion pass or fail.
6. Compare your pass-count against the published benchmark: open
   `baygent-skills/evals/bayesian-workflow/iteration-1/<scenario>/with_skill/grading.json`
   to see the expected passes.
7. (Optional) Remove the skill temporarily and rerun the same prompt
   to see the without-skill behavior:
   ```bash
   mv ~/.claude/skills/bayesian-workflow /tmp/bayesian-workflow-parked
   # ...rerun the prompt in a new Claude Code session...
   mv /tmp/bayesian-workflow-parked ~/.claude/skills/bayesian-workflow
   ```

---

## Scenario 1 — logistic-regression-churn


### Prompt

> I have customer churn data with 5000 rows — binary outcome
> (churned/not), plus age, tenure_months, monthly_spend, and
> support_tickets_last_90d. Build me a Bayesian logistic regression to
> predict churn probability with uncertainty estimates.

### Assertions (10 checks)

1. Uses Bernoulli likelihood (`pm.Bernoulli`) with logit inverse-link function
2. Standardizes or scales predictors before fitting the model
3. Sets weakly informative priors on regression coefficients (Normal with sigma between 1 and 5)
4. Calls `pm.sample_prior_predictive()` before inference
5. Calls `pm.sample()` for MCMC inference
6. Calls `pm.sample_posterior_predictive()` after inference
7. Uses `az.summary()` or `az.plot_trace()` for convergence diagnostics
8. Reports 94% HDI (not 95% CI) for parameter estimates
9. Uses coords and dims in the PyMC model definition
10. Documents prior choices with justification comments in the code

### Published benchmark result

- With skill: 10/10 passing (220.9 s, 32,144 tokens)
- Without skill: 9/10 passing (216.2 s, 22,199 tokens). The single
  missed check in Andorra's published run was assertion #9, "Uses
  coords and dims in the PyMC model definition" — the unscaffolded
  agent built a working logistic regression but did not use PyMC's
  named coordinate system, which the skill enforces.

---

## Scenario 2 — hierarchical-schools

**Eval ID:** 2. **Difficulty:** moderate.

### Prompt

> I've got test scores for 200 students across 15 schools. I want to
> understand how much of the variation is between schools vs within
> schools, and get school-level estimates that account for different
> sample sizes. Some schools only have 5 students.

### Assertions (9 checks)

1. Builds a hierarchical/multilevel model with school-level and student-level parameters
2. Uses non-centered parameterization (mu_offset * sigma pattern or equivalent)
3. Calls `pm.sample_prior_predictive()` before inference
4. Calls `pm.sample_posterior_predictive()` after inference
5. Uses `az.summary()` or `az.plot_trace()` for convergence diagnostics
6. Includes shrinkage analysis showing small schools pulled toward grand mean
7. Computes ICC (intraclass correlation) or variance partition coefficient
8. Uses coords and dims in the PyMC model definition
9. Reports credible intervals (94% HDI preferred) for school-level estimates

---

## Scenario 3 — troubleshooting-divergences

**This scenario is the fastest way to see the skill add value**, because
the unscaffolded agent typically glosses over "unreliable" while the
skill forces an explicit statement.

### Prompt

> My Bayesian model has 47 divergences out of 4000 samples and R-hat of
> 1.03 on two parameters. The trace plots look like one chain is stuck.
> What do I do?

### Assertions (8 checks)

1. Explicitly states that results are unreliable and should NOT be interpreted
2. Identifies all three symptoms: divergences, high R-hat, stuck chain
3. Suggests non-centered reparameterization as a fix
4. Suggests increasing `target_accept` (to 0.95 or higher)
5. Suggests checking for multimodality
6. Provides concrete Python/PyMC code examples for at least two fixes
7. Mentions R-hat threshold of 1.01 (not 1.1 or other outdated thresholds)
8. Suggests diagnostic visualization (pair plots, trace plots, or energy plots)

---

## Scenario 4 — count-data-overdispersion

**Eval ID:** 4. **Difficulty:** moderate. **Note:** this is the only
scenario in Andorra's published benchmark where the unscaffolded agent
also scores 100% (9/9). Both with-skill and without-skill agents
correctly recognize overdispersion and reach for NegativeBinomial. If
you want a scenario that *visibly* discriminates the two conditions,
pick scenario 1 (logistic-regression-churn) or scenario 3
(troubleshooting-divergences) instead. count-data-overdispersion is a
useful scenario to demonstrate that the skill does not always change
the outcome — sometimes the agent's default is already correct.

### Prompt

> I'm analyzing the number of customer support tickets per day for a
> SaaS company. Over the past 6 months (180 days), most days have 5-15
> tickets, but some days spike to 40+. The variance seems larger than
> the mean. I want to model this and understand what drives the spikes
> — I have day_of_week and whether there was a product release that
> day as predictors.

### Assertions (9 checks)

1. Recognizes overdispersion and selects NegativeBinomial (not just Poisson) as the likelihood
2. Explains WHY NegBinomial is preferred over Poisson (overdispersion / variance > mean)
3. Uses log-link function for count data
4. Sets appropriate priors for count model parameters
5. Calls `pm.sample_prior_predictive()` before inference
6. Calls `pm.sample_posterior_predictive()` after inference
7. Uses `az.summary()` or `az.plot_trace()` for convergence diagnostics
8. Reports predictor effects with uncertainty intervals (HDI)
9. Interprets effects on the natural count scale (not just log scale)

---

## Scenario 5 — model-comparison-houses

**Eval ID:** 5. **Difficulty:** moderate.

### Prompt

> I have two models for predicting house prices: one is a simple linear
> regression (square footage + bedrooms), the other adds neighborhood
> as a hierarchical effect. Both have converged fine. How do I compare
> them and decide which to use? I have the InferenceData objects for both.

### Assertions (8 checks)

1. Uses `az.compare()` or `az.loo()` for LOO-CV comparison
2. Reports ELPD values with standard errors
3. Reports ELPD difference between models with its standard error (dse)
4. Interprets ELPD difference using magnitude thresholds (2x or 4x dse)
5. Checks and reports Pareto k diagnostics
6. Mentions stacking weights as a complementary tool
7. Suggests preferring the simpler model if models are indistinguishable
8. Provides a comparison table or structured output format

---

## Scenario 6 — prior-elicitation-report

**Eval ID:** 6. **Difficulty:** harder (the prompt asks for both
modeling AND a non-technical report).

### Prompt

> I'm new to Bayesian stats and I need to model the effect of a new
> drug on blood pressure. I have pre/post measurements for 80 patients
> (treatment group) and 80 controls. I honestly don't know what priors
> to pick — the blood pressure difference could be anywhere from -20 to
> +5 mmHg based on similar drugs. Also, my boss wants a report she can
> present to the medical board. Can you walk me through the whole thing?

### Assertions (9 checks)

1. Translates domain knowledge (-20 to +5 mmHg) into concrete prior distribution parameters
2. Mentions PreliZ or prior predictive checks as a way to validate prior choices
3. Calls `pm.sample_prior_predictive()` to check priors
4. Documents prior justifications in the code or notes
5. Runs convergence diagnostics (`az.summary` or `az.plot_trace`)
6. Calls `pm.sample_posterior_predictive()`
7. Generates a structured report suitable for a non-technical audience
8. Uses probability language (credible intervals, posterior probability) not frequentist language (p-values, significant)
9. Explains concepts in an accessible way for a Bayesian beginner

---

## Scenario 7 — prior-sensitivity-check

**Eval ID:** 7. **Difficulty:** hardest (14 assertions, involves
ArviZ prior sensitivity tooling that is less well known).

### Prompt

> I'm modeling the effect of a workplace safety program on injury rates
> across 30 factories. I have monthly injury counts for 2 years before
> and after the program was introduced, plus number of employees per
> factory. I have strong prior beliefs from a previous study that the
> program reduces injuries by about 25% (rate ratio around 0.75), so I
> want to encode that as an informative prior. But a colleague
> challenged me, saying my prior might be driving the results. Can you
> build the model and check whether my conclusions are sensitive to
> the prior choice?

### Assertions (14 checks)

1. Uses a count likelihood (Poisson or NegativeBinomial) with log-link
2. Encodes an informative prior on the treatment effect reflecting the ~25% reduction belief
3. Calls `pm.sample_prior_predictive()` before inference
4. Calls `pm.sample()` with `nuts_sampler='nutpie'`
5. Calls `pm.compute_log_likelihood(idata, model=model)` after sampling
6. Calls `pm.compute_log_prior(idata, model=model)` after sampling
7. Imports `psense_summary` from `arviz_stats` and runs it on the InferenceData
8. Interprets the `psense_summary` output — mentions CJS values or sensitivity diagnosis for the treatment effect parameter
9. Discusses whether the informative prior flags as sensitive and what that means for the conclusions
10. Does NOT reflexively weaken the prior just because sensitivity is flagged — justifies the choice or explains the tradeoff
11. Imports `plot_psense_dist` from `arviz_plots` (not `arviz_stats`) for visual sensitivity diagnostics
12. Uses coords and dims in the PyMC model definition
13. Reports 94% HDI (not 95% CI) for parameter estimates
14. Generates a companion analysis notes file interpreting the sensitivity results

---

## Track B3 — Advanced: write your own scenario

If you finish Track B1 and Track B2 early, write your own scenario in
the same format:

1. Create a new directory in a scratch location, e.g.
   `~/my-scenario/`.
2. Write an `eval_metadata.json` file with two fields:
   - `"prompt"`: a prompt from your own research area
   - `"assertions"`: a list of 8–12 strings, each a specific checkable
     claim the agent's output must satisfy
3. Run the prompt through Claude Code with the skill active.
4. Grade the output against your assertions.
5. If the skill fails any assertion in your area, open a GitHub issue
   on baygent-skills with the scenario file and the agent's output.
   This is a real contribution back to the upstream project.

Writing an eval is harder than using one. You will discover that
specifying "what counts as a correct answer" is most of the work of
making a skill useful.
