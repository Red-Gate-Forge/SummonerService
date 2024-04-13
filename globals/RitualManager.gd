class_name RitualManager extends Node

static var instance: RitualManager = null

static func get_instance() -> RitualManager:
	return instance

var summon_collection: SummonableCollection = null
var current_collection: Array[Summonable] = []
var current_ritual_count: int = 0
var current_summon: Summonable = null

func _ready():
	if instance != null:
		self.queue_free()
		return
	
	instance = self
	load_summon_collection()
	reset_summon_process()

		
func load_summon_collection():
	var collection = load("res://data/summonable/summonable_collection.tres") as SummonableCollection
	summon_collection = collection


func on_ritual_complete(ritual: Ritual):
	## Filter out summons that don't match the ritual
	var filter_list: Array[Summonable] = []
	for summon in current_collection:
		if summon.steps.size() <= current_ritual_count:
			filter_list.append(summon)
			continue
		if summon.steps[current_ritual_count].get_type() != ritual.get_type():
			filter_list.append(summon)
	
	for summon in filter_list:
		var index = current_collection.find(summon)
		current_collection.remove_at(index)

	## Abort if no summons left
	if current_collection.is_empty():
		print("No matching summon step left")
		summon_failed()
		return

	## perform requirement comparison for each summon
	for summon in current_collection:
		var requirement = summon.steps[current_ritual_count]
		var passed = ritual.compare_requirement(requirement)
		if passed:
			if current_ritual_count == summon.steps.size() - 1:
				current_summon = summon
				summon_succeeded()
				return

			summon_proceeds()
			return

	## If no summon step passed, fail the summon
	print("Matching summon step found but failed requirement comparison")
	summon_failed()



func summon_failed():
	print("Summon failed")
	reset_summon_process()

func summon_proceeds():
	print("Summon proceeds")
	current_ritual_count += 1

func summon_succeeded():
	print("Summon of " + current_summon.name + " was successful")

	reset_summon_process()

func reset_summon_process():
	current_collection = summon_collection.clone_collection()
	current_ritual_count = 0
