extends Ritual

@export_file("*.tscn") var anim_hands_path: String

@onready var hand_slot: Node3D = get_node("../../hand_slot")
@onready var pulse_audio: AudioStreamPlayer = $pulse_audio

var count: int = 0
var hands: Node3D

func perform():
    while active:
        print("Ping")
        performed = true
        count += 1

        var tween = get_tree().create_tween()
        pulse_audio.play()
        tween.tween_method(set_pentagram_color, 0.0, 1.0, .1)
        tween.chain().tween_method(set_pentagram_color, 1.0, 0.0, .65)
        await get_tree().create_timer(2.0).timeout

func set_pentagram_color(intensity: float):
    RitualUtils.set_pentagram_color(Vector3(1, 1, 0) * intensity)

## Ritual Type Interface BEGIN ##

func begin(): # override
    super.begin()
    count = 0

    var hands_scene = load(anim_hands_path) as PackedScene
    hands = hands_scene.instantiate()
    hand_slot.add_child(hands)
    await get_tree().create_timer(1.5).timeout
    perform()

func end(): # override
    super.end()
    hands.queue_free()

func get_type() -> Ritual.Type: # override
    return Type.INCENSE
        
func compare_requirement(requirement: SummonStep) -> bool: # override
    var incense_requirement = requirement as IncenseSummonStep
    if incense_requirement == null:
        print("IncenseSummonStep is null")
        return false

    if incense_requirement.get_content() != count:
        print("Incense count does not match")
        return false

    return true

## Ritual Type Interface END ##