extends Area

signal exploded

export var muzzle_velocity = 35
export var g = Vector3.DOWN * 5

var velocity = Vector3.ZERO


func _physics_process(delta):
	velocity += g * delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta


#func _on_Shell_body_entered(body):
#	emit_signal("exploded", transform.origin)
#	queue_free()
