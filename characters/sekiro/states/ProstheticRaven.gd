extends "res://_Sekiro/characters/sekiro/EmblemState.gd"

const MOVE_DIST = "120"

func _frame_4():
	host.start_invulnerability()
	host.start_projectile_invulnerability()

func _frame_5():
	var dir = xy_to_dir(data.direction.x, data.direction.y, MOVE_DIST)
	host.move_directly(dir.x, dir.y)
	var vel = host.get_vel()
	host.set_vel(vel.x, "0")
	var tele_force = xy_to_dir(data.direction.x, data.direction.y, "0")
	if fixed.lt(tele_force.y, "0"):
		if host.combo_count <= 0:
			tele_force.y = fixed.mul(tele_force.y, "0.4")
		else :
			tele_force.y = fixed.mul(tele_force.y, "0.666667")
	host.apply_force(tele_force.x, tele_force.y)
	host.update_data()
	consume_emblems()

func _frame_7():
	host.end_invulnerability()
	host.end_projectile_invulnerability()
	host.colliding_with_opponent = true

func _tick():
	host.apply_fric()
	host.apply_grav()
	host.apply_forces()
