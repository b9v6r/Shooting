extends KinematicBody2D

var SPEED = [160,180, 200, 240, 280, 300, 340]
var rand_x
var rand_y

func _ready():
	SPEED = SPEED[randi() % SPEED.size()]
	rand_x = randi() % 2 * 2 - 1
	while rand_x == 0:
		rand_x = randi() % 2 * 2 - 1
	rand_y = randi() % 2 * 2 - 1
	while rand_y == 0:
		rand_y = randi() % 2 * 2 - 1

func _process(_delta):
	var random_direction = Vector2(rand_x, rand_y).normalized()
	var velocity = random_direction * SPEED * _delta
	var collision = move_and_collide(velocity)
	if position.y >= -100:
		rand_y = -rand_y
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("gg_contact"):
			collider.gg_contact()
			queue_free()
		if collider.has_method("rocket_contact"):
			collider.rocket_contact()
			queue_free()
		if collision.normal.x != 0 or collision.normal.y != 0:
			rand_x = randi() % 2 * 2 - 1
			while rand_x == 0:
				rand_x = randi() % 2 * 2 - 1
			rand_y = randi() % 2 * 2 - 1
			while rand_y == 0:
				rand_y = randi() % 2 * 2 - 1
	
func enemy_contact(): #Это нужно для проверки столкновения
	queue_free() 


