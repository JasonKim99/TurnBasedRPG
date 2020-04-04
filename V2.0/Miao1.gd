extends Area2D

signal battleStart

var battleGroup = []

func _on_Area2D_body_entered(body):
	emit_signal("battleStart",[battleGroup,body])
	pass # Replace with function body.
