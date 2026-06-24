extends Node
class_name QuickTimeEvent
var timer

var qteActive:bool = false #used to know if the qte is still accepting input  
@export var dodgeTime: float = 3

signal qteStarted
signal inputSuccessful #Will be emitted when this QTE is successful  
signal inputFailed #The opposite

@onready var debug_label = $"../../Debug_Label2"

func _process(delta):
	if qteActive == true:
		if(timer.get_time_left() == floor(timer.get_time_left())):
			debug_label.add_text(str(int(timer.get_time_left()))+"s\n")

func _input(event):
	if qteActive and event.is_action_pressed(Global.inputAction): 
		qteActive = false 
		emit_signal("inputSuccessful")
		#queue_free()
		#debug_label.add_text("Cancel timer\n")
		
func start_qte(): #Run this to start the count down  
	qteActive = true
	timer = get_tree().create_timer(dodgeTime) #Start a timer handled by the tree  
	timer.timeout.connect(end_qte)
	emit_signal("qteStarted")
	
func end_qte():#Only triggers on fail  
	qteActive = false #Stop accepting input 
	emit_signal("inputFailed")
	print("inputFailed")  
