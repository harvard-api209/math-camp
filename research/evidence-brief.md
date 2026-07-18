# Evidence brief: teaching statistics, R, and coding agents

## Design conclusion

Math Camp should not teach AI as a shortcut around statistical thinking. It should teach a repeatable relationship between a policy question, a dataset, R code, an agent, and verification.

The recurring classroom protocol is:

1. Frame the question and predict what a reasonable result might look like.
2. Inspect or write a small amount of R without an agent.
3. Ask Codex or Claude Code for a bounded change.
4. Run the code and examine observable evidence.
5. Explain what was accepted, revised, or rejected.

The 2026 revision adds a second conclusion: students need a simple mental model of
the technology before they can supervise it. The course therefore distinguishes
five layers:

1. **AI** is the broad family of computational systems.
2. **A large language model (LLM)** generates text or code from instructions and
   context; it does not itself browse files, run R, or edit a project.
3. **A chat interface** sends messages to a model and displays its responses.
4. **A coding agent** uses a model in a loop that can inspect context, request
   tools, observe results, and continue.
5. **A harness** is the workshop around the model: the system prompt, context
   assembly, tools, permissions, memory, and feedback loop that turn generated
   text into controlled action.

The student-facing analogy is: **the model is the language engine, the harness is
the workshop, the agent is the engine working inside that workshop, and the
student is the investigator who writes the work order and inspects the evidence.**

## What the evidence suggests

### Begin with questions, real data, concepts, and active work

The American Statistical Association's GAISE guidance emphasizes statistical thinking, real data, conceptual understanding, active learning, and technology used to understand and analyze data. This supports one shared development dataset and four authentic policy questions rather than a sequence of disconnected syntax exercises.

