# Track B1 — Activation Queries

**Purpose:** verify the bayesian-workflow skill
activates on Bayesian questions and stays silent on adjacent-but-unrelated
questions.

These 21 queries are from Alex Andorra's published evaluation set at
`baygent-skills/evals/bayesian-workflow/trigger_eval_set.json`. Ten are
labeled `should_trigger: true` (the skill should activate), eleven are
labeled `should_trigger: false` (the skill should stay silent). If your
installed skill activates on one group but not the other, the
description field in SKILL.md is doing its job.

## How to run

1. Open Claude Code in any directory.
2. Pick one query from the "should trigger" list and paste it as a prompt.
3. Watch for an indication that the bayesian-workflow skill has been
   loaded (Claude Code will typically note the skill or follow the
   workflow structure).
4. In a fresh Claude Code session, pick one query from the "should NOT
   trigger" list and paste it.
5. Confirm the skill does not activate on the second query.

For the workshop, running two queries from the first list and one from
the second list is enough to see the discrimination working.

---

## Queries the skill SHOULD trigger on

1. "I've got survey data from 3000 respondents across 12 regions and I
   want to estimate the probability that someone supports a policy
   change, accounting for regional variation. Some regions only have 30
   respondents so I need the estimates to borrow strength. Can you
   build a Bayesian model for this?"

2. "my pymc model has like 200 divergences and rhat is 1.05 on the
   variance parameter. the trace plot for chain 3 looks totally flat.
   what's going wrong and how do i fix it?"

3. "I need to compare two models for predicting patient readmission
   rates — one with just demographics and one adding hospital-level
   random effects. I have the InferenceData objects from both runs.
   Which model should I go with?"

4. "We're launching a new pricing experiment and I need to model
   conversion rates with uncertainty. We have about 10k visitors split
   across 4 price tiers, and I want posterior distributions over the
   conversion rate for each tier, not just point estimates. My team
   uses Python."

5. "I want to set priors for a clinical trial model but I genuinely
   don't know what values to use. The treatment effect could plausibly
   be anywhere from -15 to +3 units. Can you help me translate that
   into a prior distribution and check if it makes sense?"

6. "can you build me a count regression for the number of workplace
   injuries per month at our 45 factories? i have the data in a csv —
   columns are factory_id, month, injury_count, num_employees,
   has_safety_program. the variance is way bigger than the mean so
   poisson probably won't cut it"

7. "I ran a Bayesian model yesterday and got results but I'm not sure I
   trust them. How do I check if the model actually fits the data well?
   I saved the inference data as a .nc file"

8. "My boss wants me to present our Bayesian analysis results to the
   executive team next week. They're not technical at all — no stats
   background. I need a report that explains what credible intervals
   mean, why we used this approach, and what the business implications
   are. The model is already fit, I just need help with the reporting."

9. "I'm trying to understand the effect of temperature on crop yield
   using data from 50 farms over 10 years. I want to account for the
   fact that farms might respond differently to temperature. Should I
   use a hierarchical model? Can you walk me through setting this up?"

10. "I built a Bayesian model with informative priors from a previous
    study, but a reviewer is asking whether my conclusions are driven
    by the priors or the data. How do I check prior sensitivity without
    refitting the model multiple times? I have the InferenceData saved."

---

## Queries the skill should NOT trigger on

1. "I need to predict which customers will churn next quarter. I have
   a dataset with 50k rows, binary target, and about 20 features. I
   want to use XGBoost and tune hyperparameters with Optuna. Can you
   set up the training pipeline?"

2. "Can you help me build a neural network in PyTorch to classify
   images of skin lesions? I have about 10k labeled dermatology images
   in a folder structure organized by diagnosis."

3. "I need to run an A/B test analysis for our website redesign. We
   have 50k users in control and 50k in treatment with conversion rates
   of 3.2% vs 3.8%. Can you calculate the p-value and tell me if the
   difference is statistically significant?"

4. "I'm fitting a linear mixed model using statsmodels MixedLM to
   analyze student test scores nested within schools. Can you help me
   interpret the random effects output and the ICC?"

5. "I want to forecast daily sales for the next 90 days using Prophet.
   I have 3 years of daily data with some holiday effects. Can you set
   up the model and tune the seasonality?"

6. "Help me build a recommendation system for our e-commerce site. We
   have user-item interaction data (clicks and purchases) for 100k
   users and 5k products. I'm thinking collaborative filtering with
   implicit feedback."

7. "I'm doing exploratory data analysis on a dataset of house prices.
   Can you create some visualizations — scatter plots of price vs
   square footage, distribution of prices by neighborhood, correlation
   heatmap of the numeric features?"

8. "I need to set up a scikit-learn pipeline that does imputation,
   one-hot encoding, and then fits a random forest classifier. My data
   has both numeric and categorical columns. Can you write the
   ColumnTransformer setup?"

9. "We have sensor data from IoT devices and I need to detect anomalies
   in real-time. Can you help me set up an isolation forest or
   autoencoder-based anomaly detection system in Python?"

10. "I'm building a causal inference analysis using DoWhy to estimate
    the average treatment effect of a marketing campaign. I have
    observational data with potential confounders. Can you help me set
    up the causal graph and run the estimation?"

    **Note:** This query should activate the *causal-inference* skill
    rather than the bayesian-workflow skill. If you installed both,
    verify that the right skill activates. If you only installed
    bayesian-workflow, verify that it stays silent here.

11. "I need to fit a Gaussian process regression to model the
    relationship between soil moisture and several environmental
    predictors. I have spatial data from 200 sampling locations. Can
    you set this up using scikit-learn's GaussianProcessRegressor?"

---

## What to look for

- **Good activation:** On a should-trigger query, Claude Code either
  notes the skill by name or follows the ten-step workflow (generative
  story, priors, prior predictive check, inference with nutpie,
  diagnostics, criticism, sensitivity, comparison, reporting).

- **Good non-activation:** On a should-not-trigger query, Claude Code
  proceeds with whatever default it would use, without invoking the
  workflow structure. The query is not Bayesian (or not in the
  skill's scope) and the agent correctly recognizes this.

- **Common failure 1 — missed activation:** The skill does not
  activate on a Bayesian question. This means the description field
  does not match the phrasing of the query. The fix is to expand the
  description in `~/.claude/skills/bayesian-workflow/SKILL.md` to
  include the phrasings your users actually write.

- **Common failure 2 — false activation:** The skill activates on a
  non-Bayesian question. This means the description is too broad. The
  fix is to narrow the description.

- **Common failure 3 — silent activation:** The skill loads but the
  workflow structure is not visible in the response. This usually
  means the agent loaded the SKILL.md but is not referencing it.
  Re-prompt: "Please follow the bayesian-workflow skill explicitly"
  and see whether the behavior changes.
