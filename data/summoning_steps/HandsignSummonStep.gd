class_name HandsignSummonStep extends SummonStep


@export var hand_signs: Array[RitualUtils.HandSign]

func get_type() -> Ritual.Type:
    return Ritual.Type.HAND_SIGN

func get_content():
    return hand_signs

func get_instruction_text() -> String:
    var instruction = "- Perform ritual handsigns:\n  "
    
    for hand_sign in hand_signs:
        match hand_sign:
            RitualUtils.HandSign.UP:
                instruction += "[img=64x64]res://ui/sprites/arrow_up.png[/img]"
            RitualUtils.HandSign.DOWN:
                instruction += "[img=64x64]res://ui/sprites/arrow_down.png[/img]"
            RitualUtils.HandSign.RIGHT:
                instruction += "[img=64x64]res://ui/sprites/arrow_right.png[/img]"
            RitualUtils.HandSign.LEFT:
                instruction += "[img=64x64]res://ui/sprites/arrow_left.png[/img]"

    return instruction