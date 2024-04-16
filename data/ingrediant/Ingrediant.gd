class_name Ingrediant extends Resource

@export var id: RitualUtils.Ingrediant = RitualUtils.Ingrediant.NONE
@export var name: String = "Ingrediant"
@export_multiline var description: String = "A single ingrediant"
@export_file("*.tscn") var object_path: String

func instantiate() -> Node3D:
    if object_path.is_empty():
        return null
        
    var scene = load(object_path) as PackedScene
    return scene.instantiate() as Node3D
    