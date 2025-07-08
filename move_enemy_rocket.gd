extends KinematicBody2D

var speeds_pool = [300, 350, 400, 450, 500] 
var speed = speeds_pool[randi() % speeds_pool.size()] 

func _physics_process(delta):
	var collision = move_and_collide(Vector2.DOWN * speed * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("gg_contact"):
			collider.gg_contact()
			queue_free()
		if collider.has_method("rocket_contact"):
			collider.rocket_contact()
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func enemy_rocket_contact(): #Это нужно для проверки столкновения
	queue_free()
