extends "res://_Sekiro/characters/sekiro/GuardState.gd"

func _enter():
	if host.parry_anim != "":
		anim_name = host.parry_anim
		host.parry_anim = ""
	else:
		anim_name = "DeflectIdle"
