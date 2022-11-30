class_name FireBall
extends Attack

@export var power := 1
@export var speed := 64.0
var dir := Vector2(1, 0)

func _ready() -> void:
	power += 1 # no powers of 0
	$Sprite2D.scale = Vector2(0.20, 0.20) * (1 + power / (255.0 / 2.0))
	$CPUParticles2D.amount = int(16 * (1 + power / (255.0 / 6.0)))
	$CPUParticles2D2.amount = 2 * int(16 * (1 + power / (255.0 / 6.0)))
	damage = 1 + int(power / 14)
	speed *= 1 + power / 255
	
	$Timer.start(.3 + power / 80)
	$Timer.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	speed /= 4
	$AnimationPlayer.play("destroy")
	await $AnimationPlayer.animation_finished
	queue_free()

func _physics_process(delta) -> void:
	speed -= delta * 256
	if speed < 32:
		speed = 0
	global_position += dir * speed * delta
