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

## Migration from Lite

`StatsComponentLite` and `StatsComponent` share the same modifier shape (`{stat, op, amount, source_id, duration_seconds?}`) and aggregation formula. Existing modifiers carry over. `StatDefinitionLite.tres` files are upgrade-compatible with the Pro `StatDefinition` (add `description`, `category`, `icon` if you want them; the Lite ones still work).

## Where to buy

The full version is on itch.io — **https://selodev.itch.io**. Both tiers share the
same field names and method signatures, so upgrading is a class-name swap.

## License

MIT.
