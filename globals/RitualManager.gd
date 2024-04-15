class_name RitualManager extends Node

static var instance: RitualManager = null

static func get_instance() -> RitualManager:
	return instance

signal on_summon_failed
signal on_summon_proceeds
signal on_summon_succeeded(summonable: Summonable)

var summon_collection: SummonableCollection = null
var current_collection: Array[Summonable] = []
var current_ritual_count: int = 0
var current_summon: Summonable = null
var filter_list: Array[Summonable] = []

func _ready():
	if instance != null:
		self.queue_free()
		return
	
	instance = self
	load_summon_collection()
	reset_summon_process()
	print("RitualManager ready")

		
func load_summon_collection():
	var collection = load("res://data/summonable/summonable_collection.tres") as SummonableCollection
	summon_collection = collection

func remove_filtered():
	for summon in filter_list:
		var index = current_collection.find(summon)
		current_collection.remove_at(index)

	filter_list.clear()

func on_ritual_complete(ritual: Ritual):
	## Filter out summons that don't match the ritual type
	for summon in current_collection:
		if summon.steps.size() <= current_ritual_count:
			filter_list.append(summon)
			continue
		if summon.steps[current_ritual_count].get_type() != ritual.get_type():
			filter_list.append(summon)

	remove_filtered()

	## Abort if no summons left
	if current_collection.is_empty():
		print("No matching summon step left")
		summon_failed()
		return


	var passed = false
	## perform requirement comparison for each summon
	for summon in current_collection:
		var requirement = summon.steps[current_ritual_count]
		if ritual.compare_requirement(requirement):
			passed = true
		else:
			filter_list.append(summon)

		if passed:
			if current_ritual_count == summon.steps.size() - 1:
				current_summon = summon
				summon_succeeded()
				return

	remove_filtered()

	if passed:
		summon_proceeds()
		return

	## If no summon step passed, fail the summon
	print("Matching summon step found but failed requirement comparison")
	summon_failed()



func summon_failed():
	print("Summon failed. No possible summon left. Reset.")
	reset_summon_process()
	emit_signal("on_summon_failed")

func summon_proceeds():
	print("Summon proceeds. Possible summons left: " + str(current_collection.size()))
	current_ritual_count += 1
	emit_signal("on_summon_proceeds")

func summon_succeeded():
	print("Summon of " + current_summon.name + " was successful. Reset.")
	reset_summon_process()
	emit_signal("on_summon_succeeded", current_summon)

func reset_summon_process():
	current_collection = summon_collection.clone_collection()
	current_ritual_count = 0
