class_name Home
extends Node

@export var ui: HomeUI

@export var energy_deco: PackedScene
@export var energy_spawn_marker: Marker2D

@export var satanic_panic: PackedScene
@export var praying_mantis: PackedScene
@export var conquest: PackedScene

var duck: HomeDuck

func _ready() -> void:
	ui.energy_bought.connect(_on_energy_bought)
	ui.satanic_panic_started.connect(_on_satanic_panic_started)
	ui.praying_mantis_started.connect(_on_praying_mantis_started)
	ui.conquest_started.connect(_on_conquest_started)
	duck = $Duck

func _on_energy_bought() -> void:
	$Buy.pitch_scale = randf_range(.9, 1.1)
	$Buy.play()
	var new_deco: EnergyDeco = energy_deco.instantiate()
	add_child(new_deco)
	new_deco.global_position = energy_spawn_marker.global_position
	new_deco.duck = duck

func _on_satanic_panic_started() -> void:
	$MusicPlayer.stop()
	await Transition.trans_in()
	var game: SatanicPanic = satanic_panic.instantiate()
	get_parent().add_child(game)
	get_parent().move_child(game, get_parent().get_child_count() - 1)
	await Transition.trans_out()
	await game.finished
	await Transition.trans_in()
	game.queue_free()
	await Transition.trans_out()
	$MusicPlayer.play()

func _on_praying_mantis_started() -> void:
	$MusicPlayer.stop()
	await Transition.trans_in()
	var game: PrayingMantis = praying_mantis.instantiate()
	get_parent().add_child(game)
	get_parent().move_child(game, get_parent().get_child_count() - 1)
	await Transition.trans_out()
	await game.finished
	await Transition.trans_in()
	game.queue_free()
	await Transition.trans_out()
	$MusicPlayer.play()

func _on_conquest_started() -> void:
	$MusicPlayer.stop()
	await Transition.trans_in()
	var game: Conquest = conquest.instantiate()
	get_parent().add_child(game)
	get_parent().move_child(game, get_parent().get_child_count() - 1)
	await Transition.trans_out()
	await game.finished
	await Transition.trans_in()
	game.queue_free()
	await Transition.trans_out()
	$MusicPlayer.play()
