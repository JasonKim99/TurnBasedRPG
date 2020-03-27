extends Node2D

export var maxHealth : int
export var currentHealth : int
export var maxMana : int
export var currentMana : int
export var shenfa : int
export (String, "NormalAttack" , "ManaAttack" , "ThrowItem" , "UseItem") var attackType
export var normalAttackDamage = 10
export var normalAttackRate = 0.75

signal stats(currentHealth , maxHealth , currentMana, maxMana)
signal attack(damage,rate)

onready var anim = $Sprite/AnimationPlayer

func _ready():
	maxHealth = 200
	currentHealth = 200
	maxMana = 167
	currentMana = 167
	shenfa = 10
	
	pass # Replace with function body.

func updateStats():
	emit_signal("stats", currentHealth , maxHealth , currentMana, maxMana)

func attackWith(attackType):
	match attackType:
		"NormalAttack":
			anim.play("NormalAttack")
			yield(anim,"animation_finished")
			emit_signal("attack",normalAttackDamage, normalAttackRate)
			anim.play("Idle")
		_:
			pass
			

