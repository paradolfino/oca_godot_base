extends Node

var RES_FOOD
var RES_GOLD
var RES_WOOD

func _init():
	self.RES_FOOD = ResourceModel.new("Food", "Farmers")
	
func set_resource(res, amt):
	self[res].val += amt
	
func set_resource_with_workers(res, amt, workers):
	self[res].workers += workers
	self[res].val += amt * self[res].workers

func get_resource(res):
	return self[res]
	
func get_amount_from_resource(res):
	return {
			workers = self[res].workers,
			workers_text = self[res].workers_text,
			val_text = self[res].val_text, 
			val = get_resource_value_with_suffix(self[res].val, self[res].workers, self[res].workers_output)
		}
	
func get_resource_value_with_suffix(amt, workers, workers_output):
	var workers_out = get_value_suffix(workers * workers_output)
	var resource_out = get_value_suffix(amt)
	
	return {
		amt = resource_out.amt, 
		suffix = resource_out.suffix, 
		formatted_amt = resource_out.amt + resource_out.suffix,
		workers_amt = workers_out.amt,
		formatted_workers_amt = workers_out.amt + workers_out.suffix
		}
		
func get_value_suffix(amt):
	var suffix = ''
	var out = 0
	if int(amt) < pow(10, 6) && int(amt) >= pow(10, 3):
		suffix = "kg"
		out = str(amt / pow(10, 3))
	elif int(amt) < pow(10, 9) && int(amt) >= pow(10, 6):
		suffix = "Mg"
		out = str(amt / pow(10, 6))
	else:
		suffix = "g"
		out = str(amt)
	
	out = str(stepify(float(out), 0.01))
	
	return {amt = out, suffix = suffix}
	

class ResourceModel:
	
	var val
	var workers
	var val_text
	var workers_text
	var workers_output
	
	func _init(v_text, w_text):
		self.val = 0
		self.workers = 0
		self.workers_output = 1
		self.val_text = v_text
		self.workers_text = w_text
		
	func get_object():
		return self
	
