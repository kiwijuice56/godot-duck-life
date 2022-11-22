extends Node
# Autoload class for global vars

var duck_info: DuckInfo
var gems: int:
	set(new_val):
		gems = new_val
		gems_updated.emit(gems)

var duck_is_new: bool = false

signal gems_updated(new_val)
signal duck_info_changed

func _ready() -> void:
	load_from_file()

func save_to_file() -> void:
	duck_info.version = ProjectSettings.get_setting("application/config/version")
	ResourceSaver.save(duck_info, "user://save.tres")

func load_from_file() -> void:
	if ResourceLoader.exists("user://save.tres"):
		duck_info = ResourceLoader.load("user://save.tres")
	else:
		initialize_file()
	update_duck_info()

func initialize_file() -> void:
	duck_info = DuckInfo.new()
	duck_is_new = true

func update_duck_info() -> void:
	save_to_file()
	duck_info_changed.emit()
