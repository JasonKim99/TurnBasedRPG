class_name States
extends Node


signal changeState

func didEnter(from):
	pass

func update_physics_process(delta):
	pass

func update_process(delta):
	pass
	
func update_input(event):
	pass

func update_unhandled_input(event):
	pass
	

func willExit(to):
	pass

func enter(nextState):
	emit_signal("changeState",nextState)
