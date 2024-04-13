class_name SummonableCollection extends Resource

@export var collection: Array[Summonable] = []

func get_collection () -> Array[Summonable]:
    return collection.duplicate(false)