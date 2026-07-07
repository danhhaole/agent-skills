# Data Scientist Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill turns your AI agent into a working **data scientist** — mind and method — for any question that starts with a dataset and ends with a decision.

## What Is the Data Scientist Skill?

This is not a wrapper around a data-science library. The agent writes its own analysis code, freely, in whatever language and tooling the environment offers — the skill supplies the discipline that code gets written inside: what to check before trusting a column, what to run before believing a metric, what a claim needs before it ships. References teach method and judgment, two bundled scripts standardize the two steps most often done sloppily, and checklists gate every claim before it reaches a reader.

**You advise; the user decides.** Every engagement ends in a recommendation with quantified trade-offs ("lower the threshold to 0.4 and you catch 15% more fraud but wrongly block 3% of good customers") — never in the agent making the business call. Full optimization problems (pricing engines, resource-allocation solvers) are out of scope: the skill surfaces the levers and their costs, then hands the lever back. Scope is Data Scientist only — no Data Engineering pipelines, no MLOps/deployment infrastructure.

## Why Use It?

- **No number without executed code.** Every mean, count, or correlation traces to the printed output of code that actually ran. A confident fabricated statistic is this skill's single worst failure mode, and it's built to refuse that shortcut.
- **Data looked at before it's analyzed.** No schema, column name, or user description is trusted at face value — `scripts/profile_data.py` runs first, even when the ask is straight for a model.
- **Baseline before complexity.** No gradient boosting, no neural nets, no tuning until a dummy baseline and a linear model have run — "92% accuracy" is meaningless until you know the majority class gets 90%.
- **Every estimate carries uncertainty.** A point estimate without a confidence interval, error bar, or cross-validation spread is treated as unfinished work.
- **Leakage checked before any metric is believed.** `checklists/leakage.md` runs before a validation score is reported — leakage is the most expensive silent failure in applied data science.
- **Red-teamed before it ships.** Every conclusion that could drive a decision goes through an adversarial review pass — `checklists/analysis-review.md` — looking for leakage, confounders, and alternative explanations, before it reaches the deliverable.

## The Four Questions

Every engagement is routed by which level the user's question actually lives at:

| Level | Question | Primary flow |
|---|---|---|
| Descriptive | What happened? | Explore |
| Diagnostic | Why did it happen? | Inquire |
| Predictive | What is likely to happen? | Predict |
| Prescriptive | What should we do about it? | Recommendation section of any flow |

Users often ask at one level while needing another — asking for a model when they need a diagnosis. `references/framing.md` is read before the question is accepted as asked.

## The Six Flows

| User's ask sounds like | Flow | Deliverable |
|---|---|---|
| "Help me reduce churn", a vague business goal | **Full engagement** | `insight-report.md` |
| "Explore this dataset", "what's in this file?" | **Explore** | `eda-report.md` |
| "Is A better than B?", "is this significant?", sample size | **Inquire** | stats results + interpretation |
| "Build a model to predict X", forecast | **Predict** | `model-card.md` + `experiment-log.md` |
| "Review this analysis / notebook / model" | **Review** | critique report |
| "Write this up for my boss / stakeholders" | **Communicate** | `insight-report.md` |

The short flows are entry points into the full pipeline, not separate methods — Explore is phases 2-3 of a full engagement, Predict is phases 4-5, and so on.

**Review deserves its own emphasis.** Acting as an expert validator — of a human's notebook or another AI's analysis — is where a data scientist's judgment matters most. It runs as an adversarial pass: assume the analysis is wrong and try to prove it.

## The Review Gate

Whatever the flow, before any conclusion that could drive a decision leaves the agent's hands, it switches hats: stop being the analyst who produced the result, become the reviewer trying to kill it. `checklists/analysis-review.md` walks leakage, confounders, alternative explanations, and whether the result survives a different data split. Findings from this pass land in the deliverable's Limitations section, not a private note — an analysis that hasn't survived its own red team isn't done.

## Bundled Scripts

Two scripts standardize the two steps most often done sloppily. Both need `pandas`/`numpy`; the baseline runner also needs `scikit-learn`. Both write a markdown report for the workspace plus a JSON file for the agent to read.

**`scripts/profile_data.py`** — first contact with any dataset. Shape, types, missing patterns, cardinality, distributions, duplicates, correlations, and a warnings section (constant columns, ID-like columns, class imbalance, placeholder values, leakage-suspect correlations):

```bash
python scripts/profile_data.py data.csv --target churn --out ds-workspace/my-project
```

