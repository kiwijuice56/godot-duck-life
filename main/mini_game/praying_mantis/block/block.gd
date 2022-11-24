class_name Block
extends Sprite2D

@export var width := 128
@export var speed := 64
@export var colors: Array[Color]

var desired_x := 0
var letter: String

func _ready() -> void:
	var x: int = randi() % 4
	letter = "SDJK".substr(x, 1)
	$Label.text = letter
	$RigidBody2D/Sprite2D.modulate = colors[x]
	child_entered_tree.connect(_on_child_entered_tree)

func _on_child_entered_tree(child) -> void:
	if child != $Label:
		move_child($Label, get_child_count() - 1)

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
	tween.tween_property($Label, "modulate:a", 0, 1.5)
	await tween.finished
	queue_free()

func update_position() -> void:
	desired_x -= width
