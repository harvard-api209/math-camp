# Evidence brief: teaching statistics, R, and coding agents

## Design conclusion

Math Camp should not teach AI as a shortcut around statistical thinking. It should teach a repeatable relationship between a policy question, a dataset, R code, an agent, and verification.

The recurring classroom protocol is:

1. Frame the question and predict what a reasonable result might look like.
2. Inspect or write a small amount of R without an agent.
3. Ask Codex or Claude Code for a bounded change.
4. Run the code and examine observable evidence.
5. Explain what was accepted, revised, or rejected.

## What the evidence suggests

### Begin with questions, real data, concepts, and active work

The American Statistical Association's GAISE guidance emphasizes statistical thinking, real data, conceptual understanding, active learning, and technology used to understand and analyze data. This supports one shared development dataset and four authentic policy questions rather than a sequence of disconnected syntax exercises.

Source: [ASA GAISE reports](https://www.amstat.org/education/guidelines-for-assessment-and-instruction-in-statistics-education-%28gaise%29-reports)

### AI can lower syntax barriers for non-specialists

Bien and Mukherjee used GitHub Copilot to translate English prompts into R code in a required MBA data science course. Their students began with the console, simple assignments, R scripts, and comments before learning three prompting principles: be specific, understand context, and break complex operations into smaller steps. They recommend checking generated work with ranges, rows, and plots. They also note that teaching R Markdown from the start may fit an English-to-code workflow better than moving to it late.

Source: [Generative AI for Data Science 101](https://arxiv.org/abs/2401.17647)

### Generate-modify tasks can support novices

A controlled study of novice programmers found that access to Codex improved code-authoring completion and scores without a detected reduction in later code-modification performance. The authors connect the result to a use-modify-create sequence. Benefits were stronger for learners with more prior conceptual knowledge, which is a warning to keep the no-agent foundation and the verification scaffolds.

Source: [Kazemitabaar et al., CHI 2023](https://arxiv.org/abs/2302.07427)

### Statistical judgment must remain visible

The University of Virginia's statistics teaching example stresses that a model generally does not know when it is wrong, so users must understand enough of the concept and context to verify its output. Recent statistics education research similarly suggests that AI tutoring can facilitate statistical thinking more effectively when students already have stronger conceptual understanding.

Sources: [UVA, Using Generative AI with Healthy Skepticism](https://teaching.virginia.edu/resources/using-generative-ai-with-healthy-skepticism), [ASA summary of Students' Statistical Thinking When Using Generative AI](https://www.amstat.org/publications/q-and-as/generative-ai-s-role--gaps-in-ecosystem-for-data-science-education-in-newest-issue)

### Grade the process when grading matters

Harvard's Bok Center recommends workflow logs, source-anchored critique, fact-checking AI output, model comparison, and short in-person comprehension checks. Math Camp is ungraded, but the same ideas become lightweight lab artifacts: a prompt, a generated change, a verification, and a short judgment.

Source: [Harvard Bok Center, Designing Courses and Assignments in the Age of AI](https://bokcenter.harvard.edu/courses-and-assignments-in-age-of-ai)

### AI can level hidden coding prerequisites, but privacy still matters

Harvard teaching guidance identifies coding as a hidden prerequisite that AI may help students overcome. It also emphasizes hallucination, bias, privacy, transparency, and course-specific norms. Math Camp therefore uses only public, deidentified data and makes disclosure and verification part of the normal workflow.

Source: [Harvard, Teach with Generative AI](https://www.harvard.edu/ai/teaching-resources/)

### Agents should receive goals, context, constraints, and a completion test

Current Codex guidance recommends prompts that specify the goal, relevant context, constraints, and what must be true when the task is done. It also recommends tests and review rather than stopping after code generation. Claude Code documentation uses a similar repo-aware loop: inspect the project, propose changes, run available checks, and review the diff.

Sources: [Codex best practices](https://learn.chatgpt.com/guides/best-practices), [Claude Code quickstart](https://code.claude.com/docs/en/quickstart)

### One frozen WDI extract offers both stability and authenticity

World Development Indicators contains internationally comparable indicators across education, health, gender, infrastructure, the economy, and the environment. The API requires no key. A frozen 2000-2022 file makes classroom results stable, while an extension exercise can query later observations and confront real differences in release calendars and missingness.

Sources: [About World Development Indicators](https://datatopics.worldbank.org/world-development-indicators/about-world-development-indicators.html), [World Bank Indicators API](https://datahelpdesk.worldbank.org/knowledgebase/articles/889392)

### Slides and the teaching book can share one source language

Quarto can create RevealJS HTML slides from markdown and apply shared branding across formats. Each lesson can therefore have a stable `slides/lesson-n/index.html` destination while instructors edit the corresponding `slides.qmd` file.

Sources: [Quarto RevealJS](https://quarto.org/docs/presentations/revealjs/), [Quarto brand files](https://quarto.org/docs/authoring/brand.html)

## Implications for Math Camp

- Lesson 1 distinguishes R, RStudio, Quarto, and the agent.
- Every exercise includes a human prediction before agent use.
- Every agent task is small enough to review.
- Every result has a concrete verification method.
- Every policy track uses the same country-year data structure.
- A frozen file prevents setup failure; an update challenge exposes authentic data work.
- Labs permit collaboration, but no group submission or grading is required.
- An optional Quarto field notebook records progress across all four lessons.
