extends RigidBody3D

var active = false
var time = 0
var forward_force = 16500
var backward_force = 10000

func _ready() -> void:
	await get_tree().create_timer(4.0).timeout
	get_node("Start Sound").playing = true
	await get_tree().create_timer(3.0).timeout
	active = true

func _physics_process(delta: float) -> void:	
	get_parent().get_node("HUD/Speed Indicator/Speed").text = "[center]" + str(round(2.237 * sqrt(pow(linear_velocity.x, 2) + pow(linear_velocity.z, 2)))) + " MPH"
		
	if (Input.is_key_pressed(KEY_R)):
		get_tree().reload_current_scene()
	
	if active:
		time += delta
		get_parent().get_node("HUD/Clock Holder/Clock").text = "%10.2f" % time
		
		if (Input.is_key_pressed(KEY_UP)):
			apply_force(Vector3(-forward_force*cos(rotation.y), 0, forward_force*sin(rotation.y)))
			if !get_node("Revved Engine").playing:
				get_node("Revved Engine").playing = true
				get_node("Ambient Engine").playing = false
		elif get_node("Revved Engine").playing:
			get_node("Ambient Engine").playing = true
			get_node("Revved Engine").playing = false
			
		if (Input.is_key_pressed(KEY_DOWN)):
			apply_force(Vector3(backward_force*cos(rotation.y), 0, -backward_force*sin(rotation.y)))
		if (Input.is_key_pressed(KEY_LEFT)):
			angular_velocity = Vector3(0, 1, 0)
		elif (Input.is_key_pressed(KEY_RIGHT)):
			angular_velocity = Vector3(0, -1, 0)
		else:
			angular_velocity = Vector3(0, 0, 0)

func _on_finish_body_entered(body: Node3D) -> void:
	if body.name == "Car":
		active = false
		get_node("Ambient Engine").playing = true
		get_node("Revved Engine").playing = false
		get_node("Finish Sound").playing = true
		get_parent().get_node("HUD/AnimationPlayer").play("Finish")
