extends Ritual

var tone_pitches: Array[RitualUtils.TonePitch] = []
var tone_lenghts: Array[RitualUtils.ToneLenght] = []
var tone_index: int = 0

var current_pitch: RitualUtils.TonePitch
var current_lenght:float = 0.0
var is_playing: bool = false

func _input(event):
    if not active:
        return

    if is_playing:
        if event.is_action_released("ritual_humming_astri") or event.is_action_released("ritual_humming_sak") or event.is_action_released("ritual_humming_dox"):
            end_tone()

    if event.is_action_pressed("ritual_humming_astri"):
        begin_tone(RitualUtils.TonePitch.ASTRI)
    elif event.is_action_pressed("ritual_humming_sak"):
        begin_tone(RitualUtils.TonePitch.SAK)
    elif event.is_action_pressed("ritual_humming_dox"):
        begin_tone(RitualUtils.TonePitch.DOX)


func _process(delta):
    if not is_playing:
        return

    current_lenght += delta

func begin_tone(pitch: RitualUtils.TonePitch):
    performed = true
    if is_playing:
        end_tone()
    
    is_playing = true
    current_pitch = pitch
    current_lenght = 0.0

func end_tone():
    is_playing = false
    var tone_lenght: RitualUtils.ToneLenght

    if current_lenght < 0.5:
        tone_lenght = RitualUtils.ToneLenght.QUARTER
    elif current_lenght < 1.0:
        tone_lenght = RitualUtils.ToneLenght.HALF
    else:
        tone_lenght = RitualUtils.ToneLenght.WHOLE

    tone_pitches.append(current_pitch)
    tone_lenghts.append(tone_lenght)
    
    print("Tone Played: [" + str(tone_pitches[tone_index]) + " " +  str(tone_lenghts[tone_index]) + "]")
    tone_index += 1


## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()
    tone_pitches.clear()
    tone_lenghts.clear()
    tone_index = 0

func end(): #override
    super.end()

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