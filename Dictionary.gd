extends Node


var ENUMS
var NAMES

func _init():
	self.ENUMS = {
		RESOURCES = {
			FOOD = "RES_FOOD",
			GOLD = "RES_GOLD",
			WOOD = "RES_WOOD"
		},
		ACTIONS = {
			HIRE = "ACT_HIRE",
			WORK = "ACT_WORK"
		},
		PLAYER = {
			EFFICIENCY = "EFFICIENCY",
			GAIN = "GAIN",
			SKILL = "SKILL"
		}
	}
	
	self.NAMES = {
		FIRST = [
			"Al", "Alex", "Alice", 
			"Bradley", "Brady", "Barbara",
			"Calvin", "Charlie", "Chelsea",
			"David", "DJ", "Denise"
			],
		LAST_PREFIX = [
			"An", "Bar", "Chen", "Don", "Ed", "Fran"
		],
		LAST_MIDFIX = [
			"", "no", "an", "kar", "ver", "sin", "ras"
		],
		LAST_SUFFIX = [
			"", "ing", "ling", "er", "ar", "an", "en", "vich"
		]
		
	}
	
