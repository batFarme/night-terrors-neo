class_name Hurtbox2D
extends Area2D


# Called when the node enters the scene tree for the first time.
func _init():
	collision_layer = 4
	collision_mask = 4
	connect("area_entered", self._on_area_entered)
	pass # Replace with function body.

func _on_area_entered(hitbox: Hitbox2D):
	print('hit by hitbox!')
	if hitbox.dmg != null && owner != hitbox.owner:  #checks if collided area has a dmg value; if it doesn't, it either is a presence box or a hurtbox
		if owner.has_method("takeHit"):
			owner.takeHit(hitbox.knockback, hitbox.stun, hitbox.owner.position)
		else:
			print("owner cant access/doesnt have takeHit method!")
	elif hitbox.owner.hp == null: #if the collider doesnt have a dmg value, then...
		print("collided area doesn't have dmg value!")
