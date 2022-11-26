class_name CoinCollector
extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Coin:
		GlobalInfo.gems += 1
		area.collect()
