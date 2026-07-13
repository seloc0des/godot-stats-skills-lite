# Quick Start

## Define stats

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

## Drop a component

```gdscript
@onready var stats: StatsComponentLite = $StatsComponentLite

func _ready() -> void:
    stats.definitions = [strength_def, damage_def, max_health_def, ...]
```

## Read

```gdscript
stats.get_stat("damage")            # final value, clamped
stats.get_base("damage")            # base, ignoring modifiers
stats.get_breakdown("damage")       # {base, flat, percent_add, percent_mult, raw, final}
```

## Write

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

## Save / load

The Lite tier doesn't auto-save. Persist via `snapshot()` / `restore(data)`:

```gdscript
func save_state() -> Dictionary:
    return {"stats": stats.snapshot()}

func load_state(data: Dictionary) -> void:
    stats.restore(data.get("stats", {}))
```
