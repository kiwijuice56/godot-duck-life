class_name PrayingMantis
extends MiniGame

@export var block_scene: PackedScene
var queue: Array[Block] = []
var score := 0
var time := 20

signal shift_left

func _ready() -> void:
	super._ready()
	set_process_input(false)
	for _i in range(16):
		add_block()
	$TotalTimer.timeout.connect(_on_second_timeout)

func _input(event: InputEvent) -> void:
	if not $Timer.is_stopped():
		return
	if not (event.is_pressed() and not event.is_echo()):
		return
	if "unicode" in event:
		$Player/AnimationPlayer.stop()
		if char(event.unicode).to_upper() == queue[0].letter:
			break_block()
			$Player/AnimationPlayer.play("hit")
			score += 1
			UI.score_label.text = str(score)
		else:
			$Miss.stop()
			$Miss.play()
			$Player/AnimationPlayer.play("mistake")
			$Timer.start()

func _on_second_timeout() -> void:
	$Clock.play()
	time -= 1
	UI.time_label.text = str(time)
	if time == 0:
		set_process_input(false)
		var new_strength = max(1, int(pow(score / 16.0, 1.5)))
		GlobalInfo.duck_info.strength += new_strength
		GlobalInfo.update_duck_info()
		UI.game_over_label.text = "Your duck gained %d strength points!" % new_strength
		await UI.game_over()
		finished.emit()
	$TotalTimer.start()

func _on_started() -> void:
	$TotalTimer.start()
	set_process_input(true)

func break_block() -> void:
	queue[0].break_self()
	queue.pop_front()
	shift_left.emit()
	add_block()
	$ScreenShakeCamera.add_trauma(.215)

func add_block() -> void:
	var new_block: Block = block_scene.instantiate()
	new_block.desired_x = $StartMarker.position.x + len(queue) * new_block.width
	new_block.position.x = new_block.desired_x
	new_block.position.y = $StartMarker.position.y
	shift_left.connect(new_block.update_position)
	add_child(new_block)
	move_child(new_block, get_child_count() - 2)
	queue.append(new_block)
