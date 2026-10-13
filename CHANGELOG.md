# Changelog

## 1.4.3 (2026-10-12)

The tabs show their names on Godot 4.5.

- **The Stats · Setup and Stats (Lite) tabs were blank on Godot 4.5.** Their tabs beside the
  Inspector had no title, so "open the Stats · Setup tab" pointed at nothing. They are named when
  the pack switches on now. Godot 4.7 was not affected.

## 1.4.2 (2026-09-28)

Lists that stay readable at any editor scale.

- **The Stats (Lite) list always shows about five rows**, at any editor scale. At 125% it came out a
  few rows tall. The divider under it still drags.
- **A file the tab makes is registered with Godot as soon as it's written**, so pressing Play
  straight away can't warn "invalid UID".

## 1.4.1 (2026-09-27)

Both tabs fit a default dock.

- **The Setup and authoring tabs fit a default dock.** A tab taller than the dock scrolls, and lists
  show what you just made the next time they open.

## 1.4.0 (2026-09-27)

Stats you can use without writing code.

- **Stats with no code.** A stats list opens with C, and "Boost a stat when the player touches this"
  adds a boost, the stat picked from a list, for good or for a few seconds, with a short message on
  screen.
- **Enemy stats applied on the scene root no longer overwrite the player's.**
- **Pressing Apply twice in a row no longer marks the stats component as the player.**
- **The Stats (Lite) tab shows its fields in the editor.** It was empty there.
- **New in the tab names the stat** and opens it in the Inspector, and Inspector edits survive the
  tab's Save.
- **"Player stats" marks the node as the player**, so the other packs' touch triggers react to it.
- **Pressing Play right after Apply includes what it added.** The Setup tab never marked the scene
  as changed, so Play ran the saved version without it.
- **Saving in the Stats tab keeps your scenes linked to the file** instead of leaving them an
  orphaned copy that the scene then saved inside itself.
- **Nodes the Setup tab adds get readable names.** A second one under the same parent is
  called something like `UILayer2`, instead of a generated name full of `@` signs.
- **Long status messages in the authoring tab wrap** instead of running off the edge of the dock.

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
