extends Node3D
var speed_increase:=1.6

@onready var current_speed
@export var move_speed:=4
# Called when the node enters the scene tree for the first time.
func _ready():
	current_speed = move_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.walk == true:
		self.progress +=current_speed*delta
	
	if Input.is_action_just_pressed("walk"):
		Global.walk = !Global.walk
		
	if Global.staggered == true:
		current_speed = move_speed-1
		
func _input(event):
	if Global.staggered == false:
		if event.is_action_pressed("run"):
			current_speed = move_speed*speed_increase
			print ("current speed = ",current_speed)
		if event.is_action_released("run"):
			current_speed = move_speed
			print ("current speed = ",current_speed)
			
		
		
