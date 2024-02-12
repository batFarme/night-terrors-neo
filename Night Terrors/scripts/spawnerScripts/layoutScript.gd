class_name MapLayout2D
extends TileMap

var enemySpawners: Array
var mySize
const phantom = preload("res://entities/enemy_phantom.tscn") #TO-DO-FLAG-10 rewrite this to work with wave system


# Called when the node enters the scene tree for the first time.
func _ready():
	print("layout script is here!")
	pass # Replace with function body.

func addSpawnerReference(theSpawnerInQuestion: Vector2):
	enemySpawners.append(theSpawnerInQuestion) #probably dont need the whole ahh custom method??? coulda just said owner.enemySpawners.append(self) in the enemySpawner2Ds... oh well, might come in handy later

func announceMyChildName(child):
	print(child.name)

func spawnMonsters(numberToSpawn, whoToSpawn: Array):
	for i in numberToSpawn:
		pass
