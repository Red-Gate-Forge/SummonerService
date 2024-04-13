## Base class for all Ritual Handlers
class_name Ritual extends Node

enum Type {NONE, HAND_SIGN, HUMMING, INCENSE, INGREDIANT, BLOOD_SACRAFICE}

signal on_success
signal on_failure

var active: bool = false
var performed: bool = false

func begin():
    active = true
    performed = false

func end():
    active = false
    performed = true

func get_type() -> Ritual.Type:
    return Type.NONE

func compare_requirement(requirement: SummonStep) -> bool:
    return false
