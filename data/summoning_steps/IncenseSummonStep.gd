class_name IncenseSummonStep extends SummonStep


@export var count: int = 0

func get_type() -> Ritual.Type:
    return Ritual.Type.INCENSE

func get_content():
    return count