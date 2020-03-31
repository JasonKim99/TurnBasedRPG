extends State

func didEnter(from):
	for enemy in owner.aliveEnemy:
		var target = owner.selectPlayer()
		if target:
			enemy.connect("attackFinished",target,"takeDamage")
			enemy.attack()
			yield(target,"damageTaken")
			enemy.disconnect("attackFinished",target,"takeDamage")
		else:
			break
	
	if owner.alivePlayer.has(owner.player1):
		enter("Player1Turn")
	elif owner.alivePlayer.has(owner.player2):
		enter("Player2Turn")
	elif owner.alivePlayer.has(owner.player3):
		enter("Player3Turn")
	else:
		enter("Lose")
	pass

func update_physics_process(delta):
	for player in owner.alivePlayer:
		if player.currentHealth == 0:
			owner.alivePlayer.erase(player)
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	pass

func willExit(to):
	match to:
		"Player1Turn","Player2Turn","Player3Turn":
			owner.focusBeacon.visible = true
		_:
			pass
	pass
