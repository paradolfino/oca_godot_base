extends Node

# this is a singleton managing npc workers and such

var DICTIONARY = preload("./Dictionary.gd").new()
var NAMES = DICTIONARY.ENUMS.NAMES

var NAME
var AGE
var OCCUPATION
var FAMILY

func generate_name():
	pass

func _init():
	pass

class FamilyMemberModel:
	var NAME
	var RELATIONSHIP
	
	func _init():
		pass
