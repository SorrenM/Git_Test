extends Node
class_name QuickTimeEvent
@onready var timer_label = $"../Timer_Label"
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
		end_qte(true)#The player pressed the button, the qte ends successfuly
		
func start_qte(): #Run this to start the count down  
	qteActive = true
	timer = get_tree().create_timer(dodgeTime) #Start a timer handled by the tree  
	timer.timeout.connect(end_qte) 
	emit_signal("qteActive")
	
func end_qte(successful:bool = false):#The parameter will be false unless specified to be true  
	qteActive = false #Stop accepting input 
	if successful:  
		#Output.print("Dodge success!")
		debug_label.add_text("Dodge success!\n")
		emit_signal("inputSuccessful")
		print("inputSuccessful")   
	else:  
		emit_signal("inputFailed") #Happens if the timer ends and the button was not pressed
		print("inputFailed")  
