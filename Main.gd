extends Node
var RES_MANAGER = preload("./Resource_Manager.gd").new()
var PLAYER_MANAGER = preload("./Player_Manager.gd").new()
var DICTIONARY = preload("./Dictionary.gd").new()
var RESOURCES = DICTIONARY.ENUMS.RESOURCES
var PLAYER_ENUM = DICTIONARY.ENUMS.PLAYER

func update_tracker():
	$ResourceTracker.text = RES_MANAGER.get_resource_tracker_text()

func next_day(res):
#	RES_MANAGER.set_resource_with_workers(res, 1, 0)
	RES_MANAGER.set_all_resources_with_workers(1, 0)
	update_tracker()
	
func increase_resource(res):
	RES_MANAGER.set_resource(res, 1 * PLAYER_MANAGER.get_efficiency_and_increase_gain()) #amount will be dynamic
	next_day(res)

func increase_workers(res):
	RES_MANAGER.set_resource_with_workers(res, 1, 1) #will be dynamic with skills
	next_day(res)
	
func check_has_enough(res):
	if RES_MANAGER.check_has_enough_resource(res) == true:
		RES_MANAGER.deplete_cost_items(res)
		increase_workers(res)
	else:
		# invalid, disable button? alert message?
		pass
	
# Lifecycle methods
func _ready():
	update_tracker()

#func _process(delta):
#	pass
	
	
# UI methods

func _on_rFood_pressed():
	increase_resource(RESOURCES.FOOD)

func _on_hFood_pressed():
	increase_workers(RESOURCES.FOOD)

func _on_hWood_pressed():
	check_has_enough(RESOURCES.WOOD)
