extends YSort

onready var leader = $Player
onready var follower1 = $Follower1
onready var follower2 = $Follower2

func _ready():
	leader.connect("followMe",follower1,"follow")
	follower1.connect("followMe",follower2,"follow")
	pass # Replace with function body.

