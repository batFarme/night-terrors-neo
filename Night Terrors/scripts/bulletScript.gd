class_name Bullet2D
extends Node2D

var travelDirection 
signal where_do_i_go
@export var mySprite: Sprite2D
@export var doIPenetrate: bool

var moveSpeed: float
var lifeTimer: int #in frames      #these variables aren't exported cause they're set by the player; see there

var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.

func _ready():
	print("bullet born")
	player = get_parent().get_node("player")
	if player != null:
		if player.lastDirection > 0:   
			mySprite.rotation_degrees = 90
		else:
			mySprite.rotation_degrees = 270
		travelDirection = player.lastDirection
		moveSpeed = player.currentWeapon.projectileSpeed
		lifeTimer = player.currentWeapon.projectileLife
		position = player.position + (player.gunBarrelPos * player.lastDirection)  #only works for current prototype 2 direction firing, needs to be updated for multiple direcitons TO-DO-FLAG-5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if travelDirection != null:
		position.x += moveSpeed * travelDirection * delta
	lifeTimer -= 1     #assuming physics process is set to 60 hz, which it should be, this number means how long in frames
	if lifeTimer == 0:
		print("bullet died")
		queue_free()
	pass

func iAmBullet(): #doesnt actually do anything. its here so that the player hurtbox can tell if this is a bullet or not.
	pass


func _on_bullet_hitbox_area_entered(hurtbox: Hurtbox2D):
	if !hurtbox.owner.has_method("standingState"):        #checks if ther owner of the hit entity is the player, so that the player cant shoot themselves. if not player...
		if !doIPenetrate:                                 #checks if the bullet can penetrate. if not...
			queue_free()                                  #delete self. possibly change this for 
