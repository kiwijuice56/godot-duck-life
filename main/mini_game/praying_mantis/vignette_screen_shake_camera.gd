class_name VignetteScreenShakeCamera
extends ScreenShakeCamera

@export var vignette: TextureRect
@export var sound: AudioStreamPlayer

func _process(delta: float) -> void:
	super._process(delta)
	sound.volume_db = (trauma / 6.0) * 16 - 6
	if trauma == 0:
		sound.volume_db = - 80
	vignette.material.set_shader_parameter("vignette_opacity", trauma / 8.0)
