class_name HummingSummonStep extends SummonStep

@export var tones: Array[HummingSummonSubStep] = []

func get_type() -> Ritual.Type:
	return Ritual.Type.HUMMING

func get_content():
	return tones

func get_instruction_text() -> String:
	var instruction = "- Perform ritual sing: "
    
	for tone in tones:
		instruction += "\n  [ "
		match tone.tone_pitch:
			RitualUtils.TonePitch.ASTRI:
				instruction += "ASTRI"
			RitualUtils.TonePitch.SAK:
				instruction += "SAK"
			RitualUtils.TonePitch.DOX:
				instruction += "DOX"
		
		instruction += " | "
		match tone.tone_lenght:
			RitualUtils.ToneLenght.WHOLE:
				instruction += "WHOLE"
			RitualUtils.ToneLenght.HALF:
				instruction += "HALF"
			RitualUtils.ToneLenght.QUARTER:
				instruction += "QUARTER"
		
		instruction += " ] "

	return instruction