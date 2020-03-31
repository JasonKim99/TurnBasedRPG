tool
extends Area2D

signal battleStart

#onready var battleScene = preload("res://BattleField.tscn").instance()
onready var anim = $AnimationPlayer

func _ready():
	pass

func transition():
#	get_tree().change_scene_to(battleScene)
	pass
	


func _on_EnterBattleArea_body_entered(body):
	get_tree().paused = true
	anim.play("Transition")
	yield(anim,"animation_finished")
	emit_signal("battleStart")
	transition()
#	monitoring =false
	
	pass # Replace with function body.
