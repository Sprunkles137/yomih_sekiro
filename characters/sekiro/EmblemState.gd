extends CharacterState

export  var emblem_cost: int = 0
var deathblow_multiplier: String = "1.0"

func is_usable():
	return .is_usable() and host.spirit_emblems >= emblem_cost

func consume_emblems():
	host.change_emblems(-emblem_cost)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	host.gain_deathblow_meter(fixed.round(fixed.mul(
		str(hitbox.damage),
		deathblow_multiplier
  )))
