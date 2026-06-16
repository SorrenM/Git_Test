extends Label
var time_passed: float = 0.0

func _ready():
		$"../Trigger_QTE/CollisionShape3D".connect("qteActive",display_qte_timer)
		
func _process(delta):
	time_passed += delta

	
func display_qte_timer():
	pass
