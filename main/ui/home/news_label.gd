class_name NewsLabel
extends Label

@export_multiline var texts: String
var text_arrays: Array[Array]
var possible_arrays: Array[Array]

func _ready() -> void:
	$Timer.timeout.connect(_on_refresh)
	parse_text_arrays()

func _on_refresh() -> void:
	refresh_arrays()
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	await tween.finished
	
	var arr: Array = possible_arrays[randi() % len(possible_arrays)]
	text = arr[0] + " - " + arr[1]
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2)
	await tween.finished
	$Timer.start()


func refresh_arrays() -> void:
	var bst: int = GlobalInfo.duck_info.strength + GlobalInfo.duck_info.magic + GlobalInfo.duck_info.health + GlobalInfo.duck_info.agility
	possible_arrays = []
	for t in text_arrays:
		if bst < t[0] or bst > t[1]:
			continue
		possible_arrays.append([t[2], t[3]])

func parse_text_arrays() -> void:
	for t in texts.split("\n"):
		if len(t) == 0:
			continue
		var space: int = t.find(" ")
		var space2: int = t.findn(" ", space + 1)
		var start: int = (t.substr(0, space)).to_int() 
		var end: int = (t.substr(space + 1, space2)).to_int()
		var dash: int = t.rfind("-")
		var sentence: String = t.substr(space2 + 1, dash - space2 - 2)
		sentence = sentence.replace("[name]", GlobalInfo.duck_info.nickname)
		var speaker: String = t.substr(dash + 2)
		
		text_arrays.append([start, end, sentence, speaker])
