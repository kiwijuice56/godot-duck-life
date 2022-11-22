class_name MiniGameUI
extends Control

@export var start_button: Button
@export var end_button: Button
@export var help_screen: PanelContainer
@export var game_over_screen: PanelContainer
@export var game_over_label: Label
@export var score_label: Label

signal started

func _ready() -> void:
	help_screen.modulate.a = 1.0
	start_button.pressed.connect(_on_start_pressed)

func _on_start_pressed() -> void:
	start_button.disabled = true
	var tween := get_tree().create_tween()
	tween.tween_property(help_screen, "modulate:a", 0, 0.2)
	await tween.finished
	started.emit()

func game_over() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(game_over_screen, "modulate:a", 1.0, 0.2)
	game_over_screen.visible = true
	await tween.finished
	await end_button.pressed
	tween = get_tree().create_tween()
	tween.tween_property(help_screen, "modulate:a", 0, 0.2)
	await tween.finished
