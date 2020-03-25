extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var RES_FOOD
var RES_GOLD
var RES_WOOD

func _init():
	self.RES_FOOD = ResourceModel.new("Food", "Farmers")
	
func set_resource(res, amt):
	self[res].val += amt
	
func set_resource_with_workers(res, amt):
	self[res].val += amt * self[res].workers

func get_resource(res):
	return self[res]
	
func get_amount_from_resource(res):
	return {val_text = self[res].val_text, val = get_resource_value_with_suffix(self[res].val)}
	
func get_resource_value_with_suffix(amt):
	var suffix = "g"
	var out = str(amt)
	if int(amt) < pow(10, 6) && int(amt) >= pow(10, 3):
		suffix = "kg"
		out = str(amt / pow(10, 3))
	elif int(amt) < pow(10, 9) && int(amt) >= pow(10, 6):
		suffix = "Mg"
		out = str(amt / pow(10, 6))
	else:
		suffix = "g"
		out = str(amt)
	return {amt = out, suffix = suffix, formatted_amt = out + suffix}
	

class ResourceModel:
	
	var val
	var workers
	var val_text
	var work_text
	
	func _init(v_text, w_text):
		self.val = 0
		self.workers = 0
		self.val_text = v_text
		self.work_text = w_text
		
	func get_object():
		return self
	
