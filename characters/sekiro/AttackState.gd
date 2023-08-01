extends CharacterState

export  var deathblow_multiplier: String = "1.0"

func _on_hit_something(obj, hitbox):
  ._on_hit_something(obj, hitbox)
  host.change_emblems(1)
  host.gain_deathblow_meter(fixed.round(fixed.mul(
	str(hitbox.damage),
	deathblow_multiplier
  )))
