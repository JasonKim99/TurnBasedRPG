extends Node2D


export (PackedScene) var scene2
onready var icon = $icon



# Called when the node enters the scene tree for the first time.
func _ready():
	icon.hp -= 50
	transition()
	pass # Replace with function body.

func transition():
	get_tree().change_scene_to(scene2)
