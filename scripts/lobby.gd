extends Control


var fadein_timer
var fadeout_timer

var rect_material
var material_cutoff = 0.0

func _init():
	
	fadein_timer = Timer.new()
	add_child(fadein_timer)
	fadein_timer.autostart = false
	fadein_timer.wait_time = 0.05
	fadein_timer.connect("timeout", self, "_fadein")
	
	fadeout_timer = Timer.new()
	add_child(fadeout_timer)
	fadeout_timer.autostart = false
	fadeout_timer.wait_time = 0.05
	fadeout_timer.connect("timeout", self, "_fadeout")


func _ready():
	$fade_in.visible = true
	rect_material = $fade_in.get_material()
	fadein_timer.start()
	
func _fadein():
	rect_material.set_shader_param("cutoff", material_cutoff)
	if (material_cutoff == 1.0):
		fadein_timer.stop()
		return
		
	material_cutoff += 0.1

func _fadeout():
	rect_material.set_shader_param("cutoff", material_cutoff)
	if (material_cutoff == 0.0):
		fadeout_timer.stop()
		return
	material_cutoff -= 0.1