**`scripts/baseline_model.py`** — the mandatory floor for any Predict flow. Runs a dummy baseline and a linear model in leak-safe cross-validated pipelines (all preprocessing fit inside folds), auto-detects task type, uses time-based splits when given `--time-col`, group splits with `--group-col`, and scans for mechanical leakage (single features that predict the target suspiciously well, duplicate rows across folds):

```bash
python scripts/baseline_model.py data.csv --target churn --time-col signup_date --out ds-workspace/my-project
```

Anything beyond the baseline — feature engineering, gradient boosting, tuning — is written by hand, guided by `references/modeling.md`, and must beat the baseline to justify the added complexity.

## The Workspace

Each engagement gets a working directory so artifacts accumulate instead of scattering:

```text
ds-workspace/{project-slug}/
  project-brief.md      # from templates/ — framing, written first
  data-profile.md        # output of profile_data.py
  eda-report.md          # findings + hypotheses
  experiment-log.md      # every model run: config, data, results — append-only
  model-card.md          # the model that ships
  insight-report.md      # the deliverable for decision-makers
```

Skeletons are copied from `templates/` as each phase begins. The experiment log is the poor man's MLflow: if a result isn't logged with enough detail to reproduce it, it doesn't exist.

## How to Trigger

Ask your AI agent tasks like:

```text
Analyze this CSV and tell me what's driving the drop in retention this quarter.
```

```text
Is the conversion lift in variant B statistically significant, or could this be noise?
```

```text
Build me a model to predict which customers are likely to churn next month.
```

```text
Here's my notebook — review it before I present these numbers to leadership.
```

**Trigger phrases:** "analyze this dataset", "explore this CSV", "what drove this change?", "is this difference significant?", "A/B test", "build a model to predict...", "review this analysis/notebook", "write this up for stakeholders", "phân tích dữ liệu", "xây model dự đoán", "kiểm định A/B"

## File Structure

```text
data-scientist/
  SKILL.md                          # Entry point: non-negotiables, routing, workspace, scripts
  references/
    workflow.md                     # Full phase-by-phase pipeline guidance
    framing.md                      # Turning a business ask into the right question
    eda.md                          # Exploratory data analysis
    statistics.md                   # Hypothesis tests, comparisons, causal claims, sample size
    modeling.md                     # Building predictive models
    evaluation.md                   # Choosing metrics; judging model quality
    interpretation.md               # Explaining what drives a model or an effect
    communication.md                # Writing for stakeholders
  checklists/
    data-quality.md                 # Gate: before analysis begins
    leakage.md                      # Gate: before believing any model metric
    analysis-review.md              # Gate: before any conclusion ships; the Review flow
  templates/                        # project-brief, eda-report, experiment-log, model-card,
                                     # insight-report
  scripts/
    profile_data.py                 # Dataset profiling: structure, quality, warnings
    baseline_model.py               # Leak-safe dummy + linear baselines with CV
```

Engagements themselves are written to `ds-workspace/{project-slug}/`, accumulating the artifacts listed above as each phase completes.

## Installation

### 1. Using CLI (Recommended)

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### 2. Manual Installation (For Non-Technical Users)

1. **Download:** Go to the `skills/` folder in this repository and download `data-scientist.zip`.
2. **Extract & Copy:** Extract `data-scientist.zip` and copy the `data-scientist` folder into one of the following directories:

**For a Specific Project:**
Copy the `data-scientist` folder to `.agents/skills/` or `.claude/skills/` in your project's root directory.

**Globally (Available for all projects):**
* **Mac / Linux:** `~/.agents/skills/` or `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` or `%USERPROFILE%\.claude\skills\` (usually `C:\Users\<YourUsername>`)

## Example Usage

> **You:** Here's `orders.csv`. Can you tell me why revenue per user dropped last month?
>
> **Agent:** Running `profile_data.py` first — before I look for a "why," I want to know what's actually in this file. [profiles the data, flags that `discount_code` is 40% missing and `user_id` is not unique]
>
> **Agent:** Retention looks flat but average order value dropped 18%. That's a diagnostic question, so I'm treating this as an Inquire flow — comparing order value across the periods with a proper significance test rather than eyeballing the trend line.
>
> *(runs the comparison, checks for confounders — did the mix of products change, did a discount campaign end)*
>
> **Agent:** The drop survives controlling for product mix; it lines up with the discount campaign ending on the 14th. Before I write this up, running it through the review checklist — is there a simpler explanation, does this hold on a different date cut. [confirms, then drafts `insight-report.md` with the finding, the confidence interval, and what to check next if you want to act on it.]

