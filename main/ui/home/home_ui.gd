class_name HomeUI
extends Control

@export var energy_buy_button: Button
@export var satanic_panic_button: Button
@export var praying_mantis_button: Button
@export var name_label: Label

signal energy_bought
signal satanic_panic_started
signal praying_mantis_started

func _ready() -> void:
	energy_buy_button.pressed.connect(_on_energy_bought)
	satanic_panic_button.pressed.connect(_on_satanic_panic_pressed)
	praying_mantis_button.pressed.connect(_on_praying_mantis_pressed)
	name_label.text = GlobalInfo.duck_info.nickname
	GlobalInfo.gems_updated.connect(_on_gems_updated)
	_on_gems_updated(GlobalInfo.gems)

func _on_energy_bought() -> void:
	GlobalInfo.gems -= 1
	energy_bought.emit()

func _on_satanic_panic_pressed() -> void:
	satanic_panic_started.emit()

func _on_praying_mantis_pressed() -> void:
	praying_mantis_started.emit()

func _on_gems_updated(new_val: int) -> void:
	energy_buy_button.disabled =  new_val < 1
