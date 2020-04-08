extends States

func didEnter(from):
	if owner.alivePlayers.has(owner.player2):
		owner.beaconFocusTo(owner.player2)
		owner.buttonFocusActive(true)
		pass
	else:
		enter("Player3Turn")
	pass


func willExit(to):
	owner.selectEnemySetup(owner.SelectMode.Finished)
	pass
