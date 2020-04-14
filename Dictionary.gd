extends Node


var ENUMS
var NAMES
var SUFFIX_TEMPLATES

func _init():
	self.ENUMS = {
		RESOURCES = {
			FOOD = "RES_FOOD",
			GOLD = "RES_GOLD",
			WOOD = "RES_WOOD",
			IRON = "RES_IRON",
			
			# special
			TOOLS = "RES_TOOLS"
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
	
	self.SUFFIX_TEMPLATES = {
		WEIGHTED = [
			SuffixModel.new("g", 1, 3),
			SuffixModel.new("kg", 3, 6),
			SuffixModel.new("Mg", 6, 9),
			SuffixModel.new("Bg", 9, 12)
		],
		NON_WEIGHTED = [
			SuffixModel.new("", 1, 3),
			SuffixModel.new("k", 3, 6),
			SuffixModel.new("M", 6, 9),
			SuffixModel.new("B", 9, 12)
		]
	}
	
class SuffixModel:
	var suffix
	var min_power
	var max_power
	
	func _init(suffix, min_power, max_power):
		self.suffix = suffix
		self.min_power = min_power
		self.max_power = max_power
	
