class_name HandsignSummonStep extends SummonStep


@export var hand_signs: Array[RitualUtils.HandSign]

func get_type() -> Ritual.Type:
    return Ritual.Type.HAND_SIGN

func get_content():
    return hand_signs