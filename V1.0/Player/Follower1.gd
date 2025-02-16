extends Area2D

onready var anim = $Sprite/AnimationPlayer


signal followMe()

var positionPool = []
var currentDir = Vector2(1,-0.5)
var previousPos = Vector2.ZERO
var dis : float
var hooked = false


var offsets = {
	Vector2(1 , -0.5) : Vector2(-24 , 12),
	Vector2(1 , 0.5) : Vector2(-24 , -12),
	Vector2(-1 , 0.5) : Vector2(24 , -12),
	Vector2(-1 , -0.5) : Vector2(24 , 12) 
}


func follow(targetDir,targetSpeed,targetPos,perDis):
	if positionPool.empty():
		positionPool.append([targetDir,targetPos,perDis])
	if positionPool.back()[1] != targetPos:
		positionPool.append([targetDir,targetPos,perDis])
	if not hooked:
		dis += perDis.length()
	if offsets[currentDir].length() <= dis and targetSpeed > 0:
		var turningPoint = positionPool.pop_front()
		currentDir = turningPoint[0]
		global_position = turningPoint[1]
		hooked = true
		emit_signal("followMe",currentDir,targetSpeed,global_position,turningPoint[2])
	else:
		emit_signal("followMe",currentDir,targetSpeed,global_position,Vector2.ZERO)
	playAnim(targetSpeed)
	pass

func playAnim(speed):
	var animName = ""
	var idleAnim = ""
	match currentDir:
		Vector2(1 , -0.5):
			animName = "TopRight"
			idleAnim = animName + "Idle"
		Vector2(1 , 0.5):
			animName = "DownRight"
			idleAnim = animName + "Idle"
		Vector2(-1 , -0.5):
			animName = "TopLeft"
			idleAnim = animName + "Idle"
		Vector2(-1 , 0.5):
			animName = "DownLeft"
			idleAnim = animName + "Idle"
	if speed > 0:
		anim.play(animName)
	else:
		anim.play(idleAnim)
