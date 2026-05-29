extends Node3D
@export var move_speed:=4
@onready var current_speed: float = move_speed

var speed_increase:=1.6
var walk: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if walk == true:
		$Path3D/PathFollow3D.progress +=current_speed*delta
	
	if Input.is_action_just_pressed("walk"):
		walk = !walk
		
func _input(event):
	if event.is_action_pressed("run"):
		current_speed = move_speed*speed_increase
	if event.is_action_released("run"):
		current_speed = move_speed
	print (current_speed)
		
		
		
