class_name SummonableCollection extends Resource

@export var collection: Array[Summonable] = []

func clone_collection () -> Array[Summonable]:
    var clone = collection.duplicate(false)
    return clone