extends Ritual

var count: int = 0

func perform():
    while active:
        print("Ping")
        performed = true
        count += 1
        await get_tree().create_timer(2.0).timeout

## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()
    count = 0
    perform()

func end(): #override
    super.end()

func get_type() -> Ritual.Type: #override
    return Type.INCENSE
        
func compare_requirement(requirement: SummonStep) -> bool: #override
    var incense_requirement = requirement as IncenseSummonStep
    if incense_requirement == null:
        print("IncenseSummonStep is null")
        return false

    if incense_requirement.get_content() != count:
        print("Incense count does not match")
        return false

    return true

## Ritual Type Interface END ##