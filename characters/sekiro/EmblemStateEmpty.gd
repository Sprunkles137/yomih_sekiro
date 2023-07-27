extends CharacterState

export var emblem_cost: int = 0

func is_usable():
	return .is_usable() and host.spirit_emblems < emblem_cost
