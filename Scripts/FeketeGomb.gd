extends Area2D

var main = true
var cango = false
var targetpos = 0
var sprite = preload("res://Scenes/FeketeGomb.tscn")
var sprite_script = preload("res://Scripts/FeketeGomb.gd")
##var blankCircle = get_parent().get_node("BlankCircle")
#var blankBodies = [blankCircle.get_node("BlankBody1"), blankCircle.get_node("BlankBody2"), 
#	blankCircle.get_node("BlankBody3"), blankCircle.get_node("BlankBody4"), blankCircle.get_node("BlankBody5")]

func _ready():
	pass 

func _input(event):
	if event is InputEventMouseMotion and cango and !main:
		#print("Mouse Motion at: ", event.position)
		targetpos = event.position

func _physics_process(delta):
	if cango:
		#print("process: ", targetpos)
		position = targetpos

func _input_event(viewport, event, shape_idx):
	#print(shape_idx)
	if event is InputEventMouseButton and shape_idx == 0 and event.get_button_index() == 2 and !main:
		queue_free()
	if event is InputEventMouseButton and shape_idx == 0 and event.get_button_index() == 1:
		#print("Mouse Click/Unclick at: ", event.position)
		targetpos = event.position
		if event.is_pressed() and main: 
			duplicate_child(event.position)
		if !event.is_pressed():
			cango = false
			#print(get_parent().get_node("BlankCircle").get_node("BlankBody1").global_position)
			#print(global_position)
			var otherO = get_parent().get_node("BlankCircle").get_node("BlankBody1")
			if is_overlapped(otherO):
				position = otherO.global_position
			else:
				queue_free()

func duplicate_child(pos):
	var s = duplicate() 
	s.set_script(sprite_script)
	s.main = false
	s.targetpos = pos
	s.cango = true
	s.position = get_global_mouse_position()
	get_parent().add_child(s)


func is_overlapped(otherObject):
	return abs(global_position.x - otherObject.global_position.x) <= 10 and abs(global_position.y - otherObject.global_position.y) <= 10
