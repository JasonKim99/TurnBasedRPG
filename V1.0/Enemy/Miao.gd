extends Area2D

onready var atEaseMode = $AtEaseMode
onready var battleMode = $BattleMode/YSort
onready var stateMachine = $EnemyStateMachine

func _ready():
	atEaseMode.visible = true
	battleMode.visible = false
	pass # Replace with function body.

func atEaseSetup():
	atEaseMode.visible = true
	battleMode.visible = false
	pass
	
func fightSetup():
	atEaseMode.visible = false
	battleMode.visible = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
