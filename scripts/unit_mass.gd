extends Node3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
var velocity := Vector3(0,0,0)
var mass := 1
var charge := 0.0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mass != 0.0:
		acceleration.x = resultant_force.x / mass
		acceleration.y = resultant_force.y / mass
		acceleration.z = resultant_force.z / mass
	
	velocity.x = velocity.x + (acceleration.x * delta)
	velocity.y = velocity.y + (acceleration.y * delta)
	velocity.z = velocity.z + (acceleration.z * delta)
	
	position.x = position.x + (velocity.x * delta) - (0.5 * acceleration.x * (delta * delta))
	position.y = position.y + (velocity.y * delta) - (0.5 * acceleration.y * (delta * delta))
	position.z = position.z + (velocity.z * delta) - (0.5 * acceleration.z * (delta * delta))
	
	resultant_force = Vector3(0,0,0)
