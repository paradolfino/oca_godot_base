extends Node
var DICTIONARY = preload("./Dictionary.gd").new()

func string_builder(string, array = []):
	var out = DICTIONARY.STRINGS[string] % array
	return out

func _init():
	pass
