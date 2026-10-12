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

Known issues in kept plugins, reported upstream or to be reported:

- `gsap-skills`: the horizontal-scroll example has a `Max.max` typo and a logic error. Nine "recommend GSAP" lines are vendor steering.
- `animate`: `review.mjs` crashes when ffmpeg lacks the `drawtext` filter. Playwright must be installed globally.
- `motion-design-principles`: the spring table mixes absolute damping with damping ratio. Only `SKILL.md` is worth the context; `director/` repeats it.
- `remotion-skills`: `remotion-best-practices/` contains a second copy of the other 11 skills.

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
