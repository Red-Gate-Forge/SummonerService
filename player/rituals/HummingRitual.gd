extends Ritual

## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()

func end(): #override
    super.end()

func get_type() -> Ritual.Type: #override
    return Type.HUMMING

func compare_requirement(requirement: SummonStep) -> bool: #override
    var humming_requirement = requirement as HummingSummonStep
    if humming_requirement == null:
        print("IncenseSummonStep is null")
        return false

    if humming_requirement.get_content():
        print("Incense count does not match")
        return false

    return true

## Ritual Type Interface END ##