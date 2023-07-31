# General Characteristics

- Posture gauge. Damage taken while softblocking is not dealt to the healthbar, instead going toward a separate Posture gauge. If the Wolf's posture breaks, he is knocked down.

- Deathblow gauge. Works identically to the Wolf's posture, except it applies to the opponent. Once the opponent is knocked down, the Wolf can perform a Deathblow once within range.

  - [x] Implement.
  - [ ] Animate.
  - [ ] Sound design.
  - [ ] Set a range limit.

- [ ] Alternate sprites for facing forward and backward. Only undertake this if I really want to add extra detail, since I am basically creating all of the same sprites twice.

- [ ] Implement rally mechanic. Unclaimed rallied HP can be regained upon hitting enemy opponents. Unclaimed rallied HP decays after a moment, slowly draining until empty. Taking damage removes all unclaimed rallied HP, on top of whatever damage the attack would have done.

- [x] Deflections have fixed frame advantage.
  - [x] If a deflection cannot gain enough frame advantage, add a variable amount of hitstun to the opponent to compensate.

## Considering

- [ ] Implement Healing Gourd to recover health.
  - Dramatically reduce max HP (50%) to compensate.
  - Gourd may only be used a fixed number of times in a battle.
- [ ] Implement the Finger Whistle.
  - Would be the final and only remaining Shinobi Prosthetic from the base game to implement.
    a) Area-wide stun. Sounds like a more OP version of Firecracker though.
    b) Area-wide knockback. Meant to push opponents or projectiles away.

# Stances

## Normal

Normal stance. All standard actions and Prosthetic Tools are accessible from here.

### Slash

A typical overhead slash. Decent reach, moderate damage, and good hitstun make it a decent combo opener.

- [x] Implement.
- [x] Animate.
- [x] Button icon.
- [ ] Sound design.
- [x] 2023-07-14 Increase startup slightly. Reduce current momentum on entry.

### Thrust

A thrusting attack. Hits narrowly and has slightly more startup, but moves the Wolf forward quickly, closing the gap.

- [x] Implement
- [x] Animate.
- [x] Button icon.
- [ ] Sound design.
- [x] 2023-07-14 Improve frame data. Hitstun is far too little, boost that too. Fix the inactionable period being ass.

### Ichimonji

A simple, overhead strike. Long windup but deals heavy damage. Recovers posture with the initial step. Can be canceled into itself (Nimonji internally) to hit again.

- [x] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] 2023-07-14 Reduce momentum upon entering the state.

### Sakura Dance

A series of rising slashes out of a jump. Hits at a lower angle, so not exactly meant to be an anti-air move, but is a good mixup option.

- [x] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] 2023-07-14 Pay some love and attention to this move. Test out its utility with other moves and Prosthetic Tools once they are implemented.

### Nightjar Slash

A leaping slash meant to close the gap between the opponent. Jumps further than Thrust.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Reversal performs a slash immediately (5-6 frame startup) and sends the Wolf careening backward, to put some distance with the opponent.

### Leaping Kick

Perform a forward jump that crushes low attacks, followed by dropping the leg down to attack.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.
- [ ] Crushed hitboxes must still count as "hit" so the opponent cannot perform Whiff Cancel on their turn. Maybe set interruptible on their move to false.

### Praying Strikes

Step forward and jab with a open palm. This has little reach but comes out quick (4-5 frames) and has decent hitstun.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.
- [ ] Charge button performs the shoulder strike from Exorcism. More details below.
- [ ] Can be followed up with itself to hit again, different animation.
- [ ] Can be fololwed up one last time with Exorcism. This version has less startup.

### Exorcism

Steps into a shoulder bash. Has long startup, but it sends the opponent a good distance and deals moderate posture damage. Can only be performed by using Charge on Praying Strikes.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.

### Deflect

Guarding against damage. Is entered by performing the Deflect action and hitting Wait or Hold. Damage taken is dealt to the Wolf's posture, which is explained in the General Characteristics section.

### Sheathe

