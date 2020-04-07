extends KinematicBody2D


signal followMe()

onready var anim = $Li/AnimationPlayer

var battlePlayer1 = load("res://V2.0/BattleLi.tscn")
var battlePlayer = [battlePlayer1]


var direction = Vector2(1,-0.5)
var maxSpeed = 2
var speed
var currentDir
var previousDir
var currentAnim
var idleAnim = "TopRightIdle"


func _physics_process(delta):
	setDirAndSpeed()
	global_position += direction * speed
	emit_signal("followMe",direction,speed,global_position,direction * speed)
	playMoveAnim(currentDir,speed)


func setDirAndSpeed():
	speed = maxSpeed
	if Input.is_action_just_pressed("ui_up"):
		if previousDir != currentDir:
			previousDir = currentDir
		currentDir = "TopRight"
	elif Input.is_action_just_pressed("ui_right"):
		if previousDir != currentDir:
			previousDir = currentDir
		currentDir = "DownRight"
	elif Input.is_action_just_pressed("ui_down"):
		if previousDir != currentDir:
			previousDir = currentDir
		currentDir = "DownLeft"
	elif Input.is_action_just_pressed("ui_left"):
		if previousDir != currentDir:
			previousDir = currentDir
		currentDir = "TopLeft"
	
	var u = Input.is_action_just_released("ui_up")
	var r = Input.is_action_just_released("ui_right")
	var d = Input.is_action_just_released("ui_down")
	var l = Input.is_action_just_released("ui_left")
	
	if u and currentDir == "TopRight":
		currentDir = previousDir
	if r and currentDir == "DownRight":
		currentDir = previousDir
	if d and currentDir == "DownLeft":
		currentDir = previousDir
	if l and currentDir == "TopLeft":
		currentDir = previousDir
	if currentDir == "TopRight" and Input.is_action_pressed("ui_up"):
		direction = Vector2(1,-0.5)
	elif currentDir == "DownRight" and Input.is_action_pressed("ui_right"):
		direction = Vector2(1,0.5)
	elif currentDir == "DownLeft" and Input.is_action_pressed("ui_down"):
		direction = Vector2(-1,0.5)
	elif currentDir == "TopLeft" and Input.is_action_pressed("ui_left"):
		direction = Vector2(-1,-0.5)
	else:
		speed = 0

func playMoveAnim(dir,velocity):
	if velocity > 0:
		currentAnim = dir
		idleAnim = "%sIdle" % currentAnim
	else:
		currentAnim = idleAnim
	
	anim.play(currentAnim)

