# Upgrade to Stats / Skill Trees (Pro)

## What Pro adds

- **Visual skill tree.** `SkillTree` Resource of `SkillNode`s with positions, prereqs, costs, granted modifiers. `SkillTreeComponent` runtime with `unlock` / `refund` / `respec`. The headline feature.
- **`SkillTreeUI` Control.** Positioned node buttons, connection lines, themed by `SkillTreeTheme`. Click to unlock, right-click to refund. Tooltips per node.
- **`StatsPanelUI` Control.** Reactive list of stats with full breakdown tooltips and category grouping.
- **Equipment auto-bridge.** Set `equipment_paths` and the Stats component auto-subscribes to the Equipment addon's modifier bus. Item modifiers flow into the same pipeline as skills + buffs.
- **Timed buffs.** `duration_seconds > 0` on a modifier — auto-removes when expired.
- **Atomic replace.** `replace_modifiers(source_id, mods)` — swap a skill's grants for a higher-rank version in one pass, no transient flicker.
- **Save-contract auto-join.** Stats + skill tree state both persist through the Save addon.
- **Shared `Events` autoload.** `stat_changed`, `modifier_added/removed`, `skill_node_unlocked/refunded`, `skill_points_changed` flow on the shared bus.

## Moving from Lite

The full version installs next to the Lite, in its own folder, and both run in the same project, so you can move over one piece at a time. It isn't a drop-in replacement: the class names differ, and so do some method names.

`StatsComponentLite` becomes `StatsComponent`. `add_modifier`, `remove_modifier`, `clear_modifiers`, `get_stat`, `get_base`, `set_base` and `get_breakdown` keep their names, and both versions use the same formula, so the numbers come out the same. `snapshot()`, `restore()` and `find()` don't exist in the full version. Your `StatDefinitionLite.tres` files stay Lite resources, so re-create them as the full `StatDefinition`. All six fields have the same names.

## Where to buy

The full version is on itch.io: **https://selodev.itch.io**.

## License

MIT.
