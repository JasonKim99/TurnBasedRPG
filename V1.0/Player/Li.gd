extends Node2D

export var maxHealth : int
export var currentHealth : int
export var maxMana : int
export var currentMana : int
export var shenfa : int
export (String, "NormalAttack" , "ManaAttack" , "ThrowItem" , "UseItem") var attackType
export var normalAttackDamage = 53
export var normalAttackRate = 0.75

var castData = CastData.new().dictionary


signal stats(currentHealth , maxHealth , currentMana, maxMana)
signal attackFinished(value,rate)
signal damageTaken

onready var anim = $AnimationPlayer
onready var damageLabel = $Damage

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
	print(anim.current_animation)
	match attackType:
		"NormalAttack":
			anim.play("NormalAttack")
			yield(anim,"animation_finished")
			emit_signal("attackFinished",normalAttackDamage, normalAttackRate)
			if currentHealth <= maxHealth * 0.1:
				anim.play("AlmostDie")
			else:
				anim.play("Idle")
#			return castData[attackType]
		_:
			pass

func takeDamage(damage,rate):
	if rate >= randf():
		currentHealth -= damage
		damageLabel.text = String(damage)
		currentHealth = max(0 , currentHealth)
		updateStats()
		anim.play("Hurt")
		yield(anim,"animation_finished")
		emit_signal("damageTaken")
		
		if currentHealth == 0:
			anim.play("Die")
		elif currentHealth <= maxHealth * 0.1:
			anim.play("AlmostDie")
		else:
			anim.play("Idle")
	else:
		anim.play("Miss")
		yield(anim,"animation_finished")
		emit_signal("damageTaken")
	pass

