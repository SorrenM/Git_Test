extends CharacterBody3D
var facingUP: bool = true

var upAngle = deg_to_rad(0)
var downAngle = deg_to_rad(-50)

@onready var camera: Camera3D = $Camera3D

	
func _physics_process(delta):
	var cameraRotationSpeed: float = 5
	
	if Input.is_action_just_pressed("look_up"):
		$Camera3D.rotation.x = lerp_angle($Camera3D.rotation.x, upAngle, 1) 
		print($Camera3D.rotation_degrees.x) 
		var facingUP: bool = true
		print(facingUP) 
		
	if Input.is_action_just_pressed("look_down"):
		$Camera3D.rotation.x = lerp_angle($Camera3D.rotation.x, downAngle, 1) 
		#lerp_angle($CameraPivot.rotation_degrees.x, downAngle, delta*cameraRotationSpeed)
		print($Camera3D.rotation_degrees.x) 
		var facingUP: bool = false
		print(facingUP)
		
		

	
