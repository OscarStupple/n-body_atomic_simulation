extends CharacterBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var pitch_pivot: Node3D = $PitchPivot
@onready var camera_3d: Camera3D = $PitchPivot/Camera3D
@onready var animation_player: AnimationPlayer = $PitchPivot/Camera3D/AnimationPlayer

const DEFAULT_SPEED = 8.0

const ACCELERATION = 1.0
var speed := 5.0
var resistance := 5.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var vertical_dir := Input.get_axis("move_down", "move_up")
	var direction := (self.basis * Vector3(input_dir.x, vertical_dir, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, (direction.x * speed), ACCELERATION)
		velocity.y = move_toward(velocity.y, (direction.y * speed), ACCELERATION)
		velocity.z = move_toward(velocity.z, (direction.z * speed), ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, resistance)
		velocity.y = move_toward(velocity.y, 0, resistance)
		velocity.z = move_toward(velocity.z, 0, resistance)
	
	move_and_slide()
	
	speed = DEFAULT_SPEED
	
	#give mouse access
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#rotate camera
	self.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	twist_input = 0
	pitch_input = 0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
