extends Node

var ENUMS

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
			GAIN = "GAIN"
		}
	}
	