Sheathe Kusabimaru. The Wolf enters a different stance where extra powerful moves can be performed, at the cost of Spirit Emblems. The Wolf's primary options are limited. Has a forward and backward dash.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Implement Unsheathe, freeing the Wolf to do something else.

### Deathblow

Situational grab move performed when within a certain distance of the opponent after they are posture-broken (or when they are in knockdown).

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.

### Loaded Shuriken

Quickly (6-8 frames) shoots a spread of lightly damaging shuriken. Costs 4 Spirit Emblems.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Spring action charges the shuriken, delaying when it is shot (10-12 frames) but the shuriken hits 3 times upon hitting an opponent for 125% total damage.
- [ ] Slash action changes to Chasing Slice, rushing toward the direction shot with an attack.

### Flame Vent

Shoots a gust of flame outward in a wide area. Costs 6 Spirit Emblems.

- [x] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [x] Spring action delays the fire somewhat, but greatly improves damage. Spring pushes the Wolf back much farther.
- [x] Reduce pushback from normal use. Keep for spring use.
- [ ] Stack hitboxes in the immediate blast range to improve damage.
- [ ] Spawn an unmoving projectile that exists for a few ticks, increasing Burning build-up for all who overlap it.
- [ ] Attacking through flames (Kusabimaru attacks, Loaded Axe, Loaded Spear) imbues that attack with fire.

### Loaded Axe

Perform a heavy swing after a short delay. Costs 4 Spirit Emblems.

- [x] Implement.
- [ ] Animate.
  - [x] 2023-07-13 Make the Wolf a consistent size.
- [x] Button icon.
- [ ] Sound design.
- [x] Spring action performs a horizontal swing in front before slamming the axe in the ground.
  - [ ] Animate.
- [ ] Add hyper armor to the attack.
- [ ] Aerial axe swings are quicker.
  - [ ] Animate.
  - [ ] Remove momentum in the air.
- [ ] Axe hits through softblock (failed parry).
- [ ] Slash action changes to Fang and Bone, performing a big leaping slash with Kusabimaru and the axe. Consumes Spirit Emblems.

### Shinobi Firecracker

Damageless attack with high hitstun. Fires in a 90° cone. Costs 4 Spirit Emblems.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Spring action delays firing, but shoots in a 180° cone (+90°). Slightly more range.
- [ ] Slash action changes to Chasing Slice, rushing toward the direction shot with an attack.

### Loaded Spear

Stabbing move with great range. Costs 2 Spirit Emblems.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Hold action pulls the opponent to the Wolf; Slash acts as normal, with a different animation.
- [ ] Spring action allows the Wolf to charge forward. Spear hits two times before the final lunge.
- [ ] Slash action changes to Chasing Slice, rushing foward with an attack.

### Mist Raven

Teleport. Costs 4 Spirit Emblems.

- [x] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Spring action acts like a counter; delays the teleport, and will only be performed if a hit connects. Almost a feint. The location traveled is fixed and the distance is shorter, but the Wolf is actionable sooner.

### Loaded Umbrella

A defensive option better than Deflect. It has longer parry frames (10 → 15-16) and allows the Wolf to move forward and backward while blocking attacks. Costs 2 Spirit Emblems.

- [x] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [x] Remove forward and backward walk from Deflect stance, give to Umbrella.
- [ ] Performing the Umbrella action again performs another deflection, still at the cost of Spirit Emblems.
- [ ] Projected Force: A unique attack can be performed out of the block stance. Moderately long windup time, but has poise and deals moderate damage.
- [ ] Additionally, after deflecting or parrying enough damage from projectiles, Projected Force shoots out a cross-slash projectile with a big hitbox.

#### Considering

- [ ] Limit what options can be performed out of the Umbrella stance.
  - Would give conditional disadvantages for using it. Might not feel good to use for that reason.
  - Would need to implement a Stand action that closes the Loaded Umbrella. Would subtract from whatever frame advantage the Umbrella gains from a deflection.

### Sabimaru

