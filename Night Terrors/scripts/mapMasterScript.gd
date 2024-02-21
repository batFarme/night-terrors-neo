extends Node2D
#also doubles as enemy spawner

@onready var waveMaster: Node2D = get_parent()
@export var baseAnimator: AnimationPlayer  #in future, should probably keep from naming stuff "base," gets confusing
@export var layoutAnimator: AnimationPlayer
@export var youAreWinSprite: Sprite2D  #prototype thing. to be removed and replaced with something else.

var amountOfEnemies: int
var animatorFree: bool = true

@export var baseKheimon: Node2D
@export var baseTheros: Node2D
@export var layoutSelene: Node2D
@export var layoutApollo: Node2D

@export var currentBaseHolder: Node2D
@export var currentLayoutHolder: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	amountOfEnemies = 3 #TO BE UPDATED BEYOND PROTOTYPE TO-DO-FLAG-8
	currentBaseHolder = baseKheimon
	currentLayoutHolder = layoutApollo #eeehhhh feels icky having the first holders be hardcoded like this but... eh :shrug: :3
	print("mapMasterScritp is here")
	pass # Replace with function body.

func _physics_process(delta):
	if youAreWinSprite.visible:   #to be removed outside prototype
		if Input.is_action_just_pressed("startButton"):
			get_tree().change_scene_to_file("res://scenes/prototype_environment.tscn") #hhhhhhhhh dont like this fix one bit but itll do for now. TO-DO-FLAG-9
	if Input.is_action_just_pressed("9"):
		swapLayouts()
	pass

func swapLayouts():
	if animatorFree == true:
		print("current layout holder is " + str(currentLayoutHolder.name))
		if currentLayoutHolder == layoutSelene:
			layoutAnimator.play("load apollo")
			animatorFree = false
			currentLayoutHolder = layoutApollo
		elif currentLayoutHolder == layoutApollo:
			layoutAnimator.play("load selene")
			animatorFree = false
			currentLayoutHolder = layoutSelene
		else:
			print("layout holder stuff done goofed")

func spawnWave(crntWave):
	pass

func _on_enemy_just_died():
	amountOfEnemies -= 1
	if amountOfEnemies == 0:
		youAreWinSprite.visible = true
		pass


func _on_layout_animator_animation_finished(anim_name):
	animatorFree = true
	pass # Replace with function body.
