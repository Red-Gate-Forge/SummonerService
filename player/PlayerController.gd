extends Node3D


var current_ritual: int = Ritual.Type.NONE

@onready
var ritual_map = {
	Ritual.Type.BLOOD_SACRAFICE: get_node("Rituals/BloodSacraficeRitual"),
	Ritual.Type.INGREDIANT: get_node("Rituals/IngrediantRitual"),
	Ritual.Type.HUMMING: get_node("Rituals/HummingRitual"),
	Ritual.Type.HAND_SIGN: get_node("Rituals/HandSignRitual"),
	Ritual.Type.INCENSE: get_node("Rituals/IncenseRitual")
}

func resolve_ritual(ritual_id: int) -> Ritual:
	if ritual_map.has(ritual_id):
		return ritual_map[ritual_id] as Ritual
	else:
		return null

func end_ritual():
	if current_ritual == Ritual.Type.NONE:
		return
	
	print("Ending ritual " + str(current_ritual) + "...")
	var current_ritual_instance = resolve_ritual(current_ritual)
	await current_ritual_instance.end()
	if current_ritual_instance.performed:
		RitualManager.get_instance().on_ritual_complete(current_ritual_instance)
	current_ritual = Ritual.Type.NONE
	print("Ritual ended.")

func start_ritual(ritual_id: int):
	if current_ritual != Ritual.Type.NONE:
		await end_ritual()

	current_ritual = ritual_id
	print("Beginning ritual " + str(current_ritual) + "...")
	await resolve_ritual(current_ritual).begin()
	print("Ritual begun.")

func _input(event):
	if current_ritual != Ritual.Type.NONE:
		if event.is_action_pressed("ritual_end"):
			end_ritual()

	else:
		if event.is_action_pressed("ritual_handsign_begin"):
			start_ritual(Ritual.Type.HAND_SIGN)
		elif event.is_action_pressed("ritual_incense_begin"):
			start_ritual(Ritual.Type.INCENSE)
		elif event.is_action_pressed("ritual_humming_begin"):
			start_ritual(Ritual.Type.HUMMING)
		elif event.is_action_pressed("ritual_blood_sacrafice_begin"):
			start_ritual(Ritual.Type.BLOOD_SACRAFICE)
		elif event.is_action_pressed("ritual_ingrediant_begin"):
			start_ritual(Ritual.Type.INGREDIANT)

