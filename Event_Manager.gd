extends Node

var event_list = {}

func check_events(ids = []):
	pass
	
func log_event():
	pass
	
func exec_event():
	pass

func _init():
	pass
	
	
class EventModel:
	
	var type
	var id
	var title
	var description
	var log_output
	var chance_to_occur
	var days_to_occur
	
	func _init(data):
		self.type = data.type
		self.id = data.id
		self.title = data.title
		self.description = data.description
		self.log_output = data.log_output
		self.days_to_occur = data.day_to_occur
