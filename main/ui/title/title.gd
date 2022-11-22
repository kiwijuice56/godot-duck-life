class_name TitleUI
extends Control

@export var start_button: Button
@export var restart_button: Button

func _ready() -> void:
	if GlobalInfo.duck_is_new:
		start_button.text = "Start"
		restart_button.visible = false
	else:
		start_button.text = "Continue"
		restart_button.visible = true
