extends Node2D

onready var background = $Background
onready var entities = $YSort
onready var battleArea = $EnterBattleArea

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setScene():
	background.visible = false
	entities.visible = false
	remove_child(battleArea)
	

func _on_EnterBattleArea_battleStart():
	setScene()
#	get_parent().remove_child(self)
#	$Background.visible = false
	pass # Replace with function body.
