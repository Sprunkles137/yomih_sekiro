extends "res://_Sekiro/characters/sekiro/EmblemState.gd"

export var charged: bool = false

func _frame_5():
	if host.is_grounded():
		var force = xy_to_dir("1", "0", "12", "1.0")
		host.apply_force_relative(force.x, force.y)
		consume_emblems()
