extends Area2D

onready var anim = $Zhao/AnimationPlayer

signal followMe()

var positionPool = []

var currentDir = Vector2(1, -0.5)
var dis = 0
var hooked = false
var offset = Vector2(24,12)
var currentAnim
var idleAnim = "TopRightIdle"


func follow(targetDir,targetSpeed,targetPos,perDis):
	if positionPool.empty():
		positionPool.append([targetDir,targetPos,perDis])
	if positionPool.back()[1] != targetPos:
		positionPool.append([targetDir,targetPos,perDis])
	if not hooked:
		dis += perDis.length()
	if offset.length() < dis and targetSpeed > 0:
		var turningPoint = positionPool.pop_front()
		currentDir = turningPoint[0]
		global_position = turningPoint [1]
		hooked = true
		emit_signal("followMe",currentDir,targetSpeed,global_position,turningPoint[2])
	else:
		emit_signal("followMe",currentDir,targetSpeed,global_position,Vector2.ZERO)
	playMoveAnim(currentDir,targetSpeed)
	pass

func playMoveAnim(dir,velocity):
	if velocity > 0:
		match dir:
			Vector2(1,-0.5):
				currentAnim = "TopRight"
			Vector2(1,0.5):
				currentAnim = "DownRight"
			Vector2(-1,-0.5):
				currentAnim = "TopLeft"
			Vector2(-1,0.5):
				currentAnim = "DownLeft"
		idleAnim = "%sIdle" % currentAnim
	else:
		currentAnim = idleAnim
	
	anim.play(currentAnim)
	pass
