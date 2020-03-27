class_name State
extends Node

signal stateChanged

func didEnter(from):
	pass

func update_physics_process(delta):
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	pass

func willExit(to):
	pass

func enter(nextState):
	emit_signal("stateChanged",nextState)

