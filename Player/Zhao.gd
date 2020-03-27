extends Sprite

export var maxHealth = 200
export var currentHealth = 200
export var maxMana = 167
export var currentMana = 167
export var shenfa = 10

signal stats(currentHealth , maxHealth , currentMana, maxMana)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func updateStats():
	emit_signal("stats", currentHealth , maxHealth , currentMana, maxMana)
