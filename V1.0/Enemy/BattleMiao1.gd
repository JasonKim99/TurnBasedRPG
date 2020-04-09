extends Node2D

export var maxHealth = 200
export var currentHealth = 200
export var maxMana = 167
export var currentMana = 167
export var spot = 2
export var shenfa = 10
export var experience = 6
export var damagevalue = 45
export var rate = 0.65

onready var anim = $AnimationPlayer
onready var damageLabel = $Damage

signal attackFinished(damage,rate)
signal damageTaken

func _ready():
	pass # Replace with function body.

func selected():
	anim.play("Selected")

func unselected():
	anim.play("Idle")

func attack():
	anim.play("Attack")  
	yield(anim,"animation_finished")
	emit_signal("attackFinished",damagevalue,rate)
	anim.play("Idle")
	pass
	
func takeDamage(value,rate):
#	var value = damage["value"]
#	var rate = damage["rate"]
	if rate >= randf():
		currentHealth -= value
		damageLabel.text = String(value)
		anim.play("Hurt")
		yield(anim,"animation_finished")
		currentHealth = max(0 , currentHealth)
		if currentHealth == 0:
			anim.play("Die")
		else:
			anim.play("Idle")
		emit_signal("damageTaken")
	else:
		anim.play("Miss")
		yield(anim,"animation_finished")
		emit_signal("damageTaken")
	pass
	
