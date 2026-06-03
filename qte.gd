extends Node
class_name QuickTimeEvent

var qteActive:bool = false #used to know if the qte is still accepting input  
var dodgeTime: float = 3

signal inputSuccessful #Will be emitted when this QTE is successful  
signal inputFailed #The opposite

func _input(event):
	if qteActive and event.is_action_pressed(Global.inputAction):  
		end_qte(true)#The player pressed the button, the qte ends successfuly
		
func start_qte(): #Run this to start the count down  
	var timer = get_tree().create_timer(dodgeTime) #Start a timer handled by the tree  
	timer.timeout.connect(end_qte) 
	qteActive = true
	
func end_qte(successful:bool = false):#The parameter will be false unless specified to be true  
	qteActive = false #Stop accepting input 
	if successful:  
		emit_signal("inputSuccessful")
		print("inputSuccessful")   
	else:  
		emit_signal("inputFailed") #Happens if the timer ends and the button was not pressed
		print("inputFailed")  
