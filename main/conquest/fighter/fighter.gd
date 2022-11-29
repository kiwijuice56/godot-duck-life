class_name Fighter
extends Node

@onready var state_machine: StateMachine = $StateMachine

# Same as duck stats, to be applied to a fighter
@export var health := 10
@export var strength := 10
@export var agility := 10
@export var magic := 10

func _ready() -> void:
	$Hitbox.area_entered.connect(_on_hitbox_entered)

func _on_hitbox_entered(area: Area2D) -> void:
	pass

func _physics_process(delta: float) -> void:
	state_machine.physics_step(delta)
