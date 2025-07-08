extends KinematicBody2D

const SPEED = 350.0  # Увеличьте значение для увеличения скорости движения
const ACCELERATION = 3.0  # Задайте значение ускорения

var velocity = Vector2(0, 0)
var is_input_active = false
var input_direction = Vector2(0, 0)
var pos_y

signal anim_move_gg_left
signal anim_move_gg_right
signal anim_return_move_gg

func _physics_process(_delta):
	pos_y = position.y
	if pos_y <= 170:
		input_direction.y = 1
		
	if is_input_active == true and input_direction.x >= 1:
		emit_signal("anim_move_gg_left")
		
	if is_input_active == true and input_direction.x <= -1:
		emit_signal("anim_move_gg_right")
		
	if is_input_active == false:
		emit_signal("anim_return_move_gg")		
		
	if is_input_active:
		# Выполняйте линейную интерполяцию для изменения скорости
		velocity = velocity.linear_interpolate(input_direction * SPEED, ACCELERATION * _delta)
		velocity = move_and_slide(velocity)
	else:
		# Если ввод не активен, замедляем объект
		velocity = velocity.linear_interpolate(Vector2(0, 0), ACCELERATION * _delta)
		velocity = move_and_slide(velocity)
	var collision = move_and_collide(velocity * _delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("enemy_contact"):
			collider.enemy_contact()
			queue_free()
		if collider.has_method("enemy_rocket_contact"):
			collider.enemy_rocket_contact()
			queue_free()
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				is_input_active = true
			else:
				is_input_active = false
				input_direction = Vector2(0, 0)

func _unhandled_input(event):
	if is_input_active:
		if event is InputEventMouseMotion:
			# Определяем направление движения в зависимости от движения мыши
			input_direction = Vector2(0, 0)
			if event.relative.y < 0:
				input_direction.y = -1
			elif event.relative.y > 0:
				input_direction.y = 1
			if event.relative.x < 0:
				input_direction.x = -1
			elif event.relative.x > 0:
				input_direction.x = 1
				
func gg_contact(): #Это нужно для проверки столкновения
	queue_free()
