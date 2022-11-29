class_name Fighter
extends CharacterBody2D

@onready var state_machine: StateMachine = $StateMachine

# Same as duck stats, to be applied to a fighter
@export var health := 10:
	set(value):
		health = value
		$HealthBar.value = health
@export var strength := 10
@export var agility := 10
@export var magic := 10

@export var fireball: PackedScene

var max_health: int

signal vision_entered(area)
signal spawn_magic

func _ready() -> void:
	max_health = health
	self.health = health # call the setter
	$HealthBar.max_value = max_health 
	
	$Directional/MainAttack.disable()
	$Hitbox.area_entered.connect(_on_hitbox_entered)
	$Vision.area_entered.connect(_on_vision_entered)

func _on_hitbox_entered(area: Area2D) -> void:
	if area is Attack:
		health -= area.damage
	if health <= 0:
		death()

func _on_vision_entered(area: Area2D) -> void:
	vision_entered.emit(area)

func _physics_process(delta: float) -> void:
	state_machine.physics_step(delta)

func death() -> void:
	queue_free()

func attack(target: Fighter, info := {}) -> void:
	# this can be anything, placeholder for other fighters
	$AnimationPlayer.play("shove")
	await $AnimationPlayer.animation_finished
	$Delay.start(1)
	await $Delay.timeout
