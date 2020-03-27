extends State

func didEnter(from):
	owner.atEaseSetup()
	pass

func update_physics_process(delta):
	owner.move(delta)
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	pass

func willExit(to):
	pass
