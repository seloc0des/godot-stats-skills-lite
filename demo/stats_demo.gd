extends Node

const StatsComponentLiteScript := preload("res://addons/stats_skills_lite/stats_component_lite.gd")
const StatDefinitionLiteScript := preload("res://addons/stats_skills_lite/stat_definition_lite.gd")

var _stats: StatsComponentLite
var _list: VBoxContainer


func _ready() -> void:
	var bg := ColorRect.new()
	bg.color = Color(0.10, 0.12, 0.16)
	bg.anchor_right = 1; bg.anchor_bottom = 1
	add_child(bg)

	_stats = StatsComponentLiteScript.new()
	_stats.definitions = [
		_def("strength",    "Strength",     10.0, "%.0f"),
		_def("damage",      "Damage",        5.0, "%.1f"),
		_def("max_health",  "Max Health",  100.0, "%.0f"),
		_def("move_speed",  "Move Speed",  100.0, "%.0f%%"),
		_def("crit_chance", "Crit Chance",   5.0, "%.1f%%"),
	]
	add_child(_stats)
	_stats.stat_changed.connect(_refresh.unbind(2))

	var layer := CanvasLayer.new()
	add_child(layer)

	var title := Label.new()
	title.text = "Stats / Skills — Lite — Demo"
	title.position = Vector2(16, 12)
	title.add_theme_font_size_override("font_size", 16)
	layer.add_child(title)

	# Buttons (left).
	var btns := VBoxContainer.new()
	btns.position = Vector2(16, 48)
	btns.add_theme_constant_override("separation", 4)
	layer.add_child(btns)
	_add_btn(btns, "+5 Strength (item:sword)", func():
		_stats.add_modifier({"stat": "strength", "op": "flat", "amount": 5, "source_id": "item:sword"}))
	_add_btn(btns, "Remove item:sword", func():
		_stats.remove_modifier("item:sword"))
	_add_btn(btns, "+10 Damage (item:axe)", func():
		_stats.add_modifier({"stat": "damage", "op": "flat", "amount": 10, "source_id": "item:axe"}))
	_add_btn(btns, "+25%% Damage additive (buff:rage)", func():
		_stats.add_modifier({"stat": "damage", "op": "percent_add", "amount": 25, "source_id": "buff:rage"}))
	_add_btn(btns, "+10%% Damage multiplicative (tier:berserk)", func():
		_stats.add_modifier({"stat": "damage", "op": "percent_mult", "amount": 10, "source_id": "tier:berserk"}))
	_add_btn(btns, "Remove buff:rage", func():
		_stats.remove_modifier("buff:rage"))
	_add_btn(btns, "+50 Max Health override", func():
		_stats.set_base("max_health", 150))
	_add_btn(btns, "Reset Max Health base", func():
		_stats.set_base("max_health", 100))
	_add_btn(btns, "Clear ALL modifiers", func():
		_stats.clear_modifiers())

	# Stats panel (right).
	var panel := PanelContainer.new()
	panel.position = Vector2(360, 48)
	panel.custom_minimum_size = Vector2(520, 440)
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.04, 0.05, 0.07)
	sb.border_color = Color(0.20, 0.22, 0.28)
	sb.set_border_width_all(1); sb.set_corner_radius_all(4)
	sb.content_margin_left = 12; sb.content_margin_right = 12
	sb.content_margin_top = 12; sb.content_margin_bottom = 12
	panel.add_theme_stylebox_override("panel", sb)
	layer.add_child(panel)
	_list = VBoxContainer.new()
	_list.add_theme_constant_override("separation", 6)
	panel.add_child(_list)

	_refresh()


func _def(id_: String, display: String, base: float, fmt: String) -> StatDefinitionLite:
	var d := StatDefinitionLiteScript.new()
	d.id = id_; d.display_name = display; d.base_value = base; d.format_template = fmt
	d.min_value = 0.0; d.max_value = 1.0e5
	return d


func _add_btn(parent: Container, text: String, cb: Callable) -> void:
	var b := Button.new()
	b.text = text
	b.pressed.connect(cb)
	parent.add_child(b)


func _refresh() -> void:
	for c in _list.get_children():
		c.queue_free()
	for d in _stats.definitions:
		var bd := _stats.get_breakdown(String(d.id))
		var row := VBoxContainer.new()
		row.add_theme_constant_override("separation", 1)
		_list.add_child(row)
		var name_row := HBoxContainer.new()
		row.add_child(name_row)
		var name_label := Label.new()
		name_label.text = String(d.display_name)
		name_label.add_theme_font_size_override("font_size", 14)
		name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		name_row.add_child(name_label)
		var val_label := Label.new()
		val_label.text = d.format_value(float(bd.final))
		val_label.add_theme_font_size_override("font_size", 14)
		name_row.add_child(val_label)
		var breakdown := Label.new()
		breakdown.text = "    base %s · flat +%.0f · +%.0f%% · ×%.2f" % [
			d.format_value(float(bd.base)),
			float(bd.flat),
			float(bd.percent_add),
			float(bd.percent_mult),
		]
		breakdown.add_theme_font_size_override("font_size", 11)
		breakdown.modulate = Color(1, 1, 1, 0.55)
		row.add_child(breakdown)
