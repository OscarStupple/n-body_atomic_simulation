extends Node3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
var velocity := Vector3(0,0,0)
const mass := 1.67262192595 * pow(10,-27) * sf 
const charge := -1.602176634 * pow(10,-19)
var time := 0.007
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = self.get_parent().time
	if mass != 0.0:
		acceleration.x = resultant_force.x / mass
		acceleration.y = resultant_force.y / mass
		acceleration.z = resultant_force.z / mass
	
	velocity.x = velocity.x + (acceleration.x * time)
	velocity.y = velocity.y + (acceleration.y * time)
	velocity.z = velocity.z + (acceleration.z * time)
	
	position.x = position.x + (velocity.x * time) - (0.5 * acceleration.x * (time * time))
	position.y = position.y + (velocity.y * time) - (0.5 * acceleration.y * (time * time))
	position.z = position.z + (velocity.z * time) - (0.5 * acceleration.z * (time * time))
	
	resultant_force = Vector3(0,0,0)
