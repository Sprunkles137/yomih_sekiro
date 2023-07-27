extends "res://_Sekiro/characters/sekiro/DeflectState.gd"

export var emblem_cost: int = 0

func _enter():
	._enter()
	anim_name = "ProstheticUmbrella"
	host.change_emblems(-emblem_cost)

func is_usable():
	return .is_usable() and host.spirit_emblems >= emblem_cost
