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
	
	acceleration = resultant_force.normalized()
	
	velocity = (velocity + (acceleration * time)).normalized() * c
	
	if is_nan(velocity.x) or is_nan(velocity.y) or is_nan(velocity.z):
		velocity = Vector3(0,0,0)
	
	position = position + (velocity * time)
	
	resultant_force = Vector3(0,0,0)
