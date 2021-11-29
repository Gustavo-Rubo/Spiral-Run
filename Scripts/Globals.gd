tool
extends Node

var SMALL_RADIUS = 1.50
var LANE_WIDTH = 0.40
var RISE_PER_TURN = 3.0
var TRACK_THICKNESS = 0.2
var FALL_DISTANCE = 0.6

# It's good to make these numbers multiples, so that the spiral makes full turns
# because it makes it easier to then get the sector from the bottom and put it on top,
# as we don't have to alter it's rotation.
var THETA_SEGMENT = PI/10
var TOTAL_SECTORS = 40

# Angular speeds
var MENU_SPEED = 0.3
var MID_SPEED = 1.8
var SPEEDS = [
	MID_SPEED*(SMALL_RADIUS + LANE_WIDTH * 3/2)/(SMALL_RADIUS + LANE_WIDTH * 1/2), # High Speed
	MID_SPEED, # Mid Speed
	MID_SPEED*(SMALL_RADIUS + LANE_WIDTH * 3/2)/(SMALL_RADIUS + LANE_WIDTH * 5/2) # Low Speed
]
