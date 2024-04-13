extends Ritual

var count: int = 0

func begin():
    super.begin()
    count = 0
    perform()

func end():
    super.end()

func get_result() -> ResultData:
    var result = ResultData.new()
    result.ritual_id = Ritual.Type.BLOOD_SACRAFICE
    result.payload = count

    return result

func perform():
    while active:
        print("Ping")
        count += 1
        await get_tree().create_timer(0.8).timeout
        

