# Quick Start

## Give your player stats (no code)

Enable the plugin and open the **Stats · Setup** tab.

1. Select your player in the scene.
2. Pick **Player stats (health, attack, defense)** and press **Apply**.

That adds a stats component named `StatsLite` to the player and marks it as the player (the `player` group that touch triggers and enemies look for). It also adds a `StatsList` on a `UILayer`: a plain list on the left of the screen, under the HUD strip, showing each stat and its current value. It starts hidden. The tab adds a `character` input action on **C** (unless your project already has one), and C opens and closes the list in the game. The list updates when a value changes, and a long list scrolls.

Tune the starter stats on the component's **Definitions** in the Inspector, or author your own in the **Stats (Lite)** tab and drag them into **Definitions**. **New** in that tab makes `res://stats/new_stat.tres` (then `new_stat_2.tres`, ...) with a name and an id to start from, and opens it in the Inspector. Rename it in the tab or in the Inspector, then press **Save** in the tab: a rename made in the Inspector is kept.

## Boost a stat when the player touches something (no code)

1. Pick **Boost a stat when the player touches this**.
2. Pick the stat from the list (your player's stats, or the Player stats starter's when there's no player in this scene), an **Amount**, and **For (seconds, 0 = for good)**.
3. Select the pickup (a potion, a shrine) and press **Apply**, then Play.

When the player walks into it, the stat goes up by the amount, a message such as "+5 Attack" (or "+5 Attack for 10s") shows at the top of the screen for about two seconds, and the pickup disappears. A timed boost wears off by itself.

A node that isn't an Area with a collision shape gets a `PickupArea` around it. Boosts only react to the node in the `player` group: if nothing in the scene is marked yet, Apply says so, and **Make the selected node the player** marks the node you have selected.

The `StatPickup` node Apply adds has these in the Inspector:

| Field | Notes |
|---|---|
| **Stat Id** | The stat it boosts. The tab fills it in. |
| **Amount** | Added to the stat. A negative amount lowers it. |
| **Duration** | Seconds the boost lasts. 0 keeps it for good. |
| **Stay** | On: the pickup stays after it's used. A timed boost refreshes when touched again, and a permanent one is given once. |
| **Show Messages** | Off: no message on screen. |
| **Stats Path** | Optional. Leave it empty and it finds the player's stats. |

## From code (optional)

### Define stats

```gdscript
const StatDefinitionLite := preload("res://addons/stats_skills_lite/stat_definition_lite.gd")

var damage_def := StatDefinitionLite.new()
damage_def.id = "damage"
damage_def.display_name = "Damage"
damage_def.base_value = 5.0
damage_def.format_template = "%.1f"
damage_def.min_value = 0.0
damage_def.max_value = 9999.0
```

### Drop a component

```gdscript
@onready var stats: StatsComponentLite = $StatsLite

func _ready() -> void:
    stats.definitions = [strength_def, damage_def, max_health_def, ...]
```

### Read

```gdscript
stats.get_stat("damage")            # final value, clamped
stats.get_base("damage")            # base, ignoring modifiers
stats.get_breakdown("damage")       # {base, flat, percent_add, percent_mult, raw, final}
```

### Write

```gdscript
stats.set_base("max_health", 150.0)

stats.add_modifier({"stat": "damage", "op": "flat", "amount": 5.0, "source_id": "item:sword"})
stats.add_modifier({"stat": "damage", "op": "percent_add", "amount": 25.0, "source_id": "buff:rage"})
stats.add_modifier({"stat": "damage", "op": "percent_mult", "amount": 10.0, "source_id": "tier:berserk"})

stats.remove_modifier("buff:rage")     # removes every modifier with that source_id
stats.clear_modifiers()                # nuke everything
```

## Three operations

| Op | Effect |
|---|---|
| `flat` | Additive value. All flats sum. |
| `percent_add` | Additive %. All percents sum, then one multiplication. `+10% + +10% = ×1.20`. |
| `percent_mult` | Multiplicative %. Each is its own factor. `+10% × +10% = ×1.21`. |

Final = `(base + Σ flat) × (1 + Σ percent_add / 100) × Π (1 + percent_mult / 100)`, clamped to `[min, max]`.

## Source IDs

Use a deliberate `source_id` so you can remove the modifier later. Suggested conventions:

- Equipment: `"item:<item_id>"`
- Buffs: `"buff:<buff_id>"`
- Skills: `"skill:<node_id>"` (in Pro)
- Story: `"story:<event_id>"`

Stat pickups use ids that start with `pickup:`.

## Save / load

The Lite tier doesn't auto-save. Persist via `snapshot()` / `restore(data)`:

```gdscript
func save_state() -> Dictionary:
    return {"stats": stats.snapshot()}

func load_state(data: Dictionary) -> void:
    stats.restore(data.get("stats", {}))
```
