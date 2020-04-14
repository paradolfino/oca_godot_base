extends Node
var DICTIONARY = preload("./Dictionary.gd").new()
var RESOURCES = DICTIONARY.ENUMS.RESOURCES
var PLAYER = DICTIONARY.ENUMS.PLAYER
var SUFFIX_TEMPLATES = DICTIONARY.SUFFIX_TEMPLATES

var RES_FOOD : ResourceModel
var RES_GOLD : ResourceModel
var RES_WOOD : ResourceModel
var RES_IRON : ResourceModel
var RES_TOOLS : ResourceModel

func _init():
	self.RES_FOOD = ResourceModel.new(
		"Food", 
		"Farmers", 
		[
			CostItemModel.new(1, RESOURCES.GOLD),
			CostItemModel.new(1, RESOURCES.TOOLS)
		],
		SUFFIX_TEMPLATES.WEIGHTED)
	self.RES_WOOD = ResourceModel.new(
		"Wood", 
		"Lumberjacks", 
		[
			CostItemModel.new(10, RESOURCES.FOOD),
			CostItemModel.new(1, RESOURCES.TOOLS)
		],
		SUFFIX_TEMPLATES.WEIGHTED)
	self.RES_GOLD = ResourceModel.new(
		"Gold", 
		"Gold Miners", 
		[
			CostItemModel.new(10, RESOURCES.FOOD), 
			CostItemModel.new(1, RESOURCES.TOOLS)
		],
		SUFFIX_TEMPLATES.WEIGHTED)
	self.RES_IRON = ResourceModel.new(
		"Iron",
		"Iron Miners",
		[
			CostItemModel.new(10, RESOURCES.FOOD), 
			CostItemModel.new(1, RESOURCES.TOOLS)
		],
		SUFFIX_TEMPLATES.WEIGHTED
	)
	self.RES_TOOLS = ResourceModel.new(
		"Tools", 
		"Toolmakers", 
		[
			CostItemModel.new(5, RESOURCES.GOLD),
			CostItemModel.new(2, RESOURCES.FOOD),
			CostItemModel.new(1, RESOURCES.WOOD),
			CostItemModel.new(1, RESOURCES.IRON)
		],
		SUFFIX_TEMPLATES.NON_WEIGHTED
		)
		

func set_cost_val(res, multiplier):
	for c in self[res].cost_items:
		self[c.resource].cost_val += c.val * multiplier

func set_resource(res, amt):
	self[res].val += amt
	
func set_resource_with_workers(res, amt, workers):
	self[res].workers += workers
	set_cost_val(res, workers)
	self[res].val += (amt * self[res].workers) - self[res].cost_val

func get_resource(res):
	return self[res]
	
func get_amount_from_resource(res):
	return {
			workers = self[res].workers,
			workers_text = self[res].workers_text,
			val_text = self[res].val_text, 
			val = get_resource_value_with_suffix(
				self[res].suffix_template,
				self[res].val, 
				self[res].workers, 
				self[res].workers_output, 
				self[res].cost_val)
		}
	
func get_resource_value_with_suffix(suffix_template, amt, workers, workers_output, cost):
	var workers_out = get_value_suffix(suffix_template, (workers * workers_output) - cost)
	var resource_out = get_value_suffix(suffix_template, amt)
	
	return {
		amt = resource_out.amt, 
		suffix = resource_out.suffix, 
		formatted_amt = resource_out.amt + resource_out.suffix,
		workers_amt = workers_out.amt,
		formatted_workers_amt = workers_out.amt + workers_out.suffix
		}
		
func get_value_suffix(suffix_template, amt):
	var suffix = ''
	var out = 0
#	if int(amt) < pow(10, 6) && int(amt) >= pow(10, 3):
#		suffix = "kg"
#		out = str(amt / pow(10, 3))
#	elif int(amt) < pow(10, 9) && int(amt) >= pow(10, 6):
#		suffix = "Mg"
#		out = str(amt / pow(10, 6))
#	else:
#		suffix = "g"
#		out = str(amt)
		
		
	if int(amt) < pow(10, suffix_template[0].max_power) && int(amt) >= 0 || int(amt) < 0:
		suffix = suffix_template[0].suffix
		out = str(amt)
	else:
		suffix_template = suffix_template.remove(0)
		for template in suffix_template:
			if int(amt) < pow(10, template.max_power) && int(amt) > template.min_power:
				suffix = template.suffix
				out = str(amt / pow(10, template.min_power))
				break
	
	out = str(stepify(float(out), 0.01))
	
	return {amt = out, suffix = suffix}
	
func get_resource_tracker_text():
	build_resource_strings()
#	var resource_strings = {
#		FOOD = get_amount_from_resource(RESOURCES.FOOD),
#		WOOD = get_amount_from_resource(RESOURCES.WOOD),
#		GOLD = get_amount_from_resource(RESOURCES.GOLD)
#	}
	
	var resource_strings = build_resource_strings()
	
	var tracker_text = ""
	var workers_tracker_text = ""
	
	for i in resource_strings:
		var string = resource_strings[i].val_text + ": " + resource_strings[i].val.formatted_amt
		tracker_text += string
		
		var workers_string = resource_strings[i].workers_text + ": " + str(resource_strings[i].workers)
		workers_tracker_text += workers_string + "\n "
		
		tracker_text += " (%s / day)\n" % resource_strings[i].val.formatted_workers_amt
	
	return "[Resources]\n%s\n\n[Workers]\n%s\n" % [tracker_text, workers_tracker_text]
	
func build_resource_strings():
	var resource_strings = {}
	var resources = self.get_property_list()
	for res in resources:
		if "RES_" in res.name:
			var name = res.name.split("_")[1]
			resource_strings[name] = get_amount_from_resource(RESOURCES[name])
	return resource_strings
	
func set_all_resources_with_workers(amt, workers):
	for res in RESOURCES:
		set_resource_with_workers(RESOURCES[res], amt, workers)

func deplete_cost_items(res):
	var items = self[res].cost_items
	for item in items:
		self[item.resource].val -= item.val

func check_has_enough_resource(res):
	var has_enough = false
	var items = self[res].cost_items
	if items.size() > 0:
		for item in items:
			if self[item.resource].val >= item.val:
				has_enough = true
			else:
				break
	else:
		has_enough = true
		pass
	
	return has_enough

class ResourceModel:
	
	var val
	var workers
	var val_text
	var workers_text
	var workers_output
	var cost_val
	var cost_items
	var suffix_template
	
	func _init(v_text, w_text, cost_items, suffix_template):
		self.val = 0
		self.workers = 0
		self.workers_output = 1
		self.cost_val = 0
		self.val_text = v_text
		self.workers_text = w_text
		self.cost_items = cost_items
		self.suffix_template = suffix_template
		
	func get_object():
		return self
		
class CostItemModel:
	var val
	var resource
	
	func _init(val, res):
		self.val = val
		self.resource = res
