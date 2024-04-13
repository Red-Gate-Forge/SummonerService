class_name Ritual extends Node

enum Type {NONE, HAND_SIGN, HUMMING, INCENSE, INGREDIANT, BLOOD_SACRAFICE}

signal on_success
signal on_failure

var active: bool = false

func begin():
    active = true

func end():
    active = false

func get_result() -> ResultData:
    var result = ResultData.new()
    result.ritual_id = 0
    result.payload = null
    return result

class ResultData:
    var ritual_id: int
    var payload