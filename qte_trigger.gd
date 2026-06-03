extends Area3D
var QTE = QuickTimeEvent.new()  

func _ready():
	add_child(QTE)
	QTE.inputFailed.connect(qte_failed) 
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		if self.is_in_group("leftFoot"):
			Global.inputAction = "left_foot_dodge"
			print("QTE = ", Global.inputAction)
			
		if self.is_in_group("rightFoot"):
			Global.inputAction = "right_foot_dodge"
			print("QTE = ", Global.inputAction)
				
		if self.is_in_group("leftHead"):
			Global.inputAction = "left_head_dodge"
			print("QTE = ", Global.inputAction)
				
		if self.is_in_group("rightHead"):
			Global.inputAction = "right_head_dodge"
			print("QTE = ", Global.inputAction)
		QTE.start_qte()
		print("Timer started")
		#print("QTE started, timer = ",Global.dodgeTime)
		
func qte_failed():
	Global.current_speed = Global.current_speed-3
