extends Node

var EFFICIENCY
var GAIN

func _init():
	self.EFFICIENCY = 0.1
	self.GAIN = 0.001
	
func get_efficiency():
	return self.EFFICIENCY
	
func get_efficiency_and_increase_gain():
	var original_eff = self.EFFICIENCY
	var new_eff = self.EFFICIENCY + self.GAIN
	self.EFFICIENCY = new_eff
	return original_eff
