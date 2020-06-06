extends Node

var HISTORY = []


func log_msg(msg):
	if (self.HISTORY.size() > 20):
		self.HISTORY.remove(self.HISTORY.size() - 1)
		
	self.HISTORY.push_front(msg)
	
	
func get_log():
	return PoolStringArray(self.HISTORY).join("\n")

func _init():
	pass
