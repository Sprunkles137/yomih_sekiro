extends "res://_Sekiro/characters/sekiro/AttackState.gd"

func _enter():
	if host.is_grounded():
		var force = xy_to_dir("1", "0", "6", "1.0")
		host.apply_force_relative(force.x, force.y)

func _tick():
	host.recover_posture_passive(1)

func _frame_6():
	self_interruptable = false
	next_state_on_hold = false
	next_state_on_hold_on_opponent_turn = false
	host.reset_momentum()
	var force = fixed.normalized_vec_times(
		"1.0", "0.0", str(Utils.int_max(int(host.is_grounded()) * 10, 3))
	)
	host.apply_force_relative(force.x, force.y)
	host.recover_posture(0.33 * host.MAX_POSTURE)

func _frame_14():
	self_interruptable = true
	next_state_on_hold = true
	next_state_on_hold_on_opponent_turn = true
