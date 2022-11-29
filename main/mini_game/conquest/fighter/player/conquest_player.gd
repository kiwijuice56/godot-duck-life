class_name ConquestPlayer
extends Fighter

func death() -> void:
	queue_free()

func attack(target: Fighter, info := {}) -> void:
	if not $Delay.is_stopped():
		return
	if info.attack == "Physical":
		$AnimationPlayer.play("shove")
		await $AnimationPlayer.animation_finished
		$Delay.start(0.2)
	elif info.attack == "Fireball":
		$AnimationPlayer.play("spell_cast")
		await spawn_magic
		var new_fire := fireball.instantiate()
		new_fire.power = magic
		get_tree().get_root().add_child(new_fire)
		new_fire.global_position = global_position
		new_fire.dir.x = $Directional.scale.x 
		await $AnimationPlayer.animation_finished
		$Delay.start(.3)
