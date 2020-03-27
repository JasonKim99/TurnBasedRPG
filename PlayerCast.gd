extends State

var queueState : GDScriptFunctionState

func didEnter(from):
#	yield(get_tree().create_timer(1),"timeout")
#	queueState = owner.performAttackQueue()
	pass

func update_physics_process(delta):
#	queueState = queueState.resume()
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	pass

func willExit(to):
	for queue in owner.attackQueue:
		queue[0].disconnect("attack",queue[1],"takeDamage")
	pass
