class_name IngrediantSummonStep extends SummonStep

@export var ingrediant: Ingrediant

func get_type() -> Ritual.Type:
    return Ritual.Type.INGREDIANT

func get_content():
    return ingrediant

func get_instruction_text() -> String:
    return ("- Add ingredient: " + ingrediant.name)