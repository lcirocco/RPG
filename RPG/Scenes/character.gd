extends CharacterBody3D

@export var MAX_SPEED: int = 5
@export var SPEED: float = 5
@export var ACCELERATION: int = 30
@export var FRICTION: int = 15
@export var SENSITIVITY: float = 0.015
@export var LOWEST_ANGLE: int = -40
@export var HIGHEST_ANGLE: int = 60

@onready var axis:Vector3 = Vector3.ZERO
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Camera3D
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
func _unhandled_input(event):
	if(event is InputEventMouseMotion):
		rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(LOWEST_ANGLE), deg_to_rad(HIGHEST_ANGLE))
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("strife_left", "strife_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
