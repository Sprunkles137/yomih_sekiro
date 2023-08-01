extends CharacterState

const COUNTER_ADVANTAGE = 10

export  var fric: String = "0.05"
export  var stop_frame: int = 10

func _enter():
	anim_length = 20
	iasa_at = 19

func _frame_1():
	host.start_invulnerability()
	host.start_projectile_invulnerability()
	host.reset_momentum()
	beats_backdash = true
	# iasa_at = Utils.int_max(fixed.round(fixed.add(str(MAX_IASA - MIN_IASA), str(MIN_IASA))), 1)
	host.apply_force_relative("5", "0")
	spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(1, 0))
	host.apply_grav()

func _frame_9():
	host.end_invulnerability()
	host.end_projectile_invulnerability()

func _tick():
	host.apply_x_fric(fric)
	host.apply_grav()
	host.apply_forces()
	if stop_frame > 0 and current_tick == stop_frame:
		host.reset_momentum()
	var opp_hitboxes = host.opponent.get_active_hitboxes()
	if host.invulnerable:
		for hitbox in opp_hitboxes:
			if hitbox.overlaps(host.hurtbox):
				if hitbox.throw == true or hitbox.hit_height != Hitbox.HitHeight.Low:
					host.end_invulnerability()
					host.end_projectile_invulnerability()
				else:
					hitbox.deactivate()
					host.opponent.reset_momentum()
					host.reset_momentum()
					var opp_pos = host.opponent.get_pos()
					opp_pos.x += hitbox.width * (-host.get_facing_int())
					host.set_pos(opp_pos.x + hitbox.width * (-host.get_facing_int()), opp_pos.y)
					host.spawn_particle_effect(
						preload("res://_Sekiro/characters/sekiro/fx/MikiriCounter.tscn"),
						host.get_pos_visual() + Vector2(14 * host.get_facing_int(), -8)
					)
					host.play_sound("Parry")
					host.play_sound("MikiriCounter")
					host.emit_signal("parried")
					var camera = host.get_camera()
					if camera:
						camera.bump(Vector2.UP, 3, 0.25)
					host.gain_deathblow_meter(fixed.round(fixed.div(str(host.MAX_DEATHBLOW), "4")))
					host.set_relative_advantage(host.opponent, COUNTER_ADVANTAGE)
