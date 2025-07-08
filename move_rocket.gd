extends KinematicBody2D

const SPEED = 600.0

func _physics_process(delta):
	var collision = move_and_collide(Vector2.UP * SPEED * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("enemy_contact"):
			collider.enemy_contact()
			queue_free()
		if collider.has_method("enemy_rocket_contact"):
			collider.enemy_rocket_contact()
			queue_free()
		if collider.has_method("boss_enemy_contact"):
			collider.boss_enemy_contact()
			queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func rocket_contact(): #Это нужно для проверки столкновения
	queue_free()