Source: [ASA GAISE reports](https://www.amstat.org/education/guidelines-for-assessment-and-instruction-in-statistics-education-%28gaise%29-reports)

### AI can lower syntax barriers for non-specialists

Bien and Mukherjee used GitHub Copilot to translate English prompts into R code in a required MBA data science course. Their students began with the console, simple assignments, R scripts, and comments before learning three prompting principles: be specific, understand context, and break complex operations into smaller steps. They recommend checking generated work with ranges, rows, and plots. They also note that teaching R Markdown from the start may fit an English-to-code workflow better than moving to it late.

Source: [Generative AI for Data Science 101](https://arxiv.org/abs/2401.17647)

### Critique-and-revise is stronger than copy-and-run

Layla Guyot's 2025 statistics and data science activity at the University of
Texas asks students to evaluate generated code, refine it using course
knowledge, reflect on the process, and then apply the revised code. Only 17% of
students in the reported activity produced a fully correct solution, while 55%
could partially correct the generated code. The important learning object is
therefore not the first output. It is the comparison between the output,
students' reasoning, and the repaired result.

Source: [AI-Supported Coding Assignments, UT Austin](https://utexas.pressbooks.pub/procko-smith/chapter/creating-ai-evaluation-assignments-to-enhance-coding-skills/)

### Guided assistance should preserve the struggle that produces understanding

Harvard's CS50 uses a course-specific "rubber duck" to approximate an always
available tutor that guides students rather than simply supplying solutions.
NTU Singapore's probability and statistics tutor is described in the same way:
a guided learning assistant rather than a solution generator. Berkeley Stat
133, from a different policy position, permits AI for brainstorming and syntax
debugging while protecting opportunities to practice whole scripts
independently. Together these examples support a deliberate sequence in Math
Camp: **human prediction first, bounded agent help second, executable evidence
third**.

Sources: [CS50 Artificial Intelligence notes](https://cs50.harvard.edu/college/2025/spring/notes/ai/), [NTU Learn with AI framework](https://www.ntu.edu.sg/computing/news-events/news/detail/learning-with-ai--strengthening-computing-education-in-an-ai-shaped-world), [Berkeley Stat 133 syllabus](https://stat133.berkeley.edu/spring-2025/syllabus.html)

### Concepts, computation, and policy context should meet in the same activity

Illinois Data Science DISCOVERY organizes introductory data science around the
intersection of inferential thinking, computation, and real-world relevance,
with synchronous labs devoted to small-group programming and discussion.
Berkeley Stat 133 similarly separates the conceptual emphasis of lecture from
the application of ideas in R during labs. Math Camp adopts both ideas: lesson
chapters explain why a move matters, and labs make students predict, run,
inspect, and discuss the move using one international-development dataset.

Sources: [Illinois Data Science DISCOVERY](https://discovery.cs.illinois.edu/syllabus/), [Berkeley Stat 133 syllabus](https://stat133.berkeley.edu/spring-2025/syllabus.html)

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

### The model is not the agent, and the harness changes the experience

Current coding-agent explanations increasingly distinguish the language model
from the harness around it. Microsoft's VS Code team describes the harness as
the layer that assembles context, exposes tools, executes tool calls, and
returns results to the model for another round. Theo Browne's 2026 walkthrough
uses the same practical distinction: the model pauses, the harness runs
ordinary code to read, list, or edit files, and the result is appended to the
conversation before the next model step. This distinction matters
pedagogically because it gives students concrete questions to ask: What files
can the agent see? Which tools can it call? What permission did I grant? What
result came back? What check stops the loop?

Sources: [The Coding Harness Behind GitHub Copilot in VS Code](https://code.visualstudio.com/blogs/2026/05/15/agent-harnesses-github-copilot-vscode), [Theo Browne, “How does Claude Code actually work?”](https://rewiz.app/channels/%40theo-t3gg/how-does-claude-code-actually-work)

### AI assistance changes what it means to learn coding; it does not remove the value

Andrew Ng argues that coding plus prompting can accomplish substantially more
than prompting through a chat interface alone. He also distinguishes the
ambiguity of natural-language instructions from the greater precision and
repeatability of code. His later discussion of AI-assisted coding emphasizes
that lower-cost prototyping creates more opportunities to learn by building,
testing modules, and revising them. For Math Camp, the implication is not that
students must memorize more syntax than an agent. It is that students need
enough coding literacy to read, modify, test, and take responsibility for
agent-assisted work.

Sources: [Andrew Ng, “Coding Skill is More Valuable Than Ever”](https://www.deeplearning.ai/the-batch/coding-skill-is-more-valuable-than-ever), [Andrew Ng, “New Opportunities for the New Year”](https://www.deeplearning.ai/the-batch/new-opportunities-for-the-new-year/)

### One frozen WDI extract offers both stability and authenticity

World Development Indicators contains internationally comparable indicators across education, health, gender, infrastructure, the economy, and the environment. The API requires no key. A frozen 2000-2022 file makes classroom results stable, while an extension exercise can query later observations and confront real differences in release calendars and missingness.

Sources: [About World Development Indicators](https://datatopics.worldbank.org/world-development-indicators/about-world-development-indicators.html), [World Bank Indicators API](https://datahelpdesk.worldbank.org/knowledgebase/articles/889392)

### Slides and the teaching book can share one source language

Quarto can create RevealJS HTML slides from markdown and apply shared branding across formats. Each lesson can therefore have a stable `slides/lesson-n/index.html` destination while instructors edit the corresponding `slides.qmd` file.

Sources: [Quarto RevealJS](https://quarto.org/docs/presentations/revealjs/), [Quarto brand files](https://quarto.org/docs/authoring/brand.html)

## Implications for Math Camp

- Lesson 1 distinguishes AI, an LLM, a chat interface, a coding agent, and its
  harness before comparing R, RStudio, Quarto, Codex, and Claude Code.
- The agent's role grows deliberately: **explainer → data engineer → skeptical
  reviewer → handoff auditor**.
- Every exercise includes a human prediction or attempted explanation before
  agent use.
- Every agent task has a bounded work order: goal, context, constraints, and an
  observable definition of done.
- Every generated claim is classified as confirmed, contradicted, or unresolved.
- Every result has a concrete verification method, and students keep a compact
  verification receipt: prediction, action, evidence, decision.
- Every policy track uses the same country-year data structure.
- A frozen file prevents setup failure; an update challenge exposes authentic data work.
- Labs permit collaboration, but no group submission or grading is required.
- An optional Quarto field notebook records progress across all four lessons.
