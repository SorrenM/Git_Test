extends CharacterBody3D
var facingUp: bool = true

var upAngle = deg_to_rad(0)
var downAngle = deg_to_rad(-50)
var forwardFacing = deg_to_rad(0)

var lookDir: Vector2
var target_rotation : Vector3
@onready var camera: Camera3D = $Camera3D
var cameraSens = 15
@export var smoothing_speed := 7.0

var capMouse: bool = false

func _physics_process(delta):
	var cameraRotationSpeed: float = 5
		
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
		
	if Input.is_action_just_pressed("look_up"):
		_look_up_down(0,$Camera3D.rotation.x)
		print($Camera3D.rotation_degrees.x) 
		facingUp = true
		print("facingUp = ",facingUp) 
		print("can rotate")
		
	if Input.is_action_just_pressed("look_down"):
		_look_up_down(-50,forwardFacing)
		print($Camera3D.rotation_degrees.x) 
		print($Camera3D.rotation_degrees.y) 
		facingUp = false
		print("facingUp = ", facingUp)

func _look_up_down(look_x_rotation,look_y_rotation):
	var tween = create_tween()
	tween.set_parallel()
	# Smoothly rotate the X axis by 90 degrees over 0.5 seconds
	tween.tween_property($Camera3D, "rotation_degrees:x",look_x_rotation, 0.25)
	tween.tween_property($Camera3D, "rotation_degrees:y",look_y_rotation, 0.25)

func _rotate_camera(delta: float, sensMod: float = 1.0):
	var input = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	lookDir += input
	target_rotation.y = clamp(target_rotation.y - lookDir.x * cameraSens * delta,-1.1,1.1)
	target_rotation.x = clamp(target_rotation.x - lookDir.y * cameraSens * sensMod * delta, 0, 0.4)
	lookDir = Vector2.ZERO
	
	camera.rotation.y = lerp_angle(camera.rotation.y, target_rotation.y, smoothing_speed * delta)
	camera.rotation.x = lerp_angle(camera.rotation.x, target_rotation.x, smoothing_speed * delta)
	
