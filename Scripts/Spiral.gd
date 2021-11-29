tool
extends Spatial

# TODO: unifiy "sectors" and "sections" references

var sectors = []
var spiral_sector_resource

# Called when the node enters the scene tree for the first time.
func _ready():
	spiral_sector_resource = load('res://Scenes/SpiralSector.tscn')
	
	var i = 0
	while (i < Globals.TOTAL_SECTORS):
		var load_spiral_sector = spiral_sector_resource.instance()
		load_spiral_sector.translation.y = i * Globals.RISE_PER_TURN * (Globals.THETA_SEGMENT/TAU)
		load_spiral_sector.rotation.y = i * Globals.THETA_SEGMENT
		add_child(load_spiral_sector)
		sectors.append(load_spiral_sector)
		
		i+= 1

func _process(delta):
	var delta_theta = delta * Globals.MENU_SPEED
	for sector in sectors:
		sector.translation.y -= Globals.RISE_PER_TURN * delta_theta / TAU
		sector.rotation.y -= delta_theta
		
	var fall_speed = Globals.FALL_DISTANCE * Globals.MENU_SPEED / Globals.THETA_SEGMENT
	sectors[0].translation.y -= 0.5 * fall_speed * delta
	if (sectors[0].translation.y <= -Globals.FALL_DISTANCE):
		var sector = sectors.pop_front()
		sector.translation.y = Globals.TOTAL_SECTORS * Globals.RISE_PER_TURN * (Globals.THETA_SEGMENT/TAU)
#		sector.rotation.y = Globals.TOTAL_SECTORS * Globals.THETA_SEGMENT
		sectors.push_back(sector)
