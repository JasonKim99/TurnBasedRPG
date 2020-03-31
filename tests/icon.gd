extends Sprite


var hp = Globaltest.Li["currentHealth"]

# Called when the node enters the scene tree for the first time.
func _ready():
	hp -= 10
	print(Globaltest.Li["currentHealth"])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
