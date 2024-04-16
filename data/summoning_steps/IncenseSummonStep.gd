class_name IncenseSummonStep extends SummonStep


@export var count: int = 0

func get_type() -> Ritual.Type:
    return Ritual.Type.INCENSE

func get_content():
    return count

func get_instruction_text() -> String:
    return ("- Incense Burner " + str(count) + "x")