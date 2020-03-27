tool
extends Node2D
#class_name BattleField


var enemy1
var enemy2
var enemy3
var enemy4
var enemy5
var enemy6

var player1
var player2
var player3

var playerState
var enemyState

var playerShenfa = 0
var enemyShenfa = 0

var alivePlayer = []
var aliveEnemy = []

onready var player1Positon = $YSort/Player1
onready var player2Positon = $YSort/Player2
onready var player3Positon = $YSort/Player3

onready var enemy1Positon = $YSort/Enemy1
onready var enemy2Positon = $YSort/Enemy2
onready var enemy3Positon = $YSort/Enemy3
onready var enemy4Positon = $YSort/Enemy4
onready var enemy5Positon = $YSort/Enemy5
onready var enemy6Positon = $YSort/Enemy6


onready var battleStateMachine = $BattleStateMachine

onready var focusBeacon = $FocusBeacon

onready var gui = $BattleGUI/GUI
onready var buttons = $BattleGUI/GUI/Buttons
onready var player1Bar = $BattleGUI/GUI/PlayerBar1
onready var player2Bar = $BattleGUI/GUI/PlayerBar2
onready var player3Bar = $BattleGUI/GUI/PlayerBar3

var selectedPlayer
var selectedEnemy
var selectEnemyMode = false
var previousIndex = 0
var selectIndex = 0

var attackQueue = []

func _ready():
#	_on_EnterBattleArea_battleStart()
	pass

func _on_EnterBattleArea_battleStart():
	battleStateMachine.enter("Setup")
	pass # Replace with function body.

func setup():
	setupCamera()
	setupPlayer()
	setupEnemy()
	setupBattleField()
	setupTurn()

func setupBattleField():
	visible = true
	for player in get_tree().get_nodes_in_group("Player"):
		playerState = player.stateMachine
		playerState.enter("Battle")
	for enemy in get_tree().get_nodes_in_group("CurrentEnemy"):
		enemyState = enemy.stateMachine
		enemyState.enter("Battle")
	pass

func setupTurn():
	if playerShenfa >= enemyShenfa:
		battleStateMachine.enter("Player1Turn")
	else:
		battleStateMachine.enter("EnemyTurn")

func setupCamera():
	$Camera.current = true

func setupPlayer():
	for player in get_tree().get_nodes_in_group("BattlePlayer"):
		match player.name:
			"Li":
				player1 = player
				alivePlayer.append(player1)
				player1.global_position = player1Positon.global_position
				player1Bar.setActive(true)
				player1.connect("stats",player1Bar,"updateStats")
			"Zhao":
				player2 = player
				alivePlayer.append(player2)
				player2.global_position = player2Positon.global_position
				player2Bar.setActive(true)
				player2.connect("stats",player2Bar,"updateStats")
			"Lin":
				player3 = player
				alivePlayer.append(player3)
				player3.global_position = player3Positon.global_position
				player3Bar.setActive(true)
				player3.connect("stats",player3Bar,"updateStats")
			"Anu":
				player3 = player
				alivePlayer.append(player3)
				player3.global_position = player3Positon.global_position
				player3Bar.setActive(true)
				player3.connect("stats",player3Bar,"updateStats")
				
		playerShenfa = player.shenfa if player.shenfa >= playerShenfa else playerShenfa
	pass

func setupEnemy():
	for enemy in get_tree().get_nodes_in_group("BattleEnemy"):
		match enemy.spot:
			1:
				enemy1 = enemy
				aliveEnemy.append(enemy1)
				enemy1.global_position = enemy1Positon.global_position
			2:
				enemy2 = enemy
				aliveEnemy.append(enemy2)
				enemy2.global_position = enemy2Positon.global_position
			3:
				enemy3 = enemy
				aliveEnemy.append(enemy3)
				enemy3.global_position = enemy3Positon.global_position
			4:
				enemy4 = enemy
				aliveEnemy.append(enemy4)
				enemy4.global_position = enemy4Positon.global_position
			5:
				enemy5 = enemy
				aliveEnemy.append(enemy5)
				enemy5.global_position = enemy5Positon.global_position
			6:
				enemy6 = enemy
				aliveEnemy.append(enemy6)
				enemy6.global_position = enemy6Positon.global_position
		enemyShenfa = enemy.shenfa if enemy.shenfa >= enemyShenfa else enemyShenfa
	pass

func guiActive(value):
	gui.visible = value

func beaconFocusTo(target):
	focusBeacon.global_position = target.global_position + Vector2(-6,-68)
	selectedPlayer = target
	pass

func buttonFocusSetup():
	buttons.get_node("NormalAttack").grab_focus()

func selectEnemyMode(type):
	match type:
		"On":
			selectEnemyMode = true
		"Cancel":
			selectedEnemy.unselected()
			selectEnemyMode = false
			focusBeacon.visible = true
		"Finish":
			selectedEnemy.unselected()
			selectEnemyMode = false
	pass

func selectEnemy(positive):
	if positive:
		selectIndex += 1
		if selectIndex >= aliveEnemy.size():
			selectIndex = 0
	else:
		selectIndex -= 1
		if selectIndex < 0:
			selectIndex = aliveEnemy.size() - 1
	
	if previousIndex != selectIndex:
		aliveEnemy[previousIndex].unselected()
	aliveEnemy[selectIndex].selected()
	previousIndex = selectIndex
	selectedEnemy = aliveEnemy[selectIndex]

func saveToAttackQueue(from , to , with):
	attackQueue.append([from , to, with])
	pass

func _on_NormalAttack_pressed():
	focusBeacon.visible = false
	selectedPlayer.attackType = "NormalAttack"
	selectEnemyMode("On")
	selectEnemy(true)
	pass # Replace with function body.

func performAttackQueue():
	for queue in attackQueue:
		queue[0].connect("attack",queue[1],"takeDamage")
		queue[0].attackWith(queue[2])
		yield()
