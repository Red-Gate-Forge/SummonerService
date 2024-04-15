extends Node

@onready var default_cam: PhantomCamera3D = $DefaultCamera
@onready var drawer_cam: PhantomCamera3D = $DrawerCamera
@onready var customer_cam: PhantomCamera3D = $CustomerCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	default()


func default():
	default_cam.set_priority(10)
	drawer_cam.set_priority(0)
	customer_cam.set_priority(0)

func drawer():
	default_cam.set_priority(0)
	drawer_cam.set_priority(10)
	customer_cam.set_priority(0)

func customer():
	default_cam.set_priority(0)
	drawer_cam.set_priority(0)
	customer_cam.set_priority(10)


func _on_ritual_begin(type:Ritual.Type):
	if type == Ritual.Type.INGREDIANT:
		drawer()


func _on_ritual_end(type:Ritual.Type):
	if type == Ritual.Type.INGREDIANT:
		default()
