extends "res://_Sekiro/characters/sekiro/EmblemState.gd"

export var charged: bool = false

const HITBOX_POSITIONS = [
	[
		[],
		[["0", "-44"],["0", "-66"]]
	],
	[
		[["18", "-16"],["40", "-18"]],
		[["18", "-32"], ["36", "-46"]]
	]
]
# {
# 	{"x": "1", "y": "0"}: [["19", "-15"], ["41", "-15"]],
# 	{"x": "0", "y": "-1"}: [["0", "-44"], ["0", "-62"]],
# 	{"x": "1", "y": "-1"}: [["19", "-30"], ["36", "-45"]]
# }
onready var hitbox = $Hitbox
onready var hitbox2 = $Hitbox2

func _enter():
	var ix = Utils.int_abs(int(data.aim.x))
	var iy = Utils.int_abs(int(data.aim.y))
	hitbox.x = HITBOX_POSITIONS[ix][iy][0][0]
	hitbox.y = HITBOX_POSITIONS[ix][iy][0][1]
	hitbox2.x = HITBOX_POSITIONS[ix][iy][1][0]
	hitbox2.y = HITBOX_POSITIONS[ix][iy][1][1]

func propel(mult):
	var force = xy_to_dir(-data.aim.x * host.get_facing_int(), -data.aim.y, mult, "1.0")
	host.apply_force_relative(force.x, force.y)
	
func _frame_6():
	if not charged:
		consume_emblems()

func _frame_12():
	if charged:
		consume_emblems()
		propel("7.5")
