extends Node3D

const sf := 2.562831446 * pow(10,14)
var resultant_force := Vector3(0,0,0)
var acceleration := Vector3(0,0,0)
const mass := 1.67262192595 * pow(10,-27) * sf
const charge := 1.602176634 * pow(10,-19)

var gforce := Vector3(0,0,0)
var emforce := Vector3(0,0,0)
var ykforce := Vector3(0,0,0)

var unitv := Vector3(0,0,0)

@onready var g_force_arrow: MeshInstance3D = $G_Force_arrow
@onready var em_force_arrow: MeshInstance3D = $EM_Force_arrow
@onready var yk_force_arrow: MeshInstance3D = $YK_Force_arrow
@onready var res_force_arrow: MeshInstance3D = $Res_Force_arrow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	res_force_arrow.scale.x = 0
	res_force_arrow.scale.y = 0
	res_force_arrow.scale.z = 0
	g_force_arrow.scale.x = 0
	g_force_arrow.scale.y = 0
	g_force_arrow.scale.z = 0
	em_force_arrow.scale.x = 0
	em_force_arrow.scale.y = 0
	em_force_arrow.scale.z = 0
	yk_force_arrow.scale.x = 0
	yk_force_arrow.scale.y = 0
	yk_force_arrow.scale.z = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_arrow(res_force_arrow, resultant_force)
	update_arrow(g_force_arrow, gforce)
	update_arrow(em_force_arrow, emforce)
	update_arrow(yk_force_arrow, ykforce)
	
	resultant_force = Vector3(0,0,0)
	gforce = Vector3(0,0,0)
	emforce = Vector3(0,0,0)
	ykforce = Vector3(0,0,0)

func update_arrow(arrow: Node3D, force: Vector3) -> void:
	var magnitude = force.length()
	arrow.scale = Vector3(magnitude, magnitude, magnitude) * sf
	
	var forward = force.normalized()
	var right = Vector3.UP.cross(forward).normalized()
	var up = forward.cross(right).normalized()
	
	# Construct the basis using the new orientation
	arrow.transform.basis = Basis(right, up, forward)
