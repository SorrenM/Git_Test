extends CharacterBody3D
var facingUp: bool = true

var upAngle = deg_to_rad(0)
var downAngle = deg_to_rad(-50)
var forwardFacing = deg_to_rad(0)

var lookDir: Vector2
@onready var camera: Camera3D = $Camera3D
var cameraSens = 15

var capMouse: bool = false
	
func _physics_process(delta):
	var cameraRotationSpeed: float = 5
	
	if Input.is_action_just_pressed("look_up"):
		_look_up_down(0)
		print($Camera3D.rotation_degrees.x) 
		facingUp = true
		print(facingUp) 
		print("can rotate")
		
	if Input.is_action_just_pressed("look_down"):
		_look_up_down(-50)
		$Camera3D.rotation.y = forwardFacing
		print($Camera3D.rotation_degrees.x) 
		print($Camera3D.rotation_degrees.y) 
		facingUp = false
		print(facingUp)
		
	if Input.is_action_just_pressed("pause"):
		capMouse = !capMouse
		
		if capMouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
	if facingUp == true:
		_rotate_camera(delta)
		
func _input(event: InputEvent):
	if facingUp == true:
		if event is InputEventMouseMotion: lookDir = event.relative*0.01

func _look_up_down(look_rotaion):
	var tween = create_tween()
	# Smoothly rotate the X axis by 90 degrees over 0.5 seconds
	tween.tween_property($Camera3D, "rotation_degrees:x",look_rotaion, 0.5)

func _rotate_camera(delta: float):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	lookDir += input
	camera.rotation.y = clamp(camera.rotation.y - lookDir.x * cameraSens * delta,-1.1,1.1)
	lookDir = Vector2.ZERO
