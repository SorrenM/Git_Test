extends Area3D

var qteActive:bool = false #used to know if the qte is still accepting input  
@export var dodgeTime: float = 3
signal qteSuccessful #Will be emitted when this QTE is successful  
signal qteFailed #The opposite

@export var inputAction: String

func _input(event):
	if qteActive and event.is_action_pressed(inputAction):  
		end_qte(true)#The player pressed the button, the qte ends successfuly
		
func _on_body_entered(body):
	if body.is_in_group("player"):
		if self.is_in_group("leftFoot"):
			inputAction = "left_foot_dodge"
			print("QTE = ", inputAction)
			
		if self.is_in_group("rightFoot"):
				inputAction = "right_foot_dodge"
				print("QTE = ", inputAction)

func start_qte(): #Run this to start the count down  
	var timer = get_tree().create_timer(dodgeTime) #Start a timer handled by the tree  
#	timer.connect("timeout", Callable(self,"start_qte"), "end_qte") #Connect it  
	qteActive = true
	
func end_qte(successful:bool = false):#The parameter will be false unless specified to be true  
	qteActive = false #Stop accepting input 
	if successful:  
		emit_signal("qteSuccessful")     
	else:  
		emit_signal("qteFailed") #Happens if the timer ends and the button was not pressed
