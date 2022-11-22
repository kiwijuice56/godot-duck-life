class_name EnergyDeco
extends Area2D

@export var attract_accel := 0.95
@export var attract_strength := 6.5

var duck: HomeDuck
var velocity: Vector2

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _physics_process(delta) -> void:
	if not is_instance_valid(duck):
		return
	var distance := duck.global_position - global_position
	velocity += attract_accel * distance.normalized() * attract_strength
	
	global_position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	if area == duck:
		velocity *= 0.1
		GlobalInfo.duck_info.health += 1
		GlobalInfo.update_duck_info()
		duck.grow()
		$AnimationPlayer.play("eat")
		await $AnimationPlayer.animation_finished
		queue_free()
