extends State

func didEnter(from):
	for enemy in owner.aliveEnemy:
		var target = owner.selectPlayer()
		enemy.connect("attackFinished",target,"takeDamage")
		enemy.attack()
		yield(target,"damageTaken")
		enemy.disconnect("attackFinished",target,"takeDamage")
	
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
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	pass

func willExit(to):
	pass
