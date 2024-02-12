extends Node2D

func run(delta):
	owner.direction = Input.get_axis("dpadLeft", "dpadRight") #no analog stick support with this config!!!
	if owner.direction != 0:
		owner.lastDirection = owner.direction
		owner.mySoul.scale.x = owner.direction #have to optimize so that it doesnt call every freaking frame, only when needed, probably use is_action_just_pressed somehow? #TO-DO-FLAG-1
	else: 
		owner.velocity.x -= owner.velocity.x * owner.currentFriction * delta #applies friction.
		if abs(owner.velocity.x) < 5:
			owner.velocity.x = 0    #so that friction doesnt just make velocity.x infinitely small.
	
	
	if (owner.velocity.x * owner.direction) < owner.topSpeed:
		owner.velocity.x += owner.accelSpeed * owner.direction * delta #actuallly mvoes the player using
	
	#if (v)
	
	if Input.is_action_just_pressed("jump") && owner.is_on_floor(): #jumping
		owner.velocity.y -= owner.jumpStrength
	
	if owner.dropDownCount > 0:
		owner.dropDownCount -= 1
		if Input.is_action_just_pressed("dpadDown"):
			owner.position.y += owner.dropDownDistance
			print("dropdown sent!")
	elif Input.is_action_just_pressed("dpadDown"):
		owner.dropDownCount = owner.dropDownWindow
		print("dropdown count started")
	
	if Input.is_action_just_pressed("fire"):
		owner.gunBarrelPos = owner.gunSprite.position
		var bulletCreate = owner.bullet.instantiate()
		owner.get_parent().add_child(bulletCreate)  #the getparent part is so that the bullet is instantiated as a child of the scene tree rather than a child of the player scene.
		#instantiate a projectile entity 
		pass
