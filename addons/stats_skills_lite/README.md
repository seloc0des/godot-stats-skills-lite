# Stats / Skills (Lite)

**FREE.** Stat aggregator + modifier pipeline for Godot 4.5+, with a stats list and stat pickups you set up in the editor. Pure GDScript. MIT.

The working core of the [selodev Stats / Skill Trees addon](docs/upgrade.md). Define stats. Add modifiers. Read totals. Same math, same modifier shape as the Pro tier. The skill-tree runtime and the styled UIs are Pro.

> **New in v1.1: no-code dock.** Enable the plugin and an authoring panel appears: create, edit, duplicate, and delete your stat definitions in a UI, no `.tres` editing. (The Pro tier adds three docks, including a skill tree editor.)

## One-click setup (no code)

Enable the plugin and a **Stats · Setup** tab appears in the editor. Pick an outcome, choose where it goes, and press **Apply**:

- **Player stats (health, attack, defense).** Adds a stats component to the node and marks it as the player, the group touch triggers and enemies look for. It also adds a plain stats list on the left of the screen, under the HUD strip, and a `character` input action on **C**. The list starts hidden: press C in the game to open and close it. It shows each stat's current value and updates when a value changes. A long list scrolls.
- **Enemy stats (health, attack)** and **Empty stats component** add a stats component with those starter stats, or none.
- **Boost a stat when the player touches this.** Pick the stat (the list comes from your player's own stats), an amount, and how many seconds it lasts (0 keeps it for good). Select the pickup, a potion or a shrine, and Apply. When the player walks into it, the stat goes up, a message such as "+5 Attack" shows at the top of the screen, and the pickup disappears. Tick **Stay** on its `StatPickup` node in the Inspector to keep it in the scene. A node that isn't an Area with a collision shape gets a `PickupArea` around it.

Boosts only react to the node in the `player` group. If nothing in your scene is marked yet, Apply says so: select your player and press **Make the selected node the player**. Re-pick and Apply again to change anything: it updates the same nodes.

## 5-minute install

1. Copy `addons/stats_skills_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Stats / Skills (Lite)**.
3. Use the **Stats · Setup** tab above. Tune the stats on the component's **Definitions** in the Inspector, or author your own in the **Stats (Lite)** tab: **New** makes `new_stat.tres` with a name and an id, and opens it in the Inspector.

### From code (optional)

```gdscript
@onready var stats: StatsComponentLite = $StatsLite  # the node "Player stats" adds

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
| Timed buffs on any modifier (`duration_seconds`); Lite's stat pickups time their own boosts | Pro |
| Atomic `replace_modifiers(source_id, mods)` swap | Pro |
| Save-contract auto-join | Pro |
| Shared `Events` autoload | Pro |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


## Part of a family

This is one free tier from the selodev catalog of no-code Godot 4 systems. They share an item contract and a save contract, so they plug into each other, and each one also works fully on its own.

Free systems:

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite)
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite)
- [Loot Lite](https://github.com/seloc0des/godot-loot-lite)
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite)
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite)
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite)
- [Stats / Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite)
- [Save / Load Lite](https://github.com/seloc0des/godot-save-load-lite)
- [Dialogue Lite](https://github.com/seloc0des/godot-dialogue-lite)
- [Combat Lite](https://github.com/seloc0des/godot-combat-lite)
- [Controller Lite](https://github.com/seloc0des/godot-controller-lite)
- [Enemy AI Lite](https://github.com/seloc0des/godot-enemy-ai-lite)
- [Scene Flow Lite](https://github.com/seloc0des/godot-scene-flow-lite)
- [Audio Lite](https://github.com/seloc0des/godot-audio-lite)
- [Level Builder Lite](https://github.com/seloc0des/godot-level-builder-lite)
- [Weather System Lite](https://github.com/seloc0des/godot-weather-lite)
- [Settings + Menus](https://github.com/seloc0des/godot-settings-menus) (complete and free, no paid tier)

Free VFX: [Magic Cast](https://github.com/seloc0des/godot-magic-cast-vfx-lite), [Elemental Impact](https://github.com/seloc0des/godot-elemental-impact-vfx-lite), [Explosion](https://github.com/seloc0des/godot-explosion-vfx-lite), [Pickup, Buff & Heal](https://github.com/seloc0des/godot-pickup-buff-vfx-lite).

Free starter projects: [Free Starter](https://github.com/seloc0des/free-starter-godot), [Dungeon](https://github.com/seloc0des/godot-dungeon-starter), [Survival](https://github.com/seloc0des/godot-survival-starter), [RPG](https://github.com/seloc0des/godot-rpg-starter).

The full versions add drop-in UI, editor docks and the cross-system wiring. They're on itch.io: **https://selodev.itch.io**
