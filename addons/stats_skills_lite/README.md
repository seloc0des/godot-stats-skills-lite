# Stats / Skills — Lite

**FREE.** Stat aggregator + modifier pipeline for Godot 4.5+. Pure GDScript. MIT.

The working core of the [selodev Stats / Skill Trees addon](docs/upgrade.md). Define stats. Add modifiers. Read totals. Same math, same modifier shape as the Pro tier — only the skill-tree runtime and the editor-grade UIs are missing.

## 5-minute install

1. Copy `addons/stats_skills_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Stats / Skills — Lite**.
3. Add a `StatsComponentLite` Node to your player.
4. Author `StatDefinitionLite` Resources and set them on `definitions`.

```gdscript
@onready var stats: StatsComponentLite = $StatsComponentLite

# Read.
stats.get_stat("damage")
stats.get_base("damage")
stats.get_breakdown("damage")    # {base, flat, percent_add, percent_mult, raw, final}

# Write.
stats.set_base("damage", 8.0)
stats.add_modifier({"stat": "damage", "op": "flat", "amount": 5.0, "source_id": "item:sword"})
stats.add_modifier({"stat": "damage", "op": "percent_add", "amount": 25.0, "source_id": "buff:rage"})
stats.add_modifier({"stat": "damage", "op": "percent_mult", "amount": 10.0, "source_id": "tier:berserk"})
stats.remove_modifier("buff:rage")   # removes that one
stats.clear_modifiers()              # nukes all
```

The aggregation formula: `(base + Σ flat) × (1 + Σ percent_add / 100) × Π (1 + percent_mult / 100)`, clamped to `[min, max]`.

## What's missing (and why)

| Feature | Tier |
|---|---|
| Visual skill tree (`SkillNode` + `SkillTree` + `SkillTreeComponent`) | Pro |
| `SkillTreeUI` Control with click-to-unlock | Pro |
| `StatsPanelUI` Control with breakdown tooltips | Pro |
| Auto-subscribe to the Equipment addon's modifier bus | Pro |
| Timed buffs with auto-expiry | Pro |
| Atomic `replace_modifiers(source_id, mods)` swap | Pro |
| Save-contract auto-join | Pro |
| Shared `Events` autoload | Pro |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


---

## Part of a family

The free Lite tier of one system in a set of Godot 4 RPG systems built to
interoperate (shared item + save contracts) — each also works fully standalone.

**Free tiers — try before you buy:**

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite) — item slots, stack merging, capacity
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite) — 4-slot gear manager
- [Save/Load Lite](https://github.com/seloc0des/godot-save-load-lite) — single-slot JSON persistence
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite) — shapeless instant recipes
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite) — COLLECT + KILL quests
- [Stats/Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite) — stat aggregator
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite) — single fixed-currency shop
- [Settings + Menu System](https://github.com/seloc0des/godot-settings-menus) — complete, free, no paid tier

**Full versions** — drop-in UI, weight/categories, timed crafting, restock & currencies,
save-aware cross-system integration, and more — are on itch.io:
**https://selodev.itch.io**
