extends Panel

onready var hp = $HP
onready var mp = $MP
onready var portrait = $Portrait

var isActive = false setget setActive

func _ready():
	pass # Replace with function body.


func updateStats(currentHealth, maxHealth, currentMana, maxMana):
	hp.text = "%s/%s" % [currentHealth,maxHealth]
	mp.text = "%s/%s" % [currentMana,maxMana]
	pass

func setActive(value):
	isActive = value
	visible = isActive
	
