extends KinematicBody2D

var SPEED = [160,180, 200, 240, 280, 300, 340]
var rand_x
var rand_y
var rocket_contact_enemy_boss = 0

signal check_boss_kill
signal boss_animation_left
signal boss_animation_right

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
	if rocket_contact_enemy_boss >= 3:
		emit_signal("check_boss_kill")
		queue_free()
	if rocket_contact_enemy_boss >= 1:
		$anim_flame1.visible = true
	if rocket_contact_enemy_boss >= 2:
		$anim_flame2.visible = true
		
	if random_direction.x >= 0.7 and random_direction.x != 0:
		emit_signal("boss_animation_right")
	elif random_direction.x <= -0.7 and random_direction.x != 0:
		emit_signal("boss_animation_left")
	
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("gg_contact"):
			collider.gg_contact()
			rocket_contact_enemy_boss += 1
		if collider.has_method("rocket_contact"):
			collider.rocket_contact()
			rocket_contact_enemy_boss += 1
		if collision.normal.x != 0 or collision.normal.y != 0:
			rand_x = randi() % 2 * 2 - 1
			while rand_x == 0:
				rand_x = randi() % 2 * 2 - 1
			rand_y = randi() % 2 * 2 - 1
			while rand_y == 0:
				rand_y = randi() % 2 * 2 - 1
	
func boss_enemy_contact(): #Это нужно для проверки столкновения
	rocket_contact_enemy_boss += 1


