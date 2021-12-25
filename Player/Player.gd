extends KinematicBody

var velocity = Vector3.ZERO
var acceleration = 0.4
var friction = 0.2
var max_speed = 10

onready var meshInstance = $MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var input_vector = Vector3.ZERO
	# better code, ok for keyboard and controller
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# nomalizes speed when traveling in diagonal
	input_vector = input_vector.normalized()
	
	# if moving
	if input_vector != Vector3.ZERO:
		velocity += input_vector * acceleration
		# cap max speed
		velocity = clamped3(velocity, max_speed)
		
	else: # not moving
		velocity = velocity.move_toward(Vector3.ZERO, friction)
	
	# rotate ball mesh, not great idea to rotate the root node
	meshInstance.rotate_x(deg2rad(velocity.z))
	meshInstance.rotate_z(deg2rad(-velocity.x))
	
	velocity = move_and_slide(velocity) # collide and slide, no delta needed
	
# clamped func for Vector3, only works for (x,z) not y
func clamped3(vect3, limit):
	var vect2 = Vector2(vect3.x, vect3.z)
	vect2 = vect2.clamped(limit)
	return Vector3(vect2.x, vect3.y, vect2.y)
