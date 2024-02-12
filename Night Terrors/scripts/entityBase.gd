class_name entityBase
extends CharacterBody2D
#this script will hold a buncha common variables and functions for entities; stuff like "take a hit"
#or "die when you go out of bounds"

@export var hp: int
@export var iTakeKnockback: bool
signal i_just_died

func takeHit(knockback: int, attackStun: int, attackerPos):    #the entity's hitbox should call this function
	hp -= 1  #only necessary cause all instances of damage is equal to 1; enemies all have to touch player twice in a roudn to kill, and all projectiles deal 1 damage anyways
	print("i am " + str(self) + ", i took a hit and now have " + str(hp) + "health")
	var knockbackDirection
	if attackerPos.x > position.x:
		knockbackDirection = -1
	else:
		knockbackDirection = 1
	if iTakeKnockback:
		velocity.x = knockback * knockbackDirection   #probably a more elegant way to do this, but oh well. 
		velocity.y = -knockback #this is a hardcoded 90 degree knockback angle, probably to be tweaked later
	if attackStun != 0: #create stun state; probably only reeeeeaaally applies to player. TO-DO-FLAG-4
		pass
	if hp <= 0:
		if self.has_method("_on_i_just_died"):
			emit_signal("i_just_died")
		else:
			print("owner doesnt have _on_i_just_died method!")

func iAmEntity():
	print('iAmEntity!')
