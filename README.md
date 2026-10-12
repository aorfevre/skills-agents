# skills-agents

A Claude Code plugin marketplace. It lists curated skills from other GitHub repos.
No skill files are copied here. Each entry points at its upstream repo and is pinned to a commit.

## Use in a project

Register the marketplace once per machine, or per project with `--scope project`:

```bash
claude plugin marketplace add aorfevre/skills-agents
```

Install a plugin by name:

```bash
claude plugin install gsap-skills@skills-agents
claude plugin install hyperframes@skills-agents
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

### Ship a launch video

| Plugin | Upstream | License |
| --- | --- | --- |
| `product-launch-motion` | [AbubakrChan/product-launch-motion](https://github.com/AbubakrChan/product-launch-motion) | MIT |
| `motion-graphics-skills` | [charlie947/motion-graphics-skills](https://github.com/charlie947/motion-graphics-skills) | MIT |
| `motion-design-howseen` | [howseen-ai/claude-motion-design](https://github.com/howseen-ai/claude-motion-design) | MIT |

### Edit your own footage

| Plugin | Upstream | License |
| --- | --- | --- |
| `hyperframes-student-kit` | [nateherkai/hyperframes-student-kit](https://github.com/nateherkai/hyperframes-student-kit) | MIT |
| `motion-broll` | [Barty-Bart/motion-graphics](https://github.com/Barty-Bart/motion-graphics) | MIT |

### Make animated shorts

| Plugin | Upstream | License |
| --- | --- | --- |
| `animate` | [cth9191/animate](https://github.com/cth9191/animate) | MIT |
| `motion-toolkit` | [whaleyxbt/claude-motion](https://github.com/whaleyxbt/claude-motion) | MIT |
| `remotion-motion-graphics` | [haidrrrry/claude-remotion-skill](https://github.com/haidrrrry/claude-remotion-skill) | MIT |

### Animate your site

| Plugin | Upstream | License |
| --- | --- | --- |
| `motion-dev-animations` | [199-biotechnologies/motion-dev-animations-skill](https://github.com/199-biotechnologies/motion-dev-animations-skill) | MIT |

### Official building blocks

| Plugin | Upstream | License |
| --- | --- | --- |
| `hyperframes` | [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) | Apache-2.0 |
| `remotion-skills` | [remotion-dev/skills](https://github.com/remotion-dev/skills) | none declared |
| `gsap-skills` | [greensock/gsap-skills](https://github.com/greensock/gsap-skills) | MIT |
| `motion-design-principles` | [LottieFiles/motion-design-skill](https://github.com/LottieFiles/motion-design-skill) | MIT |

### Libraries, not skills

These repos are animation libraries. Their skill folders are for contributors to the library. Install the library with npm instead.

- [motiondivision/motion](https://github.com/motiondivision/motion): Motion for React, Vue and plain JS. The `motion-dev-animations` plugin above teaches Claude to use it.
- [remotion-dev/remotion](https://github.com/remotion-dev/remotion): Remotion itself. The `remotion-skills` plugin above is its official skill set.

## Add a skill

1. Find the upstream repo and the path of its `SKILL.md` files.
2. Add one entry to `.claude-plugin/marketplace.json`. Set `source.sha` to the current upstream HEAD.
3. If the skills are not under `skills/` or at the repo root, add a `skills` array that names the directory.
4. Run `claude plugin validate .`.
5. Add a row to this README.

## Refresh pins

`scripts/update-pins.sh` reads every entry, fetches the upstream HEAD for its `ref`, and rewrites `sha`.
It prints each change. Review the diff, then commit.

```bash
scripts/update-pins.sh
```

Users get the new version when they run `claude plugin marketplace update skills-agents` and then `claude plugin update <name>@skills-agents`.
