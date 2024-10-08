extends Node

var McGuffins = 0
var battery = 0.5
var run = false
var seen = false
var carfix = 0
var waiting = false
var current_map = "Main"
var tutorial = true

var main_mcguffin = false
var main_battery = false
var pier_mcguffin = false
var pier_battery = false
var tower_mcguffin = false
var tower_battery = false
var mansion_mcguffin = false
var mansion_battery = false
var cavern_mcguffin = false
var cavern_battery = false

func _ready():
	McGuffins = 0
	battery = 0.5

func GetMcGuffin():
	McGuffins += 1

func GetBattery():
	battery = clampf(battery + 0.5, 0.0, 1.0)
