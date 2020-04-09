extends States

func didEnter(from):
	owner.performPlayerAttackQueue()
	pass

func willExit(to):
	owner.playerAttackQueue = []
