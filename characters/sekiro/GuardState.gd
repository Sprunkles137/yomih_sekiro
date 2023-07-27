extends ParryState

func parry(perfect = true):
	perfect = perfect and can_parry
	host.parried = true
	parried = true
	self.perfect = perfect

func _frame_0():
	host.parried_last_state = false
	host.blocked_last_hit = true
	parry_active = true

func _frame_10():
	pass

func _tick():
	host.recover_posture_passive(2)
	host.apply_fric()
	if air_type == AirType.Aerial:
		host.apply_grav()
	if host.combo_count > 0:
		if current_tick > 30 and parried:
			enable_interrupt()
			return fallback_state
	host.apply_forces()

func _exit():
	host.blocked_last_hit = false