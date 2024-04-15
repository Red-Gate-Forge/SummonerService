class_name PointerCamera extends Camera3D

static var instance: PointerCamera = null

static func get_instance() -> PointerCamera:
	return instance

var pointed_object: Node3D

func get_pointed_object():
	var worldspace = get_world_3d().direct_space_state
	var mouse = get_viewport().get_mouse_position()
	var parameter = PhysicsRayQueryParameters3D.new()
	parameter.from = project_ray_origin(mouse)
	parameter.to = project_position(mouse, 1000)

	var result = worldspace.intersect_ray(parameter)
	if result is Node3D:
		pointed_object = result
	print(result)


func _ready():
	instance = self

func _process(delta):
	pass#get_pointed_object()
