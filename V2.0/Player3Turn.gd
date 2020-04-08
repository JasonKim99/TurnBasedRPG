extends States

func didEnter(from):
	if owner.alivePlayers.has(owner.player3):
		owner.beaconFocusTo(owner.player3)
		owner.buttonFocusActive(true)
		pass
	else:
		enter("PlayerCast")
	pass


func willExit(to):
	owner.selectEnemySetup(owner.SelectMode.Finished)
	pass
