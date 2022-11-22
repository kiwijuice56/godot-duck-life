class_name DuckStatProgressBar
extends ProgressBar

@export var stat: String

func _ready() -> void:
	GlobalInfo.duck_info_changed.connect(_on_duck_info_changed)
	_on_duck_info_changed()

func _on_duck_info_changed() -> void:
	value = GlobalInfo.duck_info.get(stat)
