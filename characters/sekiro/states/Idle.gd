extends "res://characters/states/Idle.gd"

func _tick():
	._tick()
	host.recover_posture_passive(1)
