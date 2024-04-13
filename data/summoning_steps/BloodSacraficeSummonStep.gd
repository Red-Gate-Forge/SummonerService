class_name BloodSacraficeSummonStep extends SummonStep


@export var count: int = 0

func get_type() -> Ritual.Type:
    return Ritual.Type.BLOOD_SACRAFICE

func get_content():
    return count