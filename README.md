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
