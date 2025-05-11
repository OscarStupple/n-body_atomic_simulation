extends Node3D

# 0.001 m is the smallest length
const pi := 3.1415926535897932384626433
const e := 2.7182818284590452353602875
const sf := 2.562831446 * pow(10,14)
const G := 6.6740831 * pow(10,-11)
const ke := 1/(4*pi*8.8541878188*pow(10,-12))
const g2 := 1*pow(e,-5) #55*pi
const am := 3.333333333*pow(10,14) / sf #7.073058607*pow(10,15)
#const lp := 1.61622938 * pow(10,-35)
#const tp := 5.3911613 * pow(10,-44)
var time := 0.007
var last_time := 0.007

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for p1 in self.get_children():
		if not(p1.is_in_group("particles")):
			continue
		for p2 in self.get_children():
			if not(p2.is_in_group("particles")) or p1 == p2 or p2.is_in_group("force_vector"):
				continue
			var v := Vector3(p2.position.x - p1.position.x, p2.position.y - p1.position.y, p2.position.z - p1.position.z)
			var r := sqrt((v[0]*v[0])+(v[1]*v[1])+(v[2]*v[2]))
			# r = r/sf
			if r != 0:
				v = v/r
			var Fg := Vector3()
			var Fe := Vector3()
			var Fy := Vector3()
			Fg = v * ((G)*(p1.mass*p2.mass)/(r*r)) * sf 
			Fe = v * ((ke)*(-1*p1.charge*p2.charge)/(r*r)) * sf
			if not(p1.is_in_group("lepton") or p2.is_in_group("lepton")):
				Fy = -v * ((-g2 * pow((1.602176634 * pow(10,-19)),2)) * ((pow(e,(-am * r/sf)) / (r * r))*sf*sf + (am * pow(e,(-am * r/sf)) / r)*sf))
				#Fy = v * ((g2*((pow(e,(-1*(r/sf)*am)))/(r*r))*sf*sf)+(g2*((am*pow(e,(-1*(r/sf)*am)))/r)*sf))
			else:
				Fy = Vector3(0,0,0)
			#print(Fg)
			#print(Fe)
			#print(Fy)
			p1.resultant_force = p1.resultant_force + Fg + Fe + Fy
	if Input.is_action_just_pressed("time_scale_up"):
		time *= 2
	if Input.is_action_just_pressed("time_scale_down"):
		time /= 2
	if Input.is_action_just_pressed("time_forward"):
		time = abs(time)
	if Input.is_action_just_pressed("time_reverse"):
		time = -1*abs(time)
	if Input.is_action_just_pressed("time_pause"):
		if time != 0:
			last_time = time
			time = 0
		else:
			time = last_time
