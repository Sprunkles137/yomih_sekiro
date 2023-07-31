extends PlayerInfo

onready var spirit_emblem_count = $"%SpiritEmblemCount"
onready var posture_meter = $"%PostureMeter"
onready var deathblow_meter = $"%DeathblowMeter"

func set_fighter(fighter):
	.set_fighter(fighter)
	if player_id == 2:
		$"%Items".alignment = BoxContainer.ALIGN_END
		$"%SpiritEmblemContainer".alignment = BoxContainer.ALIGN_END
		var foo = $"%Items".get_children()
		foo.invert()
		for i in range(foo.size()):
			$"%Items".move_child(foo[i], i)
		#$"%PostureMeter".fill_mode = TextureProgress.FILL_RIGHT_TO_LEFT
	
func _process(delta):
	if is_instance_valid(fighter):
		spirit_emblem_count.text = str(fighter.spirit_emblems)
		posture_meter.value = 1 - (fighter.posture / float(fighter.MAX_POSTURE))
		posture_meter.tint_progress = Color("ff9113") if posture_meter.value > 0.667 else Color("ffd519")
		deathblow_meter.value = fighter.deathblow / float(fighter.MAX_DEATHBLOW)
		deathblow_meter.tint_progress = Color("ff9113") if deathblow_meter.value < 0.333 else Color("ffd519")
