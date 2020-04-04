extends State

var selectedEnemy

func didEnter(from):
	owner.guiActive(true)
	owner.beaconFocusTo(owner.player1)
	owner.buttonFocusSetup()
	pass

func update_physics_process(delta):
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	if owner.selectEnemyMode == owner.SelectMode.Single:
		get_tree().set_input_as_handled()
		if event.is_action_pressed("ui_right"):
			owner.selectSingleEnemy(true)
		elif event.is_action_pressed("ui_left"):
			owner.selectSingleEnemy(false)
		elif event.is_action_pressed("ui_up"):
			owner.selectSingleEnemy(false)
		elif event.is_action_pressed("ui_down"):
			owner.selectSingleEnemy(true)
		elif event.is_action_pressed("ui_cancel"):
			owner.selectEnemySetup(owner.SelectMode.Cancel)
		elif event.is_action_pressed("ui_accept"):
			owner.saveToPlayerAttackQueue(owner.player1,owner.selectedEnemy, owner.player1.attackType)
			if owner.alivePlayer.has(owner.player2):
				enter("Player2Turn")
			elif owner.alivePlayer.has(owner.player3):
				enter("Player3Turn")
			else:
				enter("PlayerCast")
	elif owner.selectEnemyMode == owner.SelectMode.Multiple:
		if event.is_action_pressed("ui_cancel"):
			owner.selectEnemySetup(owner.SelectMode.Cancel)
		elif event.is_action_pressed("ui_accept"):
			owner.saveToPlayerAttackQueue(owner.player1,owner.selectedEnemy, owner.player1.attackType)
			if owner.alivePlayer.has(owner.player2):
				enter("Player2Turn")
			elif owner.alivePlayer.has(owner.player3):
				enter("Player3Turn")
			else:
				enter("PlayerCast")
		pass
	pass

func willExit(to):
	owner.guiActive(false)
	owner.selectEnemySetup(owner.SelectMode.Finish)
#	owner.selectEnemyMode = false
	pass
