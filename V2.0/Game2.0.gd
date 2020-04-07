extends Node2D

onready var battleField = $BattleField
onready var field = $Field
onready var transition = $CanvasLayer/Transition

func _ready():
	transition.connect("battleSetup",battleField,"preSetup")
	battleField.connect("battleOn",self,"battleOn")
	pass

func battleOn():
	battleField.visible = true
	field.visible = false
	transition.anim.play("FadeOut")
