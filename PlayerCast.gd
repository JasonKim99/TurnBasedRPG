extends State

var queueState : GDScriptFunctionState

func didEnter(from):
#	yield(get_tree().create_timer(1),"timeout")
#	owner.performAttackQueue()
	yield(owner.performPlayerAttackQueue(),"completed")
	enter("EnemyTurn")
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
	for queue in owner.attackQueue:
		queue[0].disconnect("attackFinished",queue[1],"takeDamage")
	owner.attackQueue = []
	pass
