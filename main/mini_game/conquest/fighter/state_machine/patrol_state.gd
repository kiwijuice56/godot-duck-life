class_name PatrolState
extends State

@export var min_time := 2.0
@export var max_time := 4.0
@export var patrol_speed := 64.0

func _ready() -> void:
	await get_parent().ready
	fighter.vision_entered.connect(_on_vision_entered)
	$Timer.timeout.connect(_on_timeout)

func _on_vision_entered(area: Area2D) -> void:
	if fighter.state_machine.active_state == self:
		fighter.state_machine.transition_to("ChaseState", {"target" : area.get_parent()})

func _on_timeout() -> void:
	if fighter.state_machine.active_state == self:
		fighter.state_machine.transition_to("IdleState")

func enter(info: Dictionary) -> void:
	fighter.get_node("AnimationPlayer").play("walk")
	if "direction" in info:
		fighter.get_node("Directional").scale.x = info.direction
		patrol_speed = abs(patrol_speed) * info.direction
	$Timer.start(randf_range(min_time, max_time))

func physics_step(delta) -> void:
	fighter.velocity.x = -patrol_speed
	fighter.velocity.y = 0
	fighter.move_and_slide() 
