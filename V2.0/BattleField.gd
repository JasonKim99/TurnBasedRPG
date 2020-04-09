extends Node2D

signal battleOn

onready var positions = $YSort
onready var camera = $Camera2D
onready var GUI = $BattleGUI/GUI
onready var beacon = $Beacon
onready var stateMachine = $BattleStateMachine

var player1
var player2
var player3

var enemy1
var enemy2
var enemy3
var enemy4
var enemy5
var enemy6

var aliveEnemys = []
var alivePlayers = []
var defeatedEnemy = []

#var previousEnemyIndex = 0
var currentEnemyIndex = 0

var selectedPlayer
var selectedEnemy

var currentSelectEnemyMode

enum SelectMode{
	Single,
	Multiple,
	Cancel,
	Finished
}

var playerAttackQueue = []

func _ready():
	stateMachine.enter("Asleep")
	pass

func preSetup(enemys,players):
	instanceEnemy(enemys)
	instancePlayer(players)
	stateMachine.enter("Setup")
	pass

func instanceEnemy(enemys):
	for index in enemys.size():
		var enemy = assignEnemy(index + 1, enemys[index])
		aliveEnemys.append(enemy)
		positions.get_node("Enemy%d" % int(index+1)).add_child(enemy)
	pass

func assignEnemy(i,enemy):
	match i:
		1:
			enemy1 = enemy.instance()
			return enemy1
		2:
			enemy2 = enemy.instance()
			return enemy2
		3:
			enemy3 = enemy.instance()
			return enemy3
		4:
			enemy4 = enemy.instance()
			return enemy4
		5:
			enemy5 = enemy.instance()
			return enemy5
		6:
			enemy6 = enemy.instance()
			return enemy6

func instancePlayer(players):
	for player in players:
		var p = player.instance()
		alivePlayers.append(p)
		match p.name:
			"Li":
				player1 = p
				positions.get_node("Player1").add_child(player1)
				var playerBar1 = GUI.get_node("PlayerBar1")
				playerBar1.setActive(true)
				player1.connect("stats",playerBar1,"updateStats")
			"Zhao":
				player2 = p
				positions.get_node("Player2").add_child(player2)
				var playerBar2 = GUI.get_node("PlayerBar2")
				playerBar2.setActive(true)
				player2.connect("stats",playerBar2,"updateStats")
			"Lin":
				if not player2:
					player2 = p
					positions.get_node("Player2").add_child(player2)
					var playerBar2 = GUI.get_node("PlayerBar2")
					playerBar2.setActive(true)
					player2.connect("stats",playerBar2,"updateStats")
				else:
					player3 = p
					positions.get_node("Player3").add_child(player3)
					var playerBar3 = GUI.get_node("PlayerBar3")
					playerBar3.setActive(true)
					player3.connect("stats",playerBar3,"updateStats")
			"Anu":
				if not player2:
					player2 = p
					positions.get_node("Player2").add_child(player2)
					var playerBar2 = GUI.get_node("PlayerBar2")
					playerBar2.setActive(true)
					player2.connect("stats",playerBar2,"updateStats")
				else:
					player3 = p
					positions.get_node("Player3").add_child(player3)
					var playerBar3 = GUI.get_node("PlayerBar3")
					playerBar3.setActive(true)
					player3.connect("stats",playerBar3,"updateStats")
		p.updateStats()
	pass

func setupField():
	emit_signal("battleOn")
	pass

func setupCamera():
	camera.current = true
	pass

func setupGUI(switch):
	if switch:
		GUI.visible = true
	else:
		GUI.visible = false
	pass

func setupTurn():
	stateMachine.enter("Player1Turn")
	pass

func beaconFocusTo(player):
	beacon.visible = true
	beacon.global_position = player.global_position + Vector2(-6,-68)
	selectedPlayer = player
	pass
	
func buttonFocusActive(value):
	if value:
		GUI.get_node("Buttons").visible = true
		GUI.get_node("Buttons/NormalAttack").grab_focus()
	else:
		GUI.get_node("Buttons").visible = false
	pass

func resetPlayerBar():
	for bar in get_tree().get_nodes_in_group("PlayerBars"):
		bar.setActive(false)
	pass



func _on_NormalAttack_pressed():
	beacon.visible = false
	selectedPlayer.attackType = "NormalAttack"
	currentSelectEnemyMode = SelectMode.Single
	selectEnemySetup(currentSelectEnemyMode)
	pass # Replace with function body.

func selectEnemySetup(mode):
	match mode:
		SelectMode.Single:
			selectSingleEnemy(true)
			pass
		SelectMode.Multiple:
			pass
		SelectMode.Cancel:
			beacon.visible = true
			resetSelection()
		SelectMode.Finished:
			resetSelection()
			buttonFocusActive(false)
			pass
	pass

func selectSingleEnemy(clockwise: bool):
	if selectedEnemy:
		if clockwise:
			selectedEnemy.unselected()
			currentEnemyIndex += 1
			if currentEnemyIndex > aliveEnemys.size() - 1:
				currentEnemyIndex = 0
			pass
		else:
			selectedEnemy.unselected()
			currentEnemyIndex -= 1
			if currentEnemyIndex < 0:
				currentEnemyIndex = aliveEnemys.size() - 1
			pass
		selectedEnemy = aliveEnemys[currentEnemyIndex]
		selectedEnemy.selected()
#		previousEnemyIndex = currentEnemyIndex
		pass
	else:
		currentEnemyIndex = 0
		selectedEnemy = aliveEnemys[currentEnemyIndex]
		selectedEnemy.selected()
#		previousEnemyIndex = currentEnemyIndex
	pass

func resetSelection():
	for enemy in  aliveEnemys:
		enemy.unselected()
	currentSelectEnemyMode = null
	selectedEnemy = null
	
	
func saveToPlayerAttackQueue(from, to , with):
	playerAttackQueue.append([from , to, with])
	pass

func performPlayerAttackQueue():
	for queue in playerAttackQueue:
		var player = queue[0]
		var enemy = queue[1]
		if not aliveEnemys.has(enemy):
			enemy = pickupRandomEnemy()
		var attackType = queue[2]
		match attackType:
			"NormalAttack":
				player.connect("attackFinished",enemy,"takeDamage")
				player.attackWith(attackType)
				yield(enemy,"damageTaken")
				player.disconnect("attackFinished",enemy,"takeDamage")
		yield(get_tree().create_timer(0.5),"timeout")
		if enemy.currentHealth == 0:
			aliveEnemys.erase(enemy)
			defeatedEnemy.append(enemy)
		if aliveEnemys.empty():
			stateMachine.enter("Win")
			break
		else:
			if queue == playerAttackQueue.back():
				stateMachine.enter("EnemyTurn")

func pickupRandomEnemy():
	return aliveEnemys[randi() % aliveEnemys.size()]

func performEnemyAttack():
	for enemy in aliveEnemys:
		var player = pickupRandomPlayer()
		enemy.connect("attackFinished",player,"takeDamage")
		enemy.attack()
		yield(player,"damageTaken")
		enemy.disconnect("attackFinished",player,"takeDamage")
		if player.currentHealth == 0:
			alivePlayers.erase(player)
		if alivePlayers.empty():
			stateMachine.enter("Lose")
			break
		else:
			if enemy == aliveEnemys.back():
				stateMachine.enter("Player1Turn")


func pickupRandomPlayer():
	return alivePlayers[randi() % alivePlayers.size()]
