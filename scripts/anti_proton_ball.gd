extends RigidBody3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
const charge := -1.602176634 * pow(10,-19)
var time := 0.007
const rest_E := 1.50327761802 * pow(10,-10)
var energy := 1.50327761802 * pow(10,-10)
const c := 299792458

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = 1.67262192595 * pow(10,-27) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = self.get_parent().time
	if mass != 0.0:
		acceleration = resultant_force / mass
	
	linear_velocity = linear_velocity + (acceleration * time)
	
	var collision_info = move_and_collide(linear_velocity*time)
	
	#if collision_info != null:
		#for i in range(collision_info.get_collision_count()):
			#if collision_info.get_collider(i).name == "proton_ball":
				#collision_info.get_collider(i).collide_with_anti_proton()
				#collide_with_proton()
	#
	energy = rest_E + 0.5 * mass * pow(linear_velocity.length(),2)
	
	resultant_force = Vector3(0,0,0)

func collide_with_proton():
	var photon = load("res://scenes/photon.tscn").instantiate()
	get_parent().add_child(photon)
	photon.position = self.position
	photon.velocity = -1 * self.linear_velocity.normalized() * c
	photon.energy = 0.5 * mass * pow(linear_velocity.length(),2)
	queue_free()
