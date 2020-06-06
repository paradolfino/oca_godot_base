extends Node
var CAMP_MANAGER = preload("./Campaign_Manager.gd").new()
var RES_MANAGER = preload("./Resource_Manager.gd").new()
var PLAYER_MANAGER = preload("./Player_Manager.gd").new()
var DICTIONARY = preload("./Dictionary.gd").new()
var LOG = preload("./Logger.gd").new()
var UTILITIES = preload("./Utilities.gd").new()
var RESOURCES = DICTIONARY.ENUMS.RESOURCES
var PLAYER_ENUM = DICTIONARY.ENUMS.PLAYER

func update_tracker():
	$ResourceTracker.text = RES_MANAGER.get_resource_tracker_text()

func update_log():
	var text = LOG.get_log()
	$LogBox/ColorRect/LogText.text = text

func next_day():
#	RES_MANAGER.set_resource_with_workers(res, 1, 0)
	RES_MANAGER.set_all_resources_with_workers(1, 0) #does not increase worker numbers
	update_log()
	update_tracker()
	
func increase_resource(res):
	var resource = RES_MANAGER.get_resource(res)
	var result = RES_MANAGER.set_resource_with_harvest(res, PLAYER_MANAGER.get_efficiency_and_increase_gain()) #amount will be dynamic
	var msg = UTILITIES.string_builder("LOG_HARVEST", 
	["You", resource.action_text, RES_MANAGER.get_value_suffix(resource.suffix_template, result.by_amt).formatted_amt, resource.val_text])
	LOG.log_msg(msg)
	next_day()
	
func increase_workers(res):
	var result = RES_MANAGER.set_resource_with_workers(res, 1) #will be dynamic with skills
	next_day()
	
func check_has_enough(res, by_harvest = false):
	if RES_MANAGER.check_has_enough_resource(res, by_harvest) == true:
		RES_MANAGER.deplete_cost_items(res, by_harvest)
		if by_harvest == false:
			increase_workers(res)
		else:
			increase_resource(res)
	else:
		var msg = UTILITIES.string_builder("LOG_NO_RESOURCES")
		LOG.log_msg(msg)
		update_log()
	
# Lifecycle methods
func _ready():
	update_tracker()

#func _process(delta):
#	pass
	
	
# UI methods

func _on_rFood_pressed():
	increase_resource(RESOURCES.FOOD)
	
func _on_rWood_pressed():
	check_has_enough(RESOURCES.WOOD, true)
	
func _on_rIron_pressed():
	check_has_enough(RESOURCES.IRON, true)

func _on_rGold_pressed():
	check_has_enough(RESOURCES.GOLD, true)

func _on_rTools_pressed():
	check_has_enough(RESOURCES.TOOLS, true)

func _on_hFood_pressed():
	check_has_enough(RESOURCES.FOOD)

func _on_hWood_pressed():
	check_has_enough(RESOURCES.WOOD)
