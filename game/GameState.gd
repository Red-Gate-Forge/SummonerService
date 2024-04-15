class_name GameState extends RefCounted

var health: int = 100 
var current_order: Summonable = null



func get_health():
    return health

func get_current_order():
    return current_order