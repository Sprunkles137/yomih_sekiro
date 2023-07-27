extends "res://_Sekiro/characters/sekiro/AttackState.gd"

func _tick():
	host.apply_fric()
	host.apply_forces()

func _enter():
	if _previous_state() and _previous_state().state_name == "Slash":
		host.slashcounter = (host.slashcounter + 1) % 2
		if host.slashcounter == 0:
			anim_name = "Thrust1"
		else:
			anim_name = "Thrust2"
	else:
		anim_name = "Thrust1"

func is_usable():
	return .is_usable()
