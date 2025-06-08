extends RigidBody3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
const charge := -1.602176634 * pow(10,-19)
var time := 0.007
const rest_E := 8.1871057880 * pow(10,-14)
var energy := 8.1871057880 * pow(10,-14)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = 9.1093837139 * pow(10,-31)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time = self.get_parent().time
	if mass != 0.0:
		acceleration = resultant_force / mass
	
	linear_velocity = linear_velocity + (acceleration * time)
	
	var collision_info = move_and_collide(linear_velocity*time)
	
	if collision_info != null:
		for i in range(collision_info.get_collision_count()):
			if collision_info.get_collider(i).name == "proton_ball":
				collision_info.get_collider(i).collide_with_electron()
				collide_with_proton()
	
	energy = rest_E + 0.5 * mass * pow(linear_velocity.length(),2)
	
	resultant_force = Vector3(0,0,0)

func collide_with_proton():
	var neutrino = load("res://scenes/electron_neutrino_ball.tscn").instantiate()
	get_parent().add_child(neutrino)
	neutrino.position = self.position
	neutrino.linear_velocity = -1 * self.linear_velocity
	queue_free()
