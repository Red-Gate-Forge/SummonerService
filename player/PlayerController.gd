extends Node3D

signal on_ritual_begin(ritual: Ritual.Type)
signal on_ritual_end(ritual: Ritual.Type)
signal on_open_book()
signal on_close_book()

var current_ritual: int = Ritual.Type.NONE
var input_locked = false
var is_book_open = false

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
	input_locked = true
	if current_ritual == Ritual.Type.NONE:
		return
	
	print("Ending ritual " + str(current_ritual) + "...")
	on_ritual_end.emit(current_ritual)
	var current_ritual_instance = resolve_ritual(current_ritual)
	await current_ritual_instance.end()
	if current_ritual_instance.performed:
		RitualManager.get_instance().on_ritual_complete(current_ritual_instance)
	current_ritual = Ritual.Type.NONE
	print("Ritual ended.")
	await get_tree().create_timer(0.5).timeout
	input_locked = false

func start_ritual(ritual_id: int):
	input_locked = true
	on_ritual_begin.emit(ritual_id)
	if current_ritual != Ritual.Type.NONE:
		await end_ritual()
		input_locked = true

	current_ritual = ritual_id
	print("Beginning ritual " + str(current_ritual) + "...")
	await resolve_ritual(current_ritual).begin()
	print("Ritual begun.")
	await get_tree().create_timer(0.5).timeout
	input_locked = false

func open_book():
	is_book_open = true
	on_open_book.emit()

func close_book():
	is_book_open = false
	on_close_book.emit()


func _input(event):

	if is_book_open:
		if event.is_action_pressed("ritual_end"):
			close_book()

		return

	if input_locked:
		return

	

	if current_ritual != Ritual.Type.NONE:
		if event.is_action_pressed("ritual_end") or event.is_action_pressed("mouse_click"):
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
		elif event.is_action_pressed("open_book"):
			open_book()



func _on_click_book():
	if not input_locked:
		open_book()


func _on_click_knife():
	if not input_locked:
		start_ritual(Ritual.Type.BLOOD_SACRAFICE)


func _on_click_incense():
	if not input_locked:
		start_ritual(Ritual.Type.INCENSE)


func _on_click_hands():
	if not input_locked:
		start_ritual(Ritual.Type.HAND_SIGN)


func _on_click_prayerchain():
	if not input_locked:
		start_ritual(Ritual.Type.HUMMING)


func _on_click_drawer():
	if not input_locked:
		start_ritual(Ritual.Type.INGREDIANT)
