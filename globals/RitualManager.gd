class_name RitualManager extends Node

static var instance: RitualManager = null

static func get_instance() -> RitualManager:
	return instance

var summon_collection: SummonableCollection = null
var current_collection: Array[Summonable] = []

func _ready():
	if instance != null:
		self.queue_free()
		return
	
	instance = self

		
func load_summon_collection():
	var collection = load("res://data/summonable/summonable_collection.tres") as SummonableCollection
	summon_collection = collection


func on_ritual_complete(ritual: Ritual):
	var result = ritual.get_result()


func reset_summon_process():
	current_collection = summon_collection.get_collection()