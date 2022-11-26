class_name CoinLabel
extends Label

func _ready() -> void:
	GlobalInfo.gems_updated.connect(_on_gems_updated)
	_on_gems_updated(GlobalInfo.gems)

func _on_gems_updated(new_gems: int) -> void:
	text = str(new_gems) + " coins"
