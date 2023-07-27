extends "res://_Sekiro/characters/sekiro/AttackState.gd"

func _enter():
	._enter()
	host.recover_posture(0.33 * host.MAX_POSTURE)
