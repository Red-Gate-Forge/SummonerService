class_name BloodSacraficeSummonStep extends SummonStep


@export var count: int = 0

func get_type() -> Ritual.Type:
    return Ritual.Type.BLOOD_SACRAFICE

func get_content():
    return count

func get_instruction_text() -> String:
    return ("- Add drops of blood " + str(count) + "x")