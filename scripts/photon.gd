extends Node3D

const sf := 2.562831446 * pow(10,14)
const c := 299792458

var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
var velocity := Vector3(0,0,0)
const mass := 0.0
const charge := 0.0
var time := 0.007
var energy := 0.0

var effective_mass := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = self.get_parent().time
	effective_mass = energy/(pow(c,2))
	
	if effective_mass != 0.0:
		acceleration.x = resultant_force.x / effective_mass
		acceleration.y = resultant_force.y / effective_mass
		acceleration.z = resultant_force.z / effective_mass
	
	velocity.x = velocity.x + (acceleration.x * time)
	velocity.y = velocity.y + (acceleration.y * time)
	velocity.z = velocity.z + (acceleration.z * time)
	
	position.x = position.x + (velocity.x * time) - (0.5 * acceleration.x * (time * time))
	position.y = position.y + (velocity.y * time) - (0.5 * acceleration.y * (time * time))
	position.z = position.z + (velocity.z * time) - (0.5 * acceleration.z * (time * time))
	
	resultant_force = Vector3(0,0,0)
