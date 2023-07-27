extends ParryState

export  var perfect_frames = 0

func _enter():
	# Avoids softblocking if performed during opponent's move
	#todo: actually implement this, also fix it for umbrella
	host.opponent.lowest_tick = host.lowest_tick
	if state_name == "Deflect":
		anim_name = "DeflectStart"
	if state_name == "ProstheticUmbrella":
		anim_name = "ProstheticUmbrellaStart"
	if state_name == "UmbrellaSpin":
		anim_name = "UmbrellaSpin"

# func _ready():
# 	initial_parry_type = parry_type

func _frame_0():
	host.end_throw_invulnerability()
	started_in_combo = host.combo_count > 0
	perfect = true
	parry_type = initial_parry_type
	parry_active = true
	parry_tick = 0
	parried = false
	interruptible_on_opponent_turn = false
	anim_length = perfect_frames
	iasa_at = -1
	endless = false

# func is_usable():
# 	return .is_usable() and host.current_state().state_name != "WhiffInstantCancel"

func _frame_10():
	pass
	# if can_parry:
	# 	if not parried and perfect:
	# 		parry_active = false

func parry(perfect = true):
	perfect = perfect and can_parry
	if perfect:
		null
	else :
		host.start_throw_invulnerability()
	host.parried = true
	parried = true
	self.perfect = perfect

func can_parry_hitbox(hitbox):
	if not perfect:
		return true
	if hitbox == null:
		return false
	if not active:
		return false
	# if not parry_active:
	# 	return false
	match hitbox.hit_height:
		Hitbox.HitHeight.High:
			return parry_type == ParryHeight.High or parry_type == ParryHeight.Both
		Hitbox.HitHeight.Mid:
			return parry_type == ParryHeight.High or parry_type == ParryHeight.Both
		Hitbox.HitHeight.Low:
			return parry_type == ParryHeight.Low or parry_type == ParryHeight.Both
	return false

func _tick():
	host.apply_fric()
	if air_type == AirType.Aerial:
		host.apply_grav()
	# if host.combo_count > 0:
		# if current_tick > 30 and parried:
		# 	enable_interrupt()
		# 	return fallback_state

	host.apply_forces()
	if current_tick >= perfect_frames and perfect:
		host.blocked_last_hit = true

func _exit():
	# parry_active = false
	host.blocked_last_hit = false