A rushdown moveset consisting of a series of slashes with modest range that hit at medium height. Sabimaru performs two slashes, consuming 2 Spirit Emblems per use.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.
- [ ] Using the Sabimaru action repeatedly continues the slashes, up to two additional times (3 times, six slashes total).
- [ ] The Slash action performs a jumping slash and resets the combo. The jumping slash has invulnerability frames.
- [ ] Post-Slash combo now performs paired slashes instead of alternating slashes.
- [ ] Sabimaru inflicts buildup of poison, which steadily drains the opponent's HP slowly (maybe 10% max).

### Divine Abduction

A gust of wind is created around the Wolf, reflecting projectiles and turning opponents around. Costs 6 Spirit Emblems.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Actually reflect projectiles.
- [ ] Actually turns around opponents.

### Super Actions

### Mortal Draw

Draws the Mortal Blade from its sheathe. The Wolf enters the Hairui stance, described in the Stances section. Requires 3 bars of super to use, whereby one is taken to draw the blade and the remaining bars are used as a timer.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.

### Spirit Sugars

The Wolf bites down on the chosen candy and imparts inhuman benedictions into his body, temporarily raising stats at the cost of 1 bar of super. Effect lasts for some 300 ticks and are not stackable. Performs a little animation and particle.

- Ako's Sugar (red) increases damage dealt (+12.5%)
- Ungo's Sugar (blue) increases damage reduction (+33%)
- Gokan's Sugar (yellow) increases posture defense (+67%)
- Yashariku's Sugar (black and red) greatly increases damage dealt (+25%) but increases damage taken (HP by 50%, Posture by 100%).

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.

## Sheathed

The Wolf sheathes Kusabimaru and waits, watching the opponent. Grants access to more powerful moves, at the cost of mobility and access to his standard moves.

### Pommel

Step forward and strike with the pommel of the sword. Comes out on frame 3, beating any other vanilla attack in the game, but has poor reach.

- [x] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.

### Dragon Flash

Charge pressure within the scabbard, then perform a diagonal slash from a sheathed stance to fire a tall wave projectile. Both the sword and projectile deal damage. Costs 4 Spirit Emblems.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Implement a weaker version with insufficient Spirit Emblems. This does not shoot a projectile.

### One Mind

Perform a big overhead slash in the blink of an eye (2 Spirit Emblems). Follows up with many slashing hits around the Wolf (4 Spirit Emblems).

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Set the follow up action as toggleable.
- [ ] Implement a weaker version with insufficient Spirit Emblems. This is incapable of performing any followup slashes.

### Ashina Cross

Step forward and slash twice very quickly, parrying any attack it comes in contact with. Costs 4 Spirit Emblems.

- [ ] Implement.
- [ ] Animate.
- [x] Button icon.
- [ ] Sound design.
- [ ] Implement a weaker version with insufficient Spirit Emblems. This does less damage.
- [ ] Connecting with an oncoming attack parries it.

## Hairui

The Mortal Blade has been drawn. The Wolf loses access to all of his standard attacks and Prosthetic Tools, gaining an entirely new moveset. Attacks are generally much longer ranged and propel the Wolf with it as it swings. Super is actively drained from while in this stance. Attacks performed deal a percentage of their damage to the Wolf himself as ralliable HP.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.

# Defense (Misc)

## Hustle

The Wolf sits cross-legged, meditates, and cradles the Homeward Idol to his head. After 45 frames, grants 1 bar of super, plays the classic sound and does a particle.

## Ceremonial Tanto

Adds 10 additional Spirit Emblems, at a cost of 1/5 HP. These Emblems are counted separately from normal Spirit Emblems and can exceed the 20 Emblem max.

- [ ] Implement.
- [ ] Animate.
- [ ] Button icon.
- [ ] Sound design.
- [ ] Limit 3 times per match.
- [ ] May only be consumed if at least 1/5 HP remains. Ignores guts.
- [ ] May not be consumed if the Wolf already has 5 additional Spirit Emblems.
- [ ] Lost health becomes rally damage.
