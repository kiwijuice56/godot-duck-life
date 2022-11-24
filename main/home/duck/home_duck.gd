class_name HomeDuck
extends Area2D
# Visual representation of the duck on the home screen

@export var max_hops: int = 3
@export var hop_length: int = 48
@export var hop_height: int = 48
@export var hop_time: float = 0.2
@export var boundary: int = 64

@export var scale_amount: float = 0.0005
@export var scale_time: float = 0.1

var move_dir: int = 1

func _ready() -> void:
	$HopTimer.timeout.connect(_on_hop_timeout)
	$Sprite2D.scale = Vector2(0.025, 0.025) + scale_amount * GlobalInfo.duck_info.health * Vector2(1, 1)

func _on_hop_timeout() -> void:
	hop()

func hop() -> void:
	for _i in range(randi() % (max_hops - 1) + 1):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hop")
		
		if randf() < 0.5:
			move_dir *= -1
		
		var projected_x: int = position.x + hop_length * move_dir
		if projected_x < boundary or projected_x > ProjectSettings.get_setting("display/window/size/viewport_width") - boundary:
			move_dir *= -1
		
		var tween := get_tree().create_tween()
		tween.tween_property(self, "position:x", position.x + hop_length * move_dir, hop_time)
		
		await tween.finished

func grow() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(0.025, 0.025) + scale_amount * GlobalInfo.duck_info.health * Vector2(1, 1), scale_time)
