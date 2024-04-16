extends Ritual

@export_file("*.tscn") var anim_hands_path: String

@onready var hand_slot: Node3D = get_node("../../hand_slot")
@onready var astri_sound: AudioStreamPlayer = $Astri
@onready var sak_sound: AudioStreamPlayer = $Sak
@onready var dox_sound: AudioStreamPlayer = $Dox

var tone_pitches: Array[RitualUtils.TonePitch] = []
var tone_lenghts: Array[RitualUtils.ToneLenght] = []
var tone_index: int = 0

var current_pitch: RitualUtils.TonePitch
var current_lenght: RitualUtils.ToneLenght
var current_lenght_time:float = 0.0
var is_playing: bool = false

var hands: Node3D

func _input(event):
    if not active:
        return

    if is_playing:
        if event.is_action_released("ritual_humming_astri") or event.is_action_released("ritual_humming_sak") or event.is_action_released("ritual_humming_dox"):
            end_tone()

    if event.is_action_pressed("ritual_humming_astri"):
        begin_tone(RitualUtils.TonePitch.ASTRI)
        astri_sound.play()
    elif event.is_action_pressed("ritual_humming_sak"):
        begin_tone(RitualUtils.TonePitch.SAK)
        sak_sound.play()
    elif event.is_action_pressed("ritual_humming_dox"):
        begin_tone(RitualUtils.TonePitch.DOX)
        dox_sound.play()


func _process(delta):
    if not is_playing:
        return

    current_lenght_time += delta

    if current_lenght_time > 2.5:
        if current_lenght != RitualUtils.ToneLenght.WHOLE:
            current_lenght = RitualUtils.ToneLenght.WHOLE
            pulse_pentagram()
    elif current_lenght_time > 1.5:
        if current_lenght != RitualUtils.ToneLenght.HALF:
            current_lenght = RitualUtils.ToneLenght.HALF
            pulse_pentagram()
    elif current_lenght_time > 0.5:
        if current_lenght != RitualUtils.ToneLenght.QUARTER:
            current_lenght = RitualUtils.ToneLenght.QUARTER
            pulse_pentagram()

        

func begin_tone(pitch: RitualUtils.TonePitch):
    performed = true
    if is_playing:
        end_tone()
    
    is_playing = true
    current_pitch = pitch
    current_lenght = RitualUtils.ToneLenght.CRAP
    current_lenght_time = 0.0

func end_tone():
    is_playing = false

    tone_pitches.append(current_pitch)
    tone_lenghts.append(current_lenght)

    astri_sound.stop()
    sak_sound.stop()
    dox_sound.stop()
    
    print("Tone Played: [" + str(tone_pitches[tone_index]) + " " +  str(tone_lenghts[tone_index]) + "]")
    tone_index += 1

func pulse_pentagram():
    var tween = get_tree().create_tween()
    tween.tween_method(set_pentagram_color, 0.0, 1.0, .1)
    tween.chain().tween_method(set_pentagram_color, 1.0, 0.0, .5)

func set_pentagram_color(intensity: float):
    RitualUtils.set_pentagram_color(Vector3.UP * intensity)

## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()
    tone_pitches.clear()
    tone_lenghts.clear()
    tone_index = 0

    var hands_scene = load(anim_hands_path) as PackedScene
    hands = hands_scene.instantiate()
    hand_slot.add_child(hands)

func end(): #override
    super.end()
    hands.queue_free()

func get_type() -> Ritual.Type: #override
    return Type.HUMMING

func compare_requirement(requirement: SummonStep) -> bool: #override
    var humming_requirement = requirement as HummingSummonStep
    if humming_requirement == null:
        print("IncenseSummonStep is null")
        return false

    var tones: Array[HummingSummonSubStep] = humming_requirement.get_content()

    if humming_requirement.get_content().size() != tone_index:
        print("Tone count does not match")
        return false

    for i in range(tone_index):
        if tones[i].tone_pitch != tone_pitches[i] or tones[i].tone_lenght != tone_lenghts[i]:
            print("Tone of index " + str(i) + " does not match")
            return false

    return true

## Ritual Type Interface END ##