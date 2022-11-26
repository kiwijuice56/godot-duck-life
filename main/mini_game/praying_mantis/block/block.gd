class_name Block
extends Sprite2D

@export var width := 128
@export var speed := 64
@export var colors: Array[Texture]

var desired_x := 0
var letter: String

func _ready() -> void:
	var x: int = randi() % 4
	letter = "SDJK".substr(x, 1)
	$RigidBody2D/Sprite2D.texture = colors[x]
	if randf() < 0.92:
		$Coin.queue_free()

func _process(delta) -> void:
	if position.x > desired_x:
		position.x -= delta * speed
	position.x = max(position.x, desired_x)

func break_self() -> void:
	$CPUParticles2D.emitting = true
	$AudioStreamPlayer.pitch_scale = randf_range(0.8,1.2)
	$AudioStreamPlayer.play()
	$RigidBody2D.exploded = true
	var tween := get_tree().create_tween()
	# just need a timer :() this was a remnant of a label being hidden
	tween.tween_property(self, "modulate:a", 1.0, 1.3)
	await tween.finished
	queue_free()

func update_position() -> void:
	desired_x -= width
