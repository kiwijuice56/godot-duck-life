class_name HomeUI
extends Control

@export var energy_buy_button: Button
@export var satanic_panic_button: Button
@export var praying_mantis_button: Button

signal energy_bought
signal satanic_panic_started
signal praying_mantis_started

func _ready() -> void:
	energy_buy_button.pressed.connect(_on_energy_bought)
	satanic_panic_button.pressed.connect(_on_satanic_panic_pressed)
	praying_mantis_button.pressed.connect(_on_praying_mantis_pressed)
	GlobalInfo.gems_updated.connect(_on_gems_updated)
	_on_gems_updated(GlobalInfo.gems)

func _on_energy_bought() -> void:
	energy_bought.emit()

func _on_satanic_panic_pressed() -> void:
	satanic_panic_started.emit()

func _on_praying_mantis_pressed() -> void:
	praying_mantis_started.emit()

func _on_gems_updated(new_val) -> void:
	if new_val < 0:
		energy_buy_button.disabled = true
