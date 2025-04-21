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
	
	var collision_info = move_and_collide(linear_velocity*time)
	
	if collision_info != null:
		for i in range(collision_info.get_collision_count()):
			if collision_info.get_collider(i).name == "neutron_ball":
				collision_info.get_collider(i).collide_with_electron_neutrino()
				collide_with_neutron()
	
	resultant_force = Vector3(0,0,0)

func collide_with_neutron():
	var electron = load("res://scenes/electron_ball.tscn").instantiate()
	get_parent().add_child(electron)
	electron.position = self.position
	electron.linear_velocity = -1 * self.linear_velocity
	queue_free()
