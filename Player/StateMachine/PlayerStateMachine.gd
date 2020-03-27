class_name PlayerStateMachine
extends Node

onready var currentState = null setget enter
onready var previousState = null
#All the States
var statesMap = {}

func enter(nextState: String):
	#这里传进来的参数是String,current和previous都是Node
	if nextState == null:
		return
	else:
		if currentState != null:
			if currentState.name != nextState:
				currentState.willExit(nextState)
				previousState = currentState
				currentState = statesMap[nextState]
				currentState.didEnter(previousState.name)
		else:
			currentState = statesMap[nextState]
			currentState.didEnter(currentState)

func _physics_process(delta):
	if currentState:
		currentState.update_physics_process(delta)
	pass
	
func _process(delta):
	if currentState:
		currentState.update_process(delta)
	pass

func _unhandled_input(event):
	if currentState:
		currentState.update_unhandled_input(event)
	pass
	
func _input(event):
	if currentState:
		currentState.update_input(event)
	pass


func _ready():
	for child in get_children():
		statesMap[child.name] = child
		child.connect("stateChanged",self,"changeState")
	pass

func changeState(nextState):
	enter(nextState)
	pass
