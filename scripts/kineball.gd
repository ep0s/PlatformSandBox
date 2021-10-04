extends KinematicBody

#var rand_generate = RandomNumberGenerator.new()
var vec_pos = Vector3(0,0,0) 
var speed = 10
var rotspeed= 9
var gravity= -2
#var wind = 0.0
var jump_force = 45

var max_jumps = 3
var jumps_count = 0

func _ready():
	pass
	
func _physics_process(_delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vec_pos.z=0
	elif Input.is_action_pressed("ui_right"):
		vec_pos.z=-speed
		$model/AnimationPlayer.play("walkAction")
	elif Input.is_action_pressed("ui_left"):
		$model/AnimationPlayer.play_backwards("walkAction")
		vec_pos.z=speed
	else:
		vec_pos.z= lerp(vec_pos.z,0,0.2)
	
	# wind = rand_generate.randf_range(-1.0, 1.0)
	
	vec_pos.y += gravity
	#vec_pos.z += wind
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vec_pos.y = jump_force
		
	vec_pos = move_and_slide(Vector3(0, vec_pos.y, vec_pos.z),Vector3.UP)


func _on_Abyss_body_entered(body):
	if body.name == "KineBall":
		get_tree().change_scene("res://scenes/Level.tscn")


func _on_Enemy_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Sounds/hurt").play()
		$Timer2.start()


func _on_finish_area_body_entered(body):	
	get_parent().get_node("Sounds/win").play()
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Control.tscn")


func _on_Timer2_timeout():
	get_tree().change_scene("res://scenes/Level.tscn")


func _on_Coin_cn_collected():
	get_parent().get_node("Sounds/coinsnd").play()


func _on_t1_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Doors/door1/door1animp").play("d1animp")
#		
		var material = get_parent().get_node("triggers/t1/MeshInstance").get_surface_material(0)
		material.albedo_color = Color("14ff00")
		get_parent().get_node("triggers/t1/MeshInstance").set_surface_material(0, material)
		
		get_parent().get_node("triggers/t1").set_collision_layer_bit(0,false)
		get_parent().get_node("triggers/t1").set_collision_mask_bit(0,false)
		


func _on_t2_body_entered(body):
	get_parent().get_node("Doors/door2/leftside/AnimationPlayer").play("d2lsanimp")
	get_parent().get_node("Doors/door2/rightside/AnimationPlayer").play("d2rsanimp")
	
	var material = get_parent().get_node("triggers/t2/MeshInstance").get_surface_material(0)
	material.albedo_color = Color("14ff00")
	get_parent().get_node("triggers/t2/MeshInstance").set_surface_material(0, material)
	
	get_parent().get_node("triggers/t2").set_collision_layer_bit(0,false)
	get_parent().get_node("triggers/t2").set_collision_mask_bit(0,false)
