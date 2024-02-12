extends Node

#region bases n layouts

class Base:
	var number: int
	var me: PackedScene
	var layouts: Array
	func _init(numberSet: int, meSet: PackedScene, layoutsSet: Array):
		number = numberSet
		me = meSet
		layouts = layoutsSet

class Layout:
	var number: int
	var me: PackedScene
	
	func _init(numberSet: int, meSet: PackedScene):
		number = numberSet
		me = meSet


@onready var base1 = Base.new(1, preload("res://maps/base1/base_1.tscn"), [b1layout1])
@onready var b1layout1 = Layout.new(1, preload("res://maps/base1/b_1_layout_1.tscn"))
