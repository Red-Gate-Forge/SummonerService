extends Ritual

@export_file("*.tscn") var anim_hands_path: String

@onready var hand_slot: Node3D = get_node("../../hand_slot")
@onready var drip_audio: AudioStreamPlayer = $drip_audio

var count: int = 0
var hands: Node3D

func _init():
	pass#red_light.hide()

func perform():
	while active:
		print("Ping")
		count += 1
		drip_audio.play()
		var tween = get_tree().create_tween()
		tween.tween_method(set_pentagram_color, 0.0, 1.0, .1)
		tween.chain().tween_method(set_pentagram_color, 1.0, 0.0, .5)
		await get_tree().create_timer(1).timeout

func set_pentagram_color(intensity: float):
	RitualUtils.set_pentagram_color(Vector3.RIGHT * intensity)

## Ritual Type Interface BEGIN ##

func begin(): #override
	super.begin()
	count = 0

	var hands_scene = load(anim_hands_path) as PackedScene
	hands = hands_scene.instantiate()
	hand_slot.add_child(hands)
	await get_tree().create_timer(3.6).timeout
	perform()

func end(): #override
	super.end()

	hands.queue_free()



func get_type() -> Ritual.Type: #override
	return Type.BLOOD_SACRAFICE
		
func compare_requirement(requirement: SummonStep) -> bool: #override
	var blood_sacrafice_requirement = requirement as BloodSacraficeSummonStep
	if blood_sacrafice_requirement == null:
		print("BloodSacraficeSummonStep is null")
		return false

	if blood_sacrafice_requirement.get_content() != count:
		print("Blood Sacrafice count does not match")
		return false

	return true

## Ritual Type Interface END ##
