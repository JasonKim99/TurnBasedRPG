extends KinematicBody2D

onready var atEaseMode = $AtEaseMode
onready var battleMode = $BattleMode/YSort
onready var leaderAnim = $AtEaseMode/Leader/AnimationPlayer
onready var stateMachine = $PlayerStateMachine
onready var battleLi = $BattleMode/YSort/Li
onready var battleZhao = $BattleMode/YSort/Zhao
onready var battleLin = $BattleMode/YSort/Lin
onready var battleAnu = $BattleMode/YSort/Anu
#onready var follower1 = $AtEaseMode/Follower1
#onready var follower2 = $AtEaseMode/Follower2

var maxSpeed = 2
var speed
var direction = Vector2(1, -0.5)
var idleAnim = "TopRightIdle"
var isMoving = false
var currentMove 

signal followMe

func _ready():
#	print(global_position)
	stateMachine.enter("Move")
	pass # Replace with function body.

func atEaseSetup():
	atEaseMode.visible = true
	battleMode.visible = false
	pass
	
func fightSetup():
	atEaseMode.visible = false
	battleMode.visible = true
	for player in get_tree().get_nodes_in_group("BattlePlayer"):
		player.updateStats()
	pass
	
func enterBattle():
	stateMachine.enter("Battle")
	pass
	
func addToCurrentBattlePlayer(character):
	character.add_to_group("BattlePlayer")
	character.visible = true
	
func removeFromCurrentBattlePlayer(character):
	character.remove_from_group("BattlePlayer")
	character.visible = false

func leaderMove(delta):
	speed = maxSpeed
	var moveAnim
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(1, -0.5)
		moveAnim = "TopRight"
		idleAnim = "%sIdle" % leaderAnim.current_animation
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(-1, 0.5)
		moveAnim = "DownLeft"
		idleAnim = "%sIdle" % leaderAnim.current_animation
		pass
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2(-1, -0.5)
		moveAnim = "TopLeft"
		idleAnim = "%sIdle" % leaderAnim.current_animation
		pass
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(1, 0.5)
		moveAnim = "DownRight"
		idleAnim = "%sIdle" % leaderAnim.current_animation
	else:
		moveAnim = idleAnim
		speed = 0
	leaderAnim.play(moveAnim)
	var distance = direction * speed
	global_position += distance
	
	emit_signal("followMe",direction,speed,global_position,distance)


