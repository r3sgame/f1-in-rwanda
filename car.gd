extends RigidBody3D

var active = false
var time = -8
var forward_force = 15000
var backward_force = 10000

func _ready() -> void:
	await get_tree().create_timer(8.0).timeout
	active = true

func _physics_process(delta: float) -> void:	
	if active:
		time += delta
		if (Input.is_key_pressed(KEY_UP)):
			apply_force(Vector3(-forward_force*cos(rotation.y), 0, forward_force*sin(rotation.y)))
		if (Input.is_key_pressed(KEY_DOWN)):
			apply_force(Vector3(backward_force*cos(rotation.y), 0, -backward_force*sin(rotation.y)))
		if (Input.is_key_pressed(KEY_LEFT)):
			angular_velocity = Vector3(0, 1, 0)
		elif (Input.is_key_pressed(KEY_RIGHT)):
			angular_velocity = Vector3(0, -1, 0)
		else:
			angular_velocity = Vector3(0, 0, 0)

func _on_finish_body_entered(body: Node3D) -> void:
	print("finish")
	active = false# Replace with function body.
