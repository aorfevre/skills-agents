# skills-agents

A Claude Code plugin marketplace. It lists curated skills from other GitHub repos.
No skill files are copied here. Each entry points at its upstream repo and is pinned to a commit.

Every candidate is reviewed before it enters the catalog. Entries that are generic prose, stale, or broken are rejected. The rejections are listed below with the reason.

## Use in a project

Register the marketplace once per machine, or per project with `--scope project`:

```bash
claude plugin marketplace add aorfevre/skills-agents
```

Install a plugin by name:

```bash
claude plugin install gsap-skills@skills-agents
```

To pin the marketplace in a project for every collaborator, add it to `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "skills-agents": {
      "source": { "source": "github", "repo": "aorfevre/skills-agents" }
    }
  },
  "enabledPlugins": {
    "gsap-skills@skills-agents": true
  }
}
```

## Catalog

### Motion and video

Install as a stack. The official plugins give the API. The others give taste, timing numbers and tooling on top.

| Plugin | What it adds | Upstream | License |
| --- | --- | --- | --- |
| `product-launch-motion` | Launch videos from code. Voiceover-locked timing, camera rig, film grade, a mastering chain measured on the delivered file. Renders through HyperFrames. | [AbubakrChan/product-launch-motion](https://github.com/AbubakrChan/product-launch-motion) | MIT |
| `motion-broll` | B-roll as one morphing shape driven by a cursor. SAM 2 object separation, measured SFX placement, alpha ProRes for NLE drop-in. Own renderer, 6 MB. | [Barty-Bart/motion-graphics](https://github.com/Barty-Bart/motion-graphics) | MIT |
| `animate` | Animated shorts in 7 hand-drawn styles as one canvas HTML file, with a synthesized beat-mapped score. Not Remotion. | [cth9191/animate](https://github.com/cth9191/animate) | MIT |
| `hyperframes` | Official HeyGen HyperFrames. The engine's own contract: timelines, captions, local Whisper transcription, silence and filler cuts. 40 skills, loaded on demand. | [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) | Apache-2.0 |
| `remotion-skills` | Official Remotion skills. The only current source for the Remotion API. No taste layer. | [remotion-dev/skills](https://github.com/remotion-dev/skills) | none declared |
| `gsap-skills` | Official GSAP. Corrects stale model knowledge: plugins are free now, `useGSAP` hook, ScrollTrigger pitfalls. | [greensock/gsap-skills](https://github.com/greensock/gsap-skills) | MIT |
| `motion-design-principles` | LottieFiles. Library-agnostic numbers: durations per component, easing curves, exit ratios, stagger budgets. | [LottieFiles/motion-design-skill](https://github.com/LottieFiles/motion-design-skill) | MIT |
| `animate-text` | 24 text-animation recipes with exact timing, easing, stagger and playback rules, plus WAAPI, Motion and GSAP mappings. Four optional Node.js lookup scripts. Local files; no MCP or account. | [pixel-point/animate-text](https://github.com/pixel-point/animate-text/tree/main/skills/animate-text) | none declared |

`animate-text` is sourced directly from its original upstream, limited to `skills/animate-text/`. Better Design vendors the same skill, but its MCP workflow and component registry are not included. The helper scripts need Node.js 20+; the Markdown and JSON recipes can be read without Node.

Review results for `animate-text`, measured on 2026-10-14:

- An isolated marketplace install succeeded and contained only the intended skill. The checks below ran against that installed copy.
- The catalog contains 24 recipes; 20 are marked visible in the upstream showcase.
- All 48 spec/effect lookups passed from an unrelated working directory. Search returned the expected named and layout-aware effects; unknown IDs exited with an error.
- These checks cover the lookup tools and bundled data. Generated animation quality and visual parity were not benchmarked.

Known issues in kept plugins, reported upstream or to be reported:

- `gsap-skills`: the horizontal-scroll example has a `Max.max` typo and a logic error. Nine "recommend GSAP" lines are vendor steering.
- `animate`: `review.mjs` crashes when ffmpeg lacks the `drawtext` filter. Playwright must be installed globally.
- `motion-design-principles`: the spring table mixes absolute damping with damping ratio. Only `SKILL.md` is worth the context; `director/` repeats it.
- `remotion-skills`: `remotion-best-practices/` contains a second copy of the other 11 skills.
- `animate-text`: upstream has no declared license. The skill omits reduced-motion and screen-reader guidance; implementations need those checks separately. Exact showcase recipes loop by default, so request a one-shot reveal when that is the intended behavior.

### SEO, GEO, internal linking, sitemaps

Seven repos were reviewed against four needs: GEO, technical and on-page SEO, internal linking, sitemaps. One repo stands up whole. Four single-skill entries are cut from two marketing packs with a subdirectory source, so the other 200 skills in those packs never load.

| Plugin | What it adds | Upstream | License |
| --- | --- | --- | --- |
| `seo` | The one SEO plugin that holds up as a whole. Technical audit, the only sitemap validator found, GEO with correct crawler semantics, schema, agent readiness. 67 real Python tools. | [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | MIT |
| `ai-seo` | The best GEO document reviewed. 2026-dated, sourced, splits OAI-SearchBot from GPTBot, covers llms.txt and agent readiness, warns that one run is an anecdote. | [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills/tree/main/skills/ai-seo) | MIT |
| `site-architecture` | The only quantified internal-linking rule found: 5 to 10 links per 1000 words, hub and spoke, a 7-item link audit. | [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills/tree/main/skills/site-architecture) | MIT |
| `seo-audit-i18n` | Audit checklist. Its hreflang and international sitemap section is the strongest found. | [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills/tree/main/skills/seo-audit) | MIT |
| `seo-technical-rules` | 9 prose skills with real rules: robots per-bot table, canonical, indexing by page type, crawlability, rendering, IndexNow, XML sitemap limits and lastmod. | [kostja94/marketing-skills](https://github.com/kostja94/marketing-skills/tree/main/skills/seo/technical) | MIT |

Coverage of the four needs after this cut:

- GEO: strong. `seo` and `ai-seo` together.
- Technical and on-page SEO: strong. `seo` for tooling, `seo-technical-rules` for rules.
- Sitemaps: strong on validation and limits. `seo` has the only script. No repo covers news sitemaps.
- Internal linking: weak. Every repo is prose. No repo ships a crawler that counts inlinks or finds orphan pages. `site-architecture` is the best of the weak options. This gap needs a script written for it.

Known issues in kept SEO plugins:

- `seo`: install as `seo@skills-agents`. The upstream manifest name is `claude-seo`, and that name is reserved for marketplace entries, so details and skill prefixes use `claude-seo` (`claude plugin details claude-seo`, `/claude-seo:seo`). `/seo setup` builds a Python venv with 28 pinned deps. It adds a PostToolUse hook on every Edit and Write that spawns node and python. The script exits early when the file has no JSON-LD. One Skool community footer in the skills.
- `seo-technical-rules`: sitemap skill line 78 inverts the 50,000 URL rule. Reported upstream to be done.
- `ai-seo`: stats drift monthly. The skill itself says to re-check before quoting.

### Reverse engineering

This entry is the skill only. The tools come from the `rea-agents` MCP server (Model Context Protocol, a local tool server that the agent calls). Register the server once per machine:

```bash
claude mcp add --scope user rea -- npx -y rea-agents@6.4.0 mcp
```

Do not use `rea setup` for this. It also writes a second copy of the skill to `~/.claude/skills/reverse-engineer-anything`, which duplicates this plugin.

| Plugin | What it adds | Upstream | License |
| --- | --- | --- | --- |
| `rea` | Routes each target type to its first tool: native binary, Electron or ASAR, .NET, APK, firmware, HAR, browser page. Every conclusion must cite Evidence IDs and split observation, inference and unknown. Summary-first paging for large results. The maintainer skills in the same repo are left out. | [morluto/rea](https://github.com/morluto/rea/tree/main/.agents/skills/reverse-engineer-anything) | MIT |

Review results, measured on 2026-10-12 with npm `rea-agents@6.4.0` on macOS:

- The server exposes 170 tools. The `tools/list` response is 1.95 MB of JSON. Input schemas are 365 KB, and `compare_web_captures` alone is 57 KB. Expect a large context cost when the client loads all tool schemas.
- Static analysis of the Notion `app.asar` took 1 min 54 s. It returned 359 findings and 24 limitations. The analysis worker ran out of heap on 3 large webpack files and recorded each one as a limitation.
- The default run stops on an ASAR integrity mismatch for unpacked `.node` files. This is correct behavior, not a crash. The error names the flag that continues: `--integrity-policy record-and-continue`.
- Native decompilation needs Hopper, Ghidra or IDA. None was installed, so that path was not tested.

Known issues:

- The skill pin follows `main`, which is ahead of npm. At this pin, the skill documents `inspect_packet_capture`, `inspect_wasm_artifact`, `inspect_go_binary` and `inspect_sqlite_database`. Release 6.4.0 does not have them. The skill tells the agent to trust the live tool list, so the agent can recover.
- Node 22.19 or later on 22.x, 24.11 or later on 24.x, or 26 and later. The SQLite tool needs Node 24.15 or later. The optional `frida` dependency installs with the package.
- The upstream `DISCLAIMER.md` prohibits DRM and license-check bypass, anti-cheat work, and authentication bypass. Use REA only on targets you own or have authorization to examine.

### Engineering practice

Four single-skill cuts from [mattpocock/skills](https://github.com/mattpocock/skills). None of the four needs `/setup-matt-pocock-skills`, an issue tracker, or another skill. The whole 27-skill plugin is already in `claude-plugins-official`, so this catalog lists only the cuts.

| Plugin | What it adds | Upstream | License |
| --- | --- | --- | --- |
| `diagnosing-bugs` | The strongest skill in the pack. Build a feedback loop that can fail before you state any hypothesis. Rank 3 to 5 hypotheses that can be proved false. Tag debug logs so that they get removed. | [skills/engineering/diagnosing-bugs](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnosing-bugs) | MIT |
| `codebase-design` | Module design rules you can apply: the deletion test, deep modules, one adapter means a hypothetical seam, design it twice. | [skills/engineering/codebase-design](https://github.com/mattpocock/skills/tree/main/skills/engineering/codebase-design) | MIT |
| `grilling` | 328 words. Interviews you in rounds before work starts. The agent finds the facts, you make the decisions, and each question comes with a recommended answer. | [skills/productivity/grilling](https://github.com/mattpocock/skills/tree/main/skills/productivity/grilling) | MIT |
| `wizard` | Builds interactive setup scripts from a bash template. A test run wrote `.env` with mode 600 and exited 0. | [skills/engineering/wizard](https://github.com/mattpocock/skills/tree/main/skills/engineering/wizard) | MIT |

Known issues:

- `claude plugin details` estimates about 2,000 always-on tokens for each cut, but the skill descriptions are only 38 to 78 tokens. The estimate for the whole 27-skill plugin is about 3,600. The cause of the gap is not confirmed. Install only the cuts you use.
- `tdd` in the same pack calls `codebase-design`. Install both if you add `tdd` from the official listing.

### Code review

| Plugin | What it adds | Upstream | License |
| --- | --- | --- | --- |
| `open-code-review` | Alibaba's two portable skills. `open-code-review` runs the `ocr` CLI: fixed code selects files, groups them and attaches per-language rules, then an LLM reviews each group. `open-code-review-delegate` needs no LLM in `ocr`: it selects files and rules, and Claude does the review. | [alibaba/open-code-review](https://github.com/alibaba/open-code-review/tree/main/skills) | Apache-2.0 |

Install the CLI first: `npm i -g @alibaba-group/open-code-review`. Delegate mode is the best fit inside Claude Code. It needs no API key and adds no second bill.

Review results, measured on 2026-10-12 with `ocr` 1.12.13 on macOS:

- A scratch repo with 5 planted bugs: SQL injection, XSS through `innerHTML`, a null dereference, a Go map written from goroutines with no lock, and a `*` dependency version. `ocr review` found all 5 and 2 more valid issues, with no false positives. 16 s, 41,364 tokens, Sonnet 5.5.
- These were textbook bugs. The test shows that the pipeline works. It does not measure recall on real code.
- File selection excluded the lockfile and the Markdown file. The rules are specific to each language, for example the Go 1.22 change to loop variables.
- Inside Claude Code, `ocr` reads `ANTHROPIC_BASE_URL` and `ANTHROPIC_AUTH_TOKEN` from the environment and needs only `ANTHROPIC_MODEL`. Each review bills the same account as the session.
- Telemetry is off by default. This was checked in `internal/telemetry/config.go`.
- The upstream claim of 1/9 of the tokens of Claude Code is not verified here.

Known issues:

- The skills come from the repo's root `skills/` folder. Upstream also ships a Claude Code plugin with two slash commands, but its `/review` applies fixes without asking. The skill asks first unless you say "review and fix".
- When `ocr` is missing, the skill tells the agent to run `npm i -g` without asking you.
- The repo holds a second copy of each skill under `plugins/open-code-review/skills/`. The two copies already differ.
- The npm install script places a native binary for your platform.

### Security

| Plugin | What it does | Source | License |
|---|---|---|---|
| `security-audit` | Multi-phase security audit run by the coding agent before a release: reconnaissance, hunting by attack class, validation and a JSON findings report checked by two local Node.js validators. | [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill/tree/main/skills/security-audit) | MIT |

Reviewed on 2026-10-26 at c1c8a8c: Markdown guides plus `validate-findings.cjs` and `validate-coverage-ledger.cjs` (fs/path only, no network, no install scripts or hooks).

### Design

| Plugin | What it adds | Upstream | License |
| --- | --- | --- | --- |
| `impeccable` | One skill with 24 `/impeccable` commands: `shape`, `critique`, `audit`, `polish`, `typeset`, `layout`, `harden` and more, one reference file each. A loader reads `PRODUCT.md`, `DESIGN.md` and surface briefs before work starts. A rule-based detector names AI tells such as gradient text and glow shadows. Prose-only design skills have neither the loader nor the detector. | [pbakaus/impeccable](https://github.com/pbakaus/impeccable/tree/main/plugin/skills/impeccable) | Apache-2.0 |

Reviewed on 2026-10-26 at 6743a34 (skill 4.7.1, engine 0.1.17):

- Only `plugin/skills` is referenced. The upstream plugin also registers `SessionStart`, `PostToolUse` (Edit/Write) and `Stop` hooks. These run the engine in every session of every project. Use `/impeccable hooks on` to turn on the detector hook for one project.
- The four upstream subagents are also left out. A marketplace entry cannot keep them and drop the hooks: the upstream `plugin.json` declares components, so a non-strict entry fails to load. The skill uses `reference/degraded/*.md` when the subagents are missing.
- The first run downloads a native engine binary from the GitHub release `engine-v<version>`, about 18 to 22 MB for each platform. The launcher checks its sha256 against `engine-checksums.txt` in the pinned commit and caches it in `~/.impeccable/bin/<version>/`. It also writes `~/.impeccable/update-check.json`. No Node is needed.
- Tested in a scratch project: `engine-probe` returned `impeccable-engine 0.1.17`. `context` returned its directives. `detect` flagged `gradient-text` on a planted heading. `hooks on` wrote only `.impeccable/config.json` and `.impeccable/config.local.json`, and `hooks reset` removed both.
- Not tested: `live`, `generate`, image generation and the subagent flows.
- Installed size is 2.2 MB, with a 1.1 MB font index and a 550 KB browser script. Always-on cost is about 2,200 tokens. One invocation costs about 5,900 tokens.
- Maintenance risk: upstream releases a new engine every few days. An old pin works only while its engine release stays published.

## Rejected

Reviewed in full and left out. Each one was installed, read, and where possible run.

| Repo | Reason |
| --- | --- |
| [charlie947/motion-graphics-skills](https://github.com/charlie947/motion-graphics-skills) | 11 of 15 skills are paste-this-prompt templates with no technique. Newsletter promo and model pinning inside the skills. The 4 useful skills cannot be installed alone: a marketplace `skills` list adds to the default scan, it does not replace it. |
| [howseen-ai/claude-motion-design](https://github.com/howseen-ai/claude-motion-design) | Best render engineering of the batch, but it is a personal lab notebook. Step 0 reads a file on the author's desktop. Eight referenced engine files are not in the repo. Hard-coded URLs and output paths. |
| [nateherkai/hyperframes-student-kit](https://github.com/nateherkai/hyperframes-student-kit) | About 413 MB of video committed to git. Five vendored copies of official HyperFrames skills, stale by hundreds of lines, with names that collide with the official plugin. Default transcription is ElevenLabs only. `cut-mistakes` is the one unique skill. |
| [whaleyxbt/claude-motion](https://github.com/whaleyxbt/claude-motion) | The sound engine and beat-sheet loop are real and measured. But the skills only work with the cloned repo as the working directory, and a plugin install pulls 293 MB of `node_modules`. Worth revisiting if upstream makes the skills path-independent. |
| [haidrrrry/claude-remotion-skill](https://github.com/haidrrrry/claude-remotion-skill) | Generic rules Claude already applies. Stale against the current Remotion API. Everything in it is covered by `remotion-skills`. |
| [199-biotechnologies/motion-dev-animations-skill](https://github.com/199-biotechnologies/motion-dev-animations-skill) | Framer Motion basics Claude already knows. Eight referenced files do not exist. Ships its own deployment diary and a `SKILL.md.backup`. |
| [zubair-trabzada/geo-seo-claude](https://github.com/zubair-trabzada/geo-seo-claude) | Wrong on the facts that matter. Says GPTBot governs ChatGPT Search when OAI-SearchBot does. Lists a crawler Anthropic does not document. Calls FAQPage still restricted. A quarter of the words are an agency CRM. Its llms.txt generator emitted garbled text and a fabricated contact address. |
| [TheCraigHewitt/seomachine](https://github.com/TheCraigHewitt/seomachine) | A content-ops workspace, not a skill pack. Every script hard-requires DataForSEO. Five agents hardcode one client name. 20 of 25 skills are CRO and ads. |
| [Ryze-AI-Adgent/open-seo-mcp-skills](https://github.com/Ryze-AI-Adgent/open-seo-mcp-skills) | 7 of 8 skills are dead without a hosted MCP server and account at get-ryze.ai. A product onboarding funnel in SKILL.md form. |
| [irinabuht12-oss/marketing-skills](https://github.com/irinabuht12-oss/marketing-skills) | No LICENSE file. 41 of 49 skills are ads. GEO skills are 350 words each, half product copy, zero scripts. Content shipped three times in the repo. |
| coreyhaines31/marketingskills, the other 46 skills | Generalist marketing pack. CRO, ads, email, pricing, churn. Out of scope. The three kept skills are listed above. |
| kostja94/marketing-skills, the other 163 skills | 172 skills nested four levels deep, invisible to a plugin loader. Internal-links skill is 496 words with no method. Only the technical subtree is kept. |
| [motiondivision/motion](https://github.com/motiondivision/motion) | A library, not a skill. Its skill folders are for contributors to the library. |
| [remotion-dev/remotion](https://github.com/remotion-dev/remotion) | A library, not a skill. Use `remotion-skills` for the agent guidance. |
| mattpocock/skills, the other 23 skills | 7 skills need `/setup-matt-pocock-skills` and an issue tracker, and together they are a workflow system that competes with GSD and superpowers. `tdd`, `writing-for-agents` and `domain-modeling` are good but overlap skills already installed. `grill-me` and `grill-with-docs` are one-line wrappers. The `misc/` git guardrail misses `git -C <dir> push` and `gh pr merge`. `in-progress/` is beta. |

## Add a skill

1. Install the candidate from its repo and read every `SKILL.md`. Run its scripts.
2. Score it on substance, actionability, restraint, maintenance risk and overlap with what is already here.
3. Add one entry to `.claude-plugin/marketplace.json`. Set `source.sha` to the current upstream HEAD. Use a `skills` array when the `SKILL.md` files are not under `skills/` or at the repo root. Use `git-subdir` when the plugin is a subfolder.
4. Run `claude plugin validate .`.
5. Add a row to this README, in the catalog or in the rejected table.

## Refresh pins

`scripts/update-pins.sh` reads every entry, fetches the upstream HEAD for its `ref`, and rewrites `sha`.
It prints each change. Review the diff, then commit.

```bash
scripts/update-pins.sh
```

Users get the new version with `claude plugin marketplace update skills-agents` followed by `claude plugin update <name>@skills-agents`.
