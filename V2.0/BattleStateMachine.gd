extends Node

var previousState = null
var currentState = null setget enter

var stateMap = {}


func _ready():
	for state in get_children():
		stateMap[state.name] = state
		state.connect("changeState",self,"enter")
	pass

func enter(nextState: String):
	if currentState != null:
		currentState.willExit(nextState)
		previousState = currentState
		currentState = stateMap[nextState]
		currentState.didEnter(previousState.name)
		pass
	else:
		currentState = stateMap[nextState]
		currentState.didEnter(null)
		pass
	pass


func _physics_process(delta):
	if currentState != null:
		currentState.update_physics_process(delta)
	pass

func _process(delta):
	if currentState != null:
		currentState.update_process(delta)
	pass

func _input(event):
	if currentState != null:
		currentState.update_input(event)
	pass

func _unhandled_input(event):
	if currentState != null:
		currentState.update_unhandled_input(event)
	pass


