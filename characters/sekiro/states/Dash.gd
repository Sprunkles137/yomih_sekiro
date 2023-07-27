extends "res://characters/states/Dash.gd"

func is_usable():
	return .is_usable() and allowed_stances.has(host.stance)
