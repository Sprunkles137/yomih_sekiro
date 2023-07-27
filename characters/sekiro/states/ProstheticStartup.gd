extends "res://_Sekiro/characters/sekiro/EmblemState.gd"

export var charged_state = ""
export var normal_state = ""

func _enter():
	if data != null:
		match typeof(data):
			TYPE_BOOL:
				if data == true:
					queue_state_change(charged_state, data)
				else:
					queue_state_change(normal_state, data)
			TYPE_DICTIONARY:
				if data.charged == true:
					queue_state_change(charged_state, data)
				else:
					queue_state_change(normal_state, data)
