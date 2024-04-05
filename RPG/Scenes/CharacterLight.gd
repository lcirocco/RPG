extends OmniLight3D

var variance: float = 0.03
var minimum: float = 0.1
var maximum: float = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minLight = light_energy - variance
	var maxLight = light_energy + variance
	if(minLight < minimum):
		minLight = minimum
	if(maxLight > maximum):
		maxLight = maximum
	light_energy = randf_range(minLight, maxLight)
