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

var selectedPlayer
var selectedEnemy

var currentSelectEnemyMode

enum SelectMode{
	Single,
	Multiple,
	Cancel,
	Finished
}

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
	
func buttonFocusTo():
	GUI.get_node("Buttons/NormalAttack").grab_focus()
	pass

func resetPlayerBar():
	for bar in get_tree().get_nodes_in_group("PlayerBars"):
		bar.setActive(false)
	pass
