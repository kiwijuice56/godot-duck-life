class_name Conquest
extends MiniGame

@export var scale_amount := 0.0001

func _ready() -> void:
	super._ready()
	get_node("ConquestPlayer/Directional/Sprite2D").scale = Vector2(0.016, 0.016) + scale_amount * GlobalInfo.duck_info.health * Vector2(1, 1)
	get_node("ConquestPlayer").magic = GlobalInfo.duck_info.health
	get_node("ConquestPlayer").strength = GlobalInfo.duck_info.strength
	get_node("ConquestPlayer/HealthBar").max_value =  GlobalInfo.duck_info.health
	get_node("ConquestPlayer").health = GlobalInfo.duck_info.health
	get_node("ConquestPlayer").agility = GlobalInfo.duck_info.agility + 32 # since agility minigame isnt implemented
	for child in get_children():
		if child is Fighter:
			if child is ConquestPlayer:
				child.died.connect(_on_player_died)
			else:
				child.died.connect(_on_enemy_died)

func _on_player_died() -> void:
	finished.emit()

func _on_enemy_died() -> void:
	$ConquestPlayer/Camera2D.add_trauma(2)

func _on_started() -> void:
	get_node("ConquestPlayer/StateMachine").is_running = true
