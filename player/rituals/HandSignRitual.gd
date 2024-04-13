class_name  HandSignRitual extends Ritual

enum HandSign { UP, DOWN, LEFT, RIGHT }

var hand_signs: Array[HandSign] = []

func begin():
    super.begin()
    hand_signs.clear();

func end():
    super.end()
    print("Hand Signs Performed: " + str(hand_signs))

func get_result() -> ResultData:
    var result = ResultData.new()
    result.ritual_id = Ritual.Type.HAND_SIGN
    result.payload = hand_signs

    return result

func perform_hand_sign(hand_sign: HandSign):
    hand_signs.append(hand_sign)
    print(hand_sign)
    await get_tree().create_timer(0.5).timeout

func _input(event):
    if not active:
        return

    if event.is_action_pressed("ritual_handsign_up"):
        await perform_hand_sign(HandSign.UP)
    elif event.is_action_pressed("ritual_handsign_down"):
        await perform_hand_sign(HandSign.DOWN)
    elif event.is_action_pressed("ritual_handsign_left"):
        await perform_hand_sign(HandSign.LEFT)
    elif event.is_action_pressed("ritual_handsign_right"):
        await perform_hand_sign(HandSign.RIGHT)
