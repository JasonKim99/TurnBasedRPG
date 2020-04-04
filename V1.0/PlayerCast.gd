extends State

var queueState : GDScriptFunctionState

func didEnter(from):
#	yield(get_tree().create_timer(1),"timeout")
#	owner.performAttackQueue()
	yield(owner.performPlayerAttackQueue(),"completed")
	if owner.aliveEnemy:
		enter("EnemyTurn")
	else:
		enter("Win")
	pass

func update_physics_process(delta):
	for enemy in owner.aliveEnemy:
		if enemy.currentHealth == 0:
			owner.aliveEnemy.erase(enemy)
			print("干掉了一个")
#	queueState = queueState.resume()
	pass

func update_process(delta):
	pass

func update_unhandled_input(event):
	pass

func update_input(event):
	pass

func willExit(to):
	owner.attackQueue = []
	pass
