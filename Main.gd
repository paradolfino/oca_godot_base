extends Node
var MANAGER = preload("./Resource_Manager.gd").new()
var DICTIONARY = preload("./Dictionary.gd").new()
var RESOURCES = DICTIONARY.ENUMS.RESOURCES

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func get_resource(res, attr):
	return MANAGER.get_resource(res)[attr]
	
func get_resource_tracker_text():
	var resource_strings = {
		FOOD = MANAGER.get_amount_from_resource(RESOURCES.FOOD)
	}
	
	var tracker_text = ""
	
	for i in resource_strings:
		var string = resource_strings[i].val_text + ": " + resource_strings[i].val.formatted_amt
		tracker_text += string
	
	return "[ %s ]" % tracker_text

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Label.text = get_resource_tracker_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	pass # Replace with function body.
