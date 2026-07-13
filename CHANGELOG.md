# Changelog

## 1.0.0 — 2026-06-01

Initial release.

- `StatDefinitionLite` Resource — id, display_name, base_value, min/max, format_template.
- `StatsComponentLite` Node — definitions Array, `get_stat`, `get_base`, `set_base`, `get_breakdown`, `add_modifier`, `remove_modifier`, `clear_modifiers`, `snapshot`/`restore`.
- Modifier shape: `{stat, op, amount, source_id?}`. Ops: `flat`, `percent_add`, `percent_mult` — same as Pro.
- Same aggregation formula: `(base + Σ flat) × (1 + Σ percent_add / 100) × Π (1 + percent_mult / 100)`.
- Signals: `stat_changed`, `modifier_added`, `modifier_removed`.
- Demo: 5 stats, buttons for flat / additive% / multiplicative% modifiers + base override + clear, live breakdown panel.
