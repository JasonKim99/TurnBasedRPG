extends YSort

onready var leader = $Leader
onready var follower1 = $Follower1
onready var follower2 = $Follower2


# Called when the node enters the scene tree for the first time.
func _ready():
	leader.connect("followMe",follower1,"follow")
	follower1.connect("followMe", follower2, "follow")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
