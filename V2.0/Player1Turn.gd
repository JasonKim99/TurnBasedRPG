extends States

func didEnter(from):
	if owner.alivePlayers.has(owner.player1):
		owner.beaconFocusTo(owner.player1)
		owner.buttonFocusActive(true)
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
	if owner.currentSelectEnemyMode == owner.SelectMode.Single:
		get_tree().set_input_as_handled()
		if event.is_action_pressed("ui_right"):
			owner.selectSingleEnemy(true)
			pass
		elif event.is_action_pressed("ui_left"):
			owner.selectSingleEnemy(false)
			pass
		elif event.is_action_pressed("ui_up"):
			owner.selectSingleEnemy(false)
			pass
		elif event.is_action_pressed("ui_down"):
			owner.selectSingleEnemy(true)
			pass
		elif event.is_action_pressed("ui_cancel"):
			owner.selectEnemySetup(owner.SelectMode.Cancel)
			pass
		elif event.is_action_pressed("ui_accept"):
			owner.saveToPlayerAttackQueue(owner.player1,owner.selectedEnemy,owner.selectedPlayer.attackType)
			enter("Player2Turn")
			pass
		pass

func willExit(to):
	owner.selectEnemySetup(owner.SelectMode.Finished)
	
	pass
