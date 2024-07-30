extends Node
class_name Region

var fullname : String
var group : String
var center: String
var number : String
var lgus: PackedStringArray

static func rand_region_name(regions : Array[Region]):
	var reg = regions.pick_random()
	return reg.fullname

func _init(input_name: String, island_group: String, region_center: String, region_number: String, lgu_list : PackedStringArray):
	self.fullname = input_name
	self.group = island_group
	self.center = region_center
	self.number = region_number
	self.lgus = lgu_list

func rand_lgu():
	return lgus[randi_range(0, lgus.size() - 1)]
