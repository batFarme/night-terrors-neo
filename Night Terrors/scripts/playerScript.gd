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
