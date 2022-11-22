class_name SatanicPanicRadialEnemy
extends SatanicPanicEnemy

var max_i := 24
var i := 0

func _on_delay_timeout() -> void:
	if health <= 0:
		return
	var new_bullet: EnemyBullet = bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 2)
	new_bullet.global_position = global_position
	var rot := (2 * PI / max_i) * i
	var dir := Vector2(1, 0).rotated(rot)
	new_bullet.rotation = rad_to_deg(rot)
	new_bullet.dir = dir
	i = (i + 1) % max_i
