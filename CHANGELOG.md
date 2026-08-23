# Changelog

## 1.3.0 (2026-08-22)

- Engine floor moves to Godot 4.5. The project and the plugin description both
  said 4.3 before, which no longer matched the code.
- The addon and its docs now say selodev throughout. The old CindieForge name
  was still in the README and the upgrade notes after the rebrand.

## 1.2.0 — 2026-07-24

One-click no-code setup.

- New **Stats · Setup** panel (the first dock tab): pick the outcome you want → **Apply** → the Lite component is added to your scene, baked in and re-editable.
- Pro unlocks the full no-code wiring — gameplay triggers, bound UI, and cross-system hooks.

## 1.1.0 — 2026-07-24

No-code authoring dock.

- New editor dock: author `StatDefinitionLite` stat definitions through a UI panel — create, edit, duplicate, delete, no `.tres` hand-editing. (The Pro tier adds every field, one-click scene wiring, and the `EventTrigger` node.)

## 1.0.0 — 2026-06-01

Initial release.

- `StatDefinitionLite` Resource — id, display_name, base_value, min/max, format_template.
- `StatsComponentLite` Node — definitions Array, `get_stat`, `get_base`, `set_base`, `get_breakdown`, `add_modifier`, `remove_modifier`, `clear_modifiers`, `snapshot`/`restore`.
- Modifier shape: `{stat, op, amount, source_id?}`. Ops: `flat`, `percent_add`, `percent_mult` — same as Pro.
- Same aggregation formula: `(base + Σ flat) × (1 + Σ percent_add / 100) × Π (1 + percent_mult / 100)`.
- Signals: `stat_changed`, `modifier_added`, `modifier_removed`.
- Demo: 5 stats, buttons for flat / additive% / multiplicative% modifiers + base override + clear, live breakdown panel.
