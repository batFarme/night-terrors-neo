extends entityBase

#region ========================== REFERENCES =====================================================
@export_category("References")
@export var mySoul: Node2D
const bullet = preload("res://entities/bullet.tscn")
@export var gunSprite: Node2D
@export var myAnimator: AnimationPlayer
@export var deadStateSprite: Sprite2D #to be removed in final product, was just part of prototype funcionality
@export var myTimer: Timer
#endregion 

#region ========================== HANDLING =======================================================
@export_category("Handling")
@export var gravity: float
@export var accelSpeed: float
@export var topSpeed: float 
@export var jumpStrength: float
@export var groundFriction: float
@export var airFriction: float 
@export var HP: int
@export var dropDownWindow: int
@export var dropDownDistance: float
#endregion

#region ========================== INTERNAL CONTROL VARIABLES =====================================
var direction
var lastDirection = 1 #its only set initially so that if the player fires wihtout moving, the bullet just doesnt sit in place
var currentFriction
var gunBarrelPos
var dropDownCount = -1
var crntState	

class Weapon:
	var projectileSpeed: int    #the way this is set up, weapon scenes that are dropped on the floor contain within them a new instance of this class (gonna proly have to rewrite this so that this class is in a global logic handler TO-DO-FLAG-4), and upon colission the myWeapon variable is updated to match the collided weapon
	var projectileLife: int
	func _init(projectileSpeedSet: int, projectileLifeSet: int):
		projectileSpeed = projectileSpeedSet
		projectileLife = projectileLifeSet #in frames

var currentWeapon = Weapon.new(500, 480)

@export_category("Weapon variables (temporary)")
@export var projectileSpeed: int
@export var projectileLife: int    #so like, the currentWeapon class is what the code actually cares about, this is here just so that its easier to edit in the editor
#endregion                          #also this is temporary, only for the prototype; this stuff will be declared in the weapon scenes that r supposed to b picked up

#region ========================== SIGNALS ========================================================
signal i_am_player
signal you_should_go_to
#endregion

func _ready():
	deadStateSprite.visible = false
	currentWeapon.projectileSpeed = projectileSpeed
	currentWeapon.projectileLife = projectileLife
	connect("i_just_died", self._on_i_just_died)
	myAnimator.play("standing")
	crntState = get_node("states/standing")

func _physics_process(delta):
	#gravity
	if not is_on_floor():                #gravity, and changing between air and ground friction. its outside of the state funcitons cause these should be done all the time anyways
		currentFriction = airFriction
		velocity.y += gravity * delta
	else:
		currentFriction = groundFriction
	crntState.run(delta)
	move_and_slide()

#region ========================== STATES =========================================================
'''
func standingState(delta):
	direction = Input.get_axis("dpadLeft", "dpadRight") #no analog stick support with this config!!!
	if direction != 0:
		lastDirection = direction
		mySoul.scale.x = direction #have to optimize so that it doesnt call every freaking frame, only when needed, probably use is_action_just_pressed somehow? #TO-DO-FLAG-1
	else: 
		velocity.x -= velocity.x * currentFriction * delta #applies friction.
		if abs(velocity.x) < 5:
			velocity.x = 0    #so that friction doesnt just make velocity.x infinitely small.
	
	
	if (velocity.x * direction) < topSpeed:
		velocity.x += accelSpeed * direction * delta #actuallly mvoes the player using
	
	#if (v)
	
	if Input.is_action_just_pressed("jump") && is_on_floor(): #jumping
		velocity.y -= jumpStrength
	
	if dropDownCount > 0:
		dropDownCount -= 1
		if Input.is_action_just_pressed("dpadDown"):
			position.y += dropDownDistance
			print("dropdown sent!")
	elif Input.is_action_just_pressed("dpadDown"):
		dropDownCount = dropDownWindow
		print("dropdown count started")
	
	if Input.is_action_just_pressed("fire"):
		gunBarrelPos = gunSprite.position
		var bulletCreate = bullet.instantiate()
		get_parent().add_child(bulletCreate)  #the getparent part is so that the bullet is instantiated as a child of the scene tree rather than a child of the player scene.
		#instantiate a projectile entity 
		pass
func deadState(delta):
	if Input.is_action_just_pressed("startButton"):
		get_tree().change_scene_to_file("res://scenes/prototype_environment.tscn")
'''
#endregion

func _on_enemy_phantom_who_is_player():
	emit_signal("i_am_player", self)   #this is just a workaround till i get a proper fix. TO-DO-FLAG-2
	pass # Replace with function body.

func _on_i_just_died():
	myAnimator.play("dead")
	deadStateSprite.visible = true
	crntState = get_node("states/dead")
	print('player dead ahh hell!')


func _on_timer_timeout():
	pass # Replace with function body.
