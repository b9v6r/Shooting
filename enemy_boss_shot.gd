extends CollisionPolygon2D

const bullet_scene = preload("res://elements/enemy_rocket.tscn")
const enemy_bullets_path = "/root/main/enemy_bullets"

var enemy_bullets

func _ready():
	shot()
	
func shot():
	enemy_bullets = get_node(enemy_bullets_path)
	var bullet = bullet_scene.instance()
	bullet.set_as_toplevel(true)
	bullet.global_position = global_position + Vector2(0,130)
	enemy_bullets.add_child(bullet)

func _on_ShotTimer_timeout():
	shot()
