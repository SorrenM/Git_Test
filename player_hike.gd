extends CharacterBody3D
var facingUp: bool = true

var upAngle = deg_to_rad(0)
var downAngle = deg_to_rad(-50)
var forwardFacing = deg_to_rad(0)

var lookDir: Vector2
@onready var camera: Camera3D = $Camera3D
var cameraSens = 50

var capMouse: bool = false
	
func _physics_process(delta):
	var cameraRotationSpeed: float = 5
	
	if Input.is_action_just_pressed("look_up"):
		$Camera3D.rotation.x = lerp_angle($Camera3D.rotation.x, upAngle, 1) 
		print($Camera3D.rotation_degrees.x) 
		facingUp = true
		print(facingUp) 
		print("can rotate")
		
	if Input.is_action_just_pressed("look_down"):
		$Camera3D.rotation.x = lerp_angle($Camera3D.rotation.x, downAngle, 1) 
		$Camera3D.rotation.y = forwardFacing
		#lerp_angle($CameraPivot.rotation_degrees.x, downAngle, delta*cameraRotationSpeed)
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
	
func _rotate_camera(delta: float, sens_mod: float = 1.0):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	lookDir += input
	camera.rotation.y = clamp(camera.rotation.y - lookDir.x * cameraSens * delta,-1.1,1.1)
	lookDir = Vector2.ZERO
