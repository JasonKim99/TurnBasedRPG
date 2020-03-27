extends KinematicBody2D

onready var atEaseMode = $AtEaseMode
onready var battleMode = $BattleMode/YSort
onready var anim = $AtEaseMode/AnimationPlayer
onready var stateMachine = $PlayerStateMachine
onready var battleLi = $BattleMode/YSort/Li
onready var battleZhao = $BattleMode/YSort/Zhao
onready var battleLin = $BattleMode/YSort/Lin
onready var battleAnu = $BattleMode/YSort/Anu

var speed = 120
var direction = Vector2.ZERO
var idleAnim = "TopRightIdle"

func _ready():
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

func move(delta):
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(1, -0.5)
		anim.play("TopRight")
		idleAnim = "%sIdle" % anim.current_animation
		pass
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(-1, 0.5)
		anim.play("DownLeft")
		idleAnim = "%sIdle" % anim.current_animation
		pass
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2(-1, -0.5)
		anim.play("TopLeft")
		idleAnim = "%sIdle" % anim.current_animation
		pass
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(1, 0.5)
		anim.play("DownRight")
		idleAnim = "%sIdle" % anim.current_animation
	else:
		anim.play(idleAnim)
		direction = Vector2.ZERO
	
	global_position += direction * speed * delta
