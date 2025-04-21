extends RigidBody3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
const charge := 0.0
var time := 0.007

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = 8 * pow(10,-37) * sf

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = self.get_parent().time
	if mass != 0.0:
		acceleration.x = resultant_force.x / mass
		acceleration.y = resultant_force.y / mass
		acceleration.z = resultant_force.z / mass
	
	linear_velocity.x = linear_velocity.x + (acceleration.x * time)
	linear_velocity.y = linear_velocity.y + (acceleration.y * time)
	linear_velocity.z = linear_velocity.z + (acceleration.z * time)
	
	move_and_collide(linear_velocity*time)
	
	resultant_force = Vector3(0,0,0)
