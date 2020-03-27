extends OptionButton

onready var battleTrigger = owner.get_node("Field/EnterBattleArea")
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_OptionButton_item_selected(id):
	match id:
		1:
			battleTrigger._on_EnterBattleArea_body_entered(null)
		2:
			get_tree().reload_current_scene()
		
	pass # Replace with function body.
