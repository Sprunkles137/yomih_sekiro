extends Fighter

const MAX_POSTURE = 333
const MAX_SPIRIT_EMBLEMS = 20
const POSTURE_RECOVERY_TIME = 30

var parry_anim: String = ""
var posture: int = MAX_POSTURE
var spirit_emblems: int = 12
var time_since_last_hit: int = 0

var slashcounter: int = 0

func hurt_posture(damage:int, minimum = 0, meter_gain_modifier = "1.0"):
	time_since_last_hit = 0
	if opponent.combo_count == 0:
		trail_hp = hp
	if damage == 0:
		return 
	gain_burst_meter(damage / BURST_ON_DAMAGE_AMOUNT)
	# var damage_score = Utils.int_max(damage, minimum)
	damage = Utils.int_max(combo_stale_damage(damage), 1)
	damage = Utils.int_max(damage, minimum)
	damage = Utils.int_max(guts_stale_damage(damage), 1)
	damage = fixed.round(fixed.mul(str(damage), get_penalty_damage_modifier()))
	damage = fixed.round(fixed.mul(str(damage), MISSED_BRACE_DAMAGE_MULTIPLIER if hit_out_of_brace else "1.0"))
	opponent.gain_super_meter(damage / (DAMAGE_SUPER_GAIN_DIVISOR + 3))
	gain_super_meter(damage / DAMAGE_TAKEN_SUPER_GAIN_DIVISOR)
	damage = fixed.round(fixed.mul(fixed.mul(str(damage), damage_taken_modifier), global_damage_modifier))
	# opponent.combo_damage += damage
	posture -= damage
	add_penalty( - 25)
	if posture <= 0:
		state_machine._change_state("PostureBroken")
		posture = MAX_POSTURE

func recover_posture(val: int):
	posture = Utils.int_min(posture + val, MAX_POSTURE)
	return posture

func recover_posture_passive(val: int):
	if time_since_last_hit > POSTURE_RECOVERY_TIME:
		recover_posture(val)
	return posture

func change_emblems(count: int):
	spirit_emblems = Utils.int_min(
		Utils.int_max(spirit_emblems + count, 0),
		MAX_SPIRIT_EMBLEMS
	)
	return spirit_emblems

func on_got_hit():
	.on_got_hit()
	time_since_last_hit = 0

func set_relative_advantage(opponent, relative: int):
	current_state().anim_length = opponent.current_state().anim_length
	current_state().iasa_at = opponent.current_state().iasa_at
	# Grant whatever frame advantage we can if the opponent recovers sooner than our max
	if opponent.current_state().iasa_at - opponent.current_state().current_tick < relative:
		# current_state().enable_interrupt()
		# Apply hitstun
		return
	# Set advantage relative to anim length if no interruptible frame exists
	if opponent.current_state().iasa_at < 0:
		current_state().current_tick = opponent.current_state().anim_length - relative
	# Set advantage up to opponent's interruptible frame
	else:
		current_state().current_tick = Utils.int_min(
			opponent.current_state().current_tick + relative,
			opponent.current_state().iasa_at - 1
		)

