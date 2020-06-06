extends Node


var ENUMS
var NAMES
var SUFFIX_TEMPLATES
var STRINGS

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
		PLAYER = {
			EFFICIENCY = "EFFICIENCY",
			GAIN = "GAIN",
			SKILL = "SKILL"
		},
		GAME = {
			DAY = "GAME_DAY"
		},
		EVENT_TYPES = {
			CAMPAIGN = "CAMPAIGN",
			QUEST = "QUEST",
			RANDOM = "RANDOM",
			BATTLE = "BATTLE"
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
#			SuffixModel.new("g", 1, 3),
			SuffixModel.new("kg", 3, 6),
			SuffixModel.new("T", 6, 9),
			SuffixModel.new("MT", 9, 12),
			SuffixModel.new("KT", 12, 15)
		],
		NON_WEIGHTED = [
			SuffixModel.new("", 1, 3),
			SuffixModel.new("k", 3, 6),
			SuffixModel.new("M", 6, 9),
			SuffixModel.new("B", 9, 12)
		]
	}
	
	self.STRINGS = {
		LOG_HARVEST = "%s %s %s %s",
		LOG_NO_RESOURCES = "Insufficient Resources!"
	}
	

	
class SuffixModel:
	var suffix
	var min_power
	var max_power
	
	func _init(suffix, min_power, max_power):
		self.suffix = suffix
		self.min_power = min_power
		self.max_power = max_power
	
