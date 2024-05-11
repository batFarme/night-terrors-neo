extends Node2D
const phantom = preload("res://entities/enemy_phantom.tscn")
const leaper = "to be added"
const caster = "to be added"
var crntWave: int = 1
@export var currentWave: int

@onready var map_entity = get_node("map_entity")

var waveThresholds: Array = [ #if ive got time, figure out how to have this stuff editable in the inspector
	#wave no., enemies to be spawned, how many per wave, map size
	[1, [phantom], range(1), 1],
	[2, [phantom], range(2, 4), 1], #talk to jaden, figure out how wave progression shoudl be structured
	[4, [leaper], range(1), 2],
	[5, [phantom, leaper], range(3, 6), 2],
	[8, [caster], range(1), 3],
	[9, [phantom, leaper, caster], range(6, 20), 3]
]

var specialWaves: Array = [        #sort of "special event" waves; think the dogs in bo1 zombies, or special matches in tekken's treasure battle
	#enemies to be spawned, how many of each, map size
	[[leaper, caster], [3, 2], 3] 
]

func _ready():
	print(str(waveThresholds[2][1]))
	pass
	#just to test how multi dimensional arrays work...

func waveSpawn(waveNo):
	var myWaveThresholds = waveThresholds[waveNo]
	pass

func _physics_process(delta):
	if Input.is_action_pressed("debugHold"):
		if Input.is_action_just_pressed("1"):
			waveSpawn(1)
