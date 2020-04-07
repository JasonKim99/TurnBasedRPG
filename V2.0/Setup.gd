extends States

func didEnter(from):
	owner.setupCamera()
	owner.setupGUI(true)
	owner.setupField()
	owner.setupTurn()
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
