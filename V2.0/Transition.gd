extends ColorRect

onready var anim = $AnimationPlayer

signal battleSetup()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fadeIn(enemys,players):
	get_tree().paused = true
	anim.play("FadeIn")
	yield(anim,"animation_finished")
	emit_signal("battleSetup",enemys,players)


