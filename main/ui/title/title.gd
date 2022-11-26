class_name TitleUI
extends Control

@export var start_button: Button
@export var restart_button: Button
@export var input_panel: PanelContainer
@export var confirm_button: Button
@export var name_entry: TextEdit
@export var icon: TextureRect
@export var hue: HSlider
@export var bright: HSlider

signal started

func _ready() -> void:
	if GlobalInfo.duck_is_new:
		start_button.text = "Start"
		restart_button.visible = false
	else:
		start_button.text = "Continue"
		restart_button.visible = true
	start_button.pressed.connect(_on_started)
	hue.value_changed.connect(_on_hue_changed)
	bright.value_changed.connect(_on_bright_changed)

func _on_hue_changed(x: float) -> void:
	icon.material.set_shader_parameter("shift", x)
	GlobalInfo.duck_info.hue = x

func _on_bright_changed(x: float) -> void:
	icon.material.set_shader_parameter("light", x)
	GlobalInfo.duck_info.brightness = x

func _on_started() -> void:
	
	start_button.disabled = true
	if GlobalInfo.duck_is_new:
		$InputContainer.visible = true
		var tween := get_tree().create_tween()
		tween.tween_property(input_panel, "modulate:a", 1.0, 0.2)
		await tween.finished
		while len(name_entry.text) == 0:
			await confirm_button.pressed
		GlobalInfo.duck_info.nickname = name_entry.text
		tween = get_tree().create_tween()
		tween.tween_property(input_panel, "modulate:a", 1.0, 0.2)
		await tween.finished
		$InputContainer.visible = false
	started.emit()
