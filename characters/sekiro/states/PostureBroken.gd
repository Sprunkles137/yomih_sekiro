extends CharacterState

const ANIM_LENGTH = 20
const IASA_AT = 10

# Copy of Knockdown.gd
func _enter():
	anim_length = ANIM_LENGTH
	iasa_at = IASA_AT

func _frame_0():
	var vel = host.get_vel()
	host.set_vel(vel.x, "0")
	host.set_grounded(true)
	host.set_pos(host.get_pos().x, 0)
	host.on_the_ground = true
	host.colliding_with_opponent = false
	host.play_sound("HitBass")
	if not host.is_ghost:
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		camera.bump(Vector2.UP, 6, 0.25)

func _exit():
	host.on_the_ground = false
	host.colliding_with_opponent = true

func _tick():
	host.apply_fric()
	host.apply_forces()
	if host.hp <= 0:
		endless = true
