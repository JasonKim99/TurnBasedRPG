extends Area2D

signal battleStart()

var enemy1 = load("res://V2.0/BattleMiao2.tscn")
var enemy2 = load("res://V2.0/BattleMiao1.tscn")
var enemy3 = load("res://V2.0/BattleMiao2.tscn")

var battleEnemy = [enemy1,enemy2,enemy3]

func _on_Area2D_body_entered(body):
	for transition in get_tree().get_nodes_in_group("Transition"):
		connect("battleStart",transition,"fadeIn")
	emit_signal("battleStart",battleEnemy,body.battlePlayer)
	pass # Replace with function body.
