extends Area3D
var QTE = QuickTimeEvent.new()
@export var slowedTime: float = 3 
signal unStaggered
@onready var effect_timer

@onready var debug_label = $"../Debug_Label2"

#func _process(delta):
	#if Global.staggered == true:
		#if(effect_timer.get_time_left() == floor(effect_timer.get_time_left())):
			#debug_label.add_text("Staggered: "+str(int(effect_timer.get_time_left()))+"s\n")
	
func _ready():
	add_child(QTE)
	QTE.inputFailed.connect(qte_failed) 
	QTE.inputSuccessful.connect(kill_self) 
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		if self.is_in_group("leftFoot"):
			Global.inputAction = "left_foot_dodge"
			debug_label.add_text("QTE = "+ Global.inputAction+"\n")
			
		if self.is_in_group("rightFoot"):
			Global.inputAction = "right_foot_dodge"
			debug_label.add_text("QTE = "+ Global.inputAction+"\n")
				
		if self.is_in_group("leftHead"):
			Global.inputAction = "left_head_dodge"
			debug_label.add_text("QTE = "+ Global.inputAction+"\n")
				
		if self.is_in_group("rightHead"):
			Global.inputAction = "right_head_dodge"
			debug_label.add_text("QTE = "+ Global.inputAction+"\n")
		
		QTE.start_qte()
		print("Timer started")
		
func kill_self():#Cancel's the QTE
	#remove_child(QTE)
	QTE.queue_free()
	debug_label.add_text("Cancel timer\n")
		
func qte_failed():
	if Global.staggered == true:
		effect_timer.set_time_left(effect_timer.get_time_left()+slowedTime)
		debug_label.add_text("Increased stagger timer\nStaggered: "+str(int(effect_timer.get_time_left()))+"s\n")
	else:
		effect_timer = get_tree().create_timer(slowedTime) #Start a timer handled by the tree  
		effect_timer.timeout.connect(fail_effect_end) 
		Global.staggered = true
		debug_label.add_text("Dodge failed\nStaggered: "+str(int(effect_timer.get_time_left()))+"s\n")

func fail_effect_end():
	Global.staggered = false
	unStaggered.emit()
	debug_label.add_text("Stagger wore off\n")
