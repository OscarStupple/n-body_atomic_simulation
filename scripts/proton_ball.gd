extends RigidBody3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
const charge := 1.602176634 * pow(10,-19)
var time := 0.007

const NEUTRON := preload("res://scenes/neutron_ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = 1.67262192595 * pow(10,-27) * sf 


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
		#print("collision")
		for i in range(collision_info.get_collision_count()):
			if collision_info.get_collider(i).name == "anti_proton_ball":
				collision_info.get_collider(i).queue_free()
				queue_free()
			elif collision_info.get_collider(i).name == "electron_ball":
				var neutron = NEUTRON.instantiate()
				get_parent().add_child(neutron)
				neutron.position = self.position
				neutron.linear_velocity = -1 * self.linear_velocity
				queue_free()
			
	
	resultant_force = Vector3(0,0,0)
