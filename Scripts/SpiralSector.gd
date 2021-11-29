tool
extends MeshInstance


func _ready():
	# In this function I create a 3D shape from it's vertices.
	# This is a very autistic way of doing this.
	# This method is useful because it allows us to control the parameters
	# of this shape using the variables in the Global script.
	# The shape itself is a sector of a spiral.
	
	# First we generate all the verices and store them in vertices1
	# Then we add them in a specific order to vertices2.
	
	var vertices1 = PoolVector3Array()
	
	var small_radius = Globals.SMALL_RADIUS
	var big_radius = Globals.SMALL_RADIUS + Globals.LANE_WIDTH * 3
	
	var i = 0.0
	var resolution = 4
	
	# Calculating all vertices
	while (i <= resolution):
		var theta = Globals.THETA_SEGMENT * i/resolution
		
		var v_1 = Vector3(
			small_radius * cos(theta),
			Globals.RISE_PER_TURN * (i/resolution) * (Globals.THETA_SEGMENT/TAU),
			- small_radius * sin(theta))
		var v_2 = Vector3(
			big_radius * cos(theta),
			Globals.RISE_PER_TURN * (i/resolution) * (Globals.THETA_SEGMENT/TAU),
			- big_radius * sin(theta))
		var v_3 = Vector3(
			small_radius * cos(theta),
			Globals.RISE_PER_TURN * (i/resolution) * (Globals.THETA_SEGMENT/TAU) - Globals.TRACK_THICKNESS,
			- small_radius * sin(theta))
		var v_4 = Vector3(
			big_radius * cos(theta),
			Globals.RISE_PER_TURN * (i/resolution) * (Globals.THETA_SEGMENT/TAU) - Globals.TRACK_THICKNESS,
			- big_radius * sin(theta))
		
		vertices1.append_array([v_1, v_2, v_3, v_4])
		
		i += 1
	
	var vertices2 = PoolVector3Array()

	# Initial face
	vertices2.append_array(rect_array(
		vertices1[0], vertices1[1], vertices1[2], vertices1[3]))
	
	# Top and side faces
	i = 0
	while (i < resolution):
		var i4 = i*4
		vertices2.append_array(rect_array(
			vertices1[i4+0], vertices1[i4+4], vertices1[i4+1], vertices1[i4+5]))
		vertices2.append_array(rect_array(
			vertices1[i4+1], vertices1[i4+5], vertices1[i4+3], vertices1[i4+7]))
		vertices2.append_array(rect_array(
			vertices1[i4+3], vertices1[i4+7], vertices1[i4+2], vertices1[i4+6]))
		vertices2.append_array(rect_array(
			vertices1[i4+2], vertices1[i4+6], vertices1[i4+0], vertices1[i4+4]))
		i+= 1
		
	# Final face
	vertices2.append_array(rect_array(
		vertices1[-3], vertices1[-4], vertices1[-1], vertices1[-2]))

	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices2
	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	var base_material_resource = load("res://Materials/BaseMaterial.tres")
	arr_mesh.surface_set_material(0, base_material_resource)
	var m = $"."
	m.mesh = arr_mesh
	

# Helper function to push a set of four vertices to the mesh
# Use carefully: the order matters
func rect_array(v_1, v_2, v_3, v_4):
	return PoolVector3Array([v_1, v_2, v_3, v_2, v_4, v_3])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
