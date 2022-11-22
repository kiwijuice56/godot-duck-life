extends Node

@onready var layer_scene: PackedScene = load("res://main/ui/transition_layer/TransitionLayer.tscn")
var layer: CanvasLayer

func _ready() -> void:
	layer = layer_scene.instantiate()
	layer.visible = false
	add_child(layer)

func trans_in() -> void:
	layer.visible = true
	layer.get_node("AnimationPlayer").play("in")
	await layer.get_node("AnimationPlayer").animation_finished

func trans_out() -> void:
	layer.get_node("AnimationPlayer").play("out")
	await layer.get_node("AnimationPlayer").animation_finished
	layer.visible = false