func hit_by(hitbox):
	if parried:
		return 
	if hitbox.name in parried_hitboxes:
		return 
	if not hitbox.hits_otg and is_otg():
		return 
	if not hitbox.hits_vs_dizzy and current_state().state_name == "HurtDizzy":
		return 
	if can_counter_hitbox(hitbox):
		counter_hitbox(hitbox)
	elif current_state() is CounterAttack:
		hit_out_of_brace = true
	
	if hitbox.throw and not is_otg():
		return thrown_by(hitbox)
	if not can_parry_hitbox(hitbox):
		
		match hitbox.hitbox_type:
			Hitbox.HitboxType.Normal:
				launched_by(hitbox)
			Hitbox.HitboxType.NoHitstun:
				take_damage(hitbox.damage if opponent.combo_count <= 0 else hitbox.damage_in_combo)
			Hitbox.HitboxType.Burst:
				launched_by(hitbox)
			Hitbox.HitboxType.Flip:
				set_facing(get_facing_int() * - 1, true)
				var vel = get_vel()
				set_vel(fixed.mul(vel.x, "-1"), vel.y)
				for hitbox in hitboxes:
					hitbox.facing = get_facing()
					pass
				emit_signal("got_hit")
				take_damage(hitbox.get_damage(), hitbox.minimum_damage, hitbox.meter_gain_modifier)
			Hitbox.HitboxType.ThrowHit:
				emit_signal("got_hit")
				take_damage(hitbox.get_damage(), hitbox.minimum_damage, hitbox.meter_gain_modifier)
				opponent.incr_combo(hitbox.scale_combo)
			Hitbox.HitboxType.OffensiveBurst:
				opponent.hitstun_decay_combo_count = 0
				opponent.combo_proration = Utils.int_min(opponent.combo_proration, 0)
				launched_by(hitbox)
				reset_pushback()
				opponent.reset_pushback()
	else :
		opponent.got_parried = true
		var host = objs_map[hitbox.host]
		var projectile = not host.is_in_group("Fighter")
		var perfect_parry
		var relative_advantage = 0
		if not projectile:
			perfect_parry = current_state().can_parry and (always_perfect_parry or opponent.current_state().feinting or opponent.feinting or (initiative and not blocked_last_hit) or parried_last_state)
			opponent.feinting = false
			opponent.current_state().feinting = false
		else :
			perfect_parry = current_state().can_parry and (always_perfect_parry or host.always_parriable or parried_last_state or (current_state().current_tick < PROJECTILE_PERFECT_PARRY_WINDOW and host.has_projectile_parry_window))
		if perfect_parry:
			parried_last_state = true
		else :
			blocked_last_hit = true

		parried = true

		hitlag_ticks = 0
		parried_hitboxes.append(hitbox.name)
		var particle_location = current_state().get("particle_location")
		particle_location.x *= get_facing_int()
		
		if not particle_location:
			particle_location = hitbox.get_overlap_center_float(hurtbox)
		var parry_meter = PARRY_METER if hitbox.parry_meter_gain == - 1 else hitbox.parry_meter_gain
		
		current_state().parry(perfect_parry)
		if not perfect_parry:
			if not projectile:
				opponent.add_penalty( - 25)
			# take_damage(fixed.round(fixed.mul(str(hitbox.damage / PARRY_CHIP_DIVISOR), hitbox.chip_damage_modifier)))

			apply_force_relative(fixed.mul(fixed.div(hitbox.knockback, fixed.mul(PARRY_KNOCKBACK_DIVISOR, "-1")), hitbox.block_pushback_modifier), "0")
			gain_super_meter(parry_meter / 3)
			# opponent.gain_super_meter(parry_meter / 3)
			if not projectile:
				if current_state().state_name == "Deflect":
					relative_advantage = 0
				elif current_state().state_name == "ProstheticUmbrella":
					relative_advantage = 0
			current_state().interruptible_on_opponent_turn = true
			hurt_posture(fixed.round(fixed.mul(str(hitbox.damage), hitbox.chip_damage_modifier)))
			blocked_hitbox_plus_frames = hitbox.plus_frames
			spawn_particle_effect(preload("res://_Sekiro/characters/sekiro/fx/FlawedParryEffect.tscn"), get_pos_visual() + particle_location)
			parried = false
			play_sound("Block")
			play_sound("Parry")
			if host.has_method("on_got_blocked"):
				host.on_got_blocked()
		else :
			if current_state().state_name == "Deflect":
				relative_advantage = 5
			elif current_state().state_name == "ProstheticUmbrella":
				relative_advantage = 10
			if not projectile:
				opponent.add_penalty( - 25)
				add_penalty( - 25)
			else :
				if host.has_method("on_got_parried"):
					host.on_got_parried()
			gain_super_meter(parry_meter)
			match hitbox.hit_height:
				Hitbox.HitHeight.High:
					sprite.animation = "DeflectHigh"
					parry_anim = "DeflectHigh"
				Hitbox.HitHeight.Mid:
					sprite.animation = "DeflectMid"
					parry_anim = "DeflectMid"
			sprite.frame = 0
			spawn_particle_effect(
				preload("res://_Sekiro/characters/sekiro/fx/ParryEffect.tscn"),
				get_pos_visual() + particle_location
			)
			play_sound("Parry2")
			play_sound("Parry")
		set_relative_advantage(opponent, relative_advantage)

func init(pos = null):
	.init(pos)
	slashcounter = 0
	spirit_emblems = 14

func tick():
	.tick()
	time_since_last_hit += 1
