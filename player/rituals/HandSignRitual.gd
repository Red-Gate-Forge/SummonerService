extends Ritual

@export_file("*.tscn") var anim_hands_path: String

@onready var hand_slot: Node3D = get_node("../../hand_slot")

var hand_signs: Array[RitualUtils.HandSign] = []
var hands: Node3D


func perform_hand_sign(hand_sign: RitualUtils.HandSign):
    performed = true
    hand_signs.append(hand_sign)
    print(hand_sign)
    hands.call("do_hand_sign", hand_sign)
    await get_tree().create_timer(0.5).timeout

func _input(event):
    if not active:
        return

    if event.is_action_pressed("ritual_handsign_up"):
        perform_hand_sign(RitualUtils.HandSign.UP)
    elif event.is_action_pressed("ritual_handsign_down"):
        perform_hand_sign(RitualUtils.HandSign.DOWN)
    elif event.is_action_pressed("ritual_handsign_left"):
        perform_hand_sign(RitualUtils.HandSign.LEFT)
    elif event.is_action_pressed("ritual_handsign_right"):
        perform_hand_sign(RitualUtils.HandSign.RIGHT)

## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()
    hand_signs.clear();

    var hands_scene = load(anim_hands_path) as PackedScene
    hands = hands_scene.instantiate()
    hand_slot.add_child(hands)

func end(): #override
    super.end()
    print("Hand Signs Performed: " + str(hand_signs))
    hands.queue_free()

func get_type() -> Ritual.Type: #override
    return Type.HAND_SIGN

func compare_requirement(requirement: SummonStep) -> bool: #override
    var hand_sign_requirement = requirement as HandsignSummonStep
    if hand_sign_requirement == null:
        print("HandsignSummonStep is null")
        return false

    var required_signs = hand_sign_requirement.get_content() as Array[RitualUtils.HandSign]

    if required_signs.size() != hand_signs.size():
        print("Handsign count does not match")
        return false

    for i in range(required_signs.size()):
        if required_signs[i] != hand_signs[i]:
            print("Handsign do not match, Index: " + str(i) + " Required: " + str(required_signs[i]) + " Performed: " + str(hand_signs[i]) + " ")
            return false

    return true

## Ritual Type Interface END ##