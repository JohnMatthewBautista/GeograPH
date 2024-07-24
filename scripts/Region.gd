extends Node
class_name Region

var fullname : String
var group : String
var center: String
var number : int
var lgus: PackedStringArray

func _init(name: String, island_group: String, region_center: String, number: int, lgu_list : PackedStringArray):
	self.fullname = name
	self.group = island_group
	self.center = region_center
	self.number = number
	self.lgus = lgu_list
