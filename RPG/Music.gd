extends Node3D

var qPressed = false
var wPressed = false
var ePressed = false
var rPressed = false

var aPressed = false
var sPressed = false
var dPressed = false
var fPressed = false

var zPressed = false
var xPressed = false
var cPressed = false
var vPressed = false
var test: AudioStreamPlayer3D
var strings: Array = []

var pitchTarget = [.6, .8, 1, 1.2]

@onready
var timer:Timer = $StringTimer
# Called when the node enters the scene tree for the first time.
func _ready():
	strings.append($StringOne)
	strings.append($StringTwo)
	strings.append($StringThree)
	strings.append($StringFour)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(strings.size()):
		strings[i].max_db = 1
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Q and not qPressed:
			playSound(0, 0.6)
			qPressed = true;
			
		if !(event.pressed and event.keycode == KEY_Q):
			qPressed = false
			
		if event.pressed and event.keycode == KEY_W and not wPressed:
			playSound(1, 0.8)
			wPressed = true;
		if !(event.pressed and event.keycode == KEY_W):
			wPressed = false
			
		if event.pressed and event.keycode == KEY_E and not ePressed:
			playSound(2, 1)
			ePressed = true;
			
		if !(event.pressed and event.keycode == KEY_E):
			ePressed = false
			
		if event.pressed and event.keycode == KEY_R and not rPressed:
			playSound(3, 1.2)
			rPressed = true;
		if !(event.pressed and event.keycode == KEY_R):
			rPressed = false
			
			
		if event.pressed and event.keycode == KEY_A and not aPressed:
			playSound(0, 0.7)
			aPressed = true;
			
		if !(event.pressed and event.keycode == KEY_A):
			aPressed = false
			
		if event.pressed and event.keycode == KEY_S and not sPressed:
			playSound(1, 0.8)
			sPressed = true;
		if !(event.pressed and event.keycode == KEY_S):
			sPressed = false
			
		if event.pressed and event.keycode == KEY_D and not dPressed:
			playSound(2, 1)
			dPressed = true;
			
		if !(event.pressed and event.keycode == KEY_D):
			dPressed = false
			
		if event.pressed and event.keycode == KEY_F and not fPressed:
			playSound(3, 1.2)
			fPressed = true;
		if !(event.pressed and event.keycode == KEY_F):
			fPressed = false
			
		
		if event.pressed and event.keycode == KEY_Z and not zPressed:
			playSound(0, 0.8)
			zPressed = true;
			
		if !(event.pressed and event.keycode == KEY_Z):
			zPressed = false
			
		if event.pressed and event.keycode == KEY_X and not xPressed:
			playSound(1, 0.8)
			xPressed = true;
		if !(event.pressed and event.keycode == KEY_X):
			xPressed = false
			
		if event.pressed and event.keycode == KEY_C and not cPressed:
			playSound(2, 1)
			cPressed = true;
			
		if !(event.pressed and event.keycode == KEY_C):
			cPressed = false
			
		if event.pressed and event.keycode == KEY_V and not vPressed:
			playSound(3, 1.2)
			vPressed = true;
		if !(event.pressed and event.keycode == KEY_V):
			vPressed = false
		
		if (event.pressed and event.keycode == KEY_SPACE):
			for i in range(strings.size()):
				strings[i].stop(	)


func playSound(string: int, pitch: float):
	if(not strings[string].playing):
		strings[string].pitch_scale = pitch
		strings[string].play()
	else:
		pitchTarget[string] = pitch
		timer.start(0.1)
		pass
		
func changePitch():
	pass


func _on_string_timer_timeout():
	var repeat = false
	for i in range(strings.size()):
		if(int(strings[i].pitch_scale * 100) == int(pitchTarget[i] * 100)):
			break
		if(int(strings[i].pitch_scale * 100) < int(pitchTarget[i] * 100)):
			strings[i].pitch_scale += (pitchTarget[i] - strings[i].pitch_scale) / 3
			repeat = true
		if(int(strings[i].pitch_scale * 100) > int(pitchTarget[i] * 100)):
			strings[i].pitch_scale -= (strings[i].pitch_scale - pitchTarget[i]) / 3
			repeat = true
	if (repeat):
		timer.start(0.1)
	else:
		timer.stop()
