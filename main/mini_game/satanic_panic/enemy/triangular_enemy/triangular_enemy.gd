class_name SatanicPanicTriangularEnemy
extends SatanicPanicEnemy

func _on_delay_timeout() -> void:
	if health <= 0:
		return
	var new_bullet: EnemyBullet = bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 2)
	new_bullet.dir = Vector2(0, -1)
	new_bullet.global_position = global_position
	
	new_bullet = bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 2)
	new_bullet.global_position = global_position
	new_bullet.dir = Vector2(0, -1).rotated(2 * PI / 3)
	
	new_bullet = bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 2)
	new_bullet.global_position = global_position
	new_bullet.dir = Vector2(0, -1).rotated(2 * PI / 3).rotated(2 * PI / 3)
