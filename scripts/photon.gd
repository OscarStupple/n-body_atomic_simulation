extends Node3D

const sf := 2.562831446 * pow(10,14)
const c := 299792458

var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
var velocity := Vector3(0,0,0)
var mass := 0.0
var charge := 0.0
var time := 0.007

var frequency := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = self.get_parent().time
	
	if velocity.length() != c:
		velocity = velocity * (c / velocity.length())
	
	position.x = position.x + (velocity.x * time)
	position.y = position.y + (velocity.y * time)
	position.z = position.z + (velocity.z * time)
	
	resultant_force = Vector3(0,0,0)
