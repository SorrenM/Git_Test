extends Node3D
@export var move_speed:=4
var speed_increase:=1.6

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_speed = move_speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.walk == true:
		self.progress +=Global.current_speed*delta
	
	if Input.is_action_just_pressed("walk"):
		Global.walk = !Global.walk
		
func _input(event):
	if event.is_action_pressed("run"):
		Global.current_speed = move_speed*speed_increase
		print ("current speed = ",Global.current_speed)
	if event.is_action_released("run"):
		Global.current_speed = move_speed
		print ("current speed = ",Global.current_speed)
		
		
		
