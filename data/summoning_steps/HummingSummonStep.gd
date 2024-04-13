class_name HummingSummonStep extends SummonStep

@export var tones: Array[HummingSummonSubStep] = []

func get_type() -> Ritual.Type:
	return Ritual.Type.HUMMING

func get_content():
	return tones
