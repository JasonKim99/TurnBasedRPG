extends Node2D

export var maxHealth = 200
export var currentHealth = 200
export var maxMana = 167
export var currentMana = 167
export var spot = 1
export var shenfa = 6
onready var anim = $Sprite/AnimationPlayer
onready var damageAnim = $Damage/AnimationPlayer
onready var damageLabel = $Damage
export var experience = 6


func _ready():
	pass # Replace with function body.

func selected():
	anim.play("Selected")

func unselected():
	anim.play("Idle")

func takeDamage(damage,rate):
	if rate >= randf():
		currentHealth -= damage
		damageLabel.text = String(damage)
		damageAnim.play("Hurt")
		anim.play("Hurt")
		yield(anim,"animation_finished")
		yield(damageAnim,"animation_finished")
		currentHealth = max(0 , currentHealth)
		if currentHealth == 0:
			anim.play("Die")
		else:
			anim.play("Idle")
	else:
		anim.play("Miss")
		yield(anim,"animation_finished")
		anim.play("Idle")
	pass
