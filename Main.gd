extends Node
var RES_MANAGER = preload("./Resource_Manager.gd").new()
var PLAYER_MANAGER = preload("./Player_Manager.gd").new()
var DICTIONARY = preload("./Dictionary.gd").new()
var RESOURCES = DICTIONARY.ENUMS.RESOURCES
var PLAYER_ENUM = DICTIONARY.ENUMS.PLAYER

func get_resource(res, attr):
	return RES_MANAGER.get_resource(res)[attr]
	
func get_resource_tracker_text():
	var resource_strings = {
		FOOD = RES_MANAGER.get_amount_from_resource(RESOURCES.FOOD)
	}
	
	var tracker_text = ""
	
	for i in resource_strings:
		var string = resource_strings[i].val_text + ": " + resource_strings[i].val.formatted_amt
		tracker_text += string
	
	return "[ %s ]" % tracker_text
	
func update_tracker():
	$Label.text = get_resource_tracker_text()

func next_day():
	update_tracker()
	
	
	
# Lifecycle methods
func _ready():
	update_tracker()

func _process(delta):
	pass
	
	
# UI methods

func _on_Button_pressed():
	RES_MANAGER.set_resource(RESOURCES.FOOD, 1 * PLAYER_MANAGER.get_efficiency_and_increase_gain())
	next_day()
