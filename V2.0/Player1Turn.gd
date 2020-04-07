extends States

func didEnter(from):
	if owner.alivePlayers.has(owner.player1):
		owner.beaconFocusTo(owner.player1)
		owner.buttonFocusTo()
		pass
	else:
		enter("Player2Turn")
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
