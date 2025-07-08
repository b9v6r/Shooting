extends Node2D

var road = preload("res://elements/wall_takeoff.tscn")

var position1 = Vector2(0, 0)
var position2 = Vector2(0, -1390)
var position3 = Vector2(0, -2780)

var spawned_road_1
var spawned_road_2
var spawned_road_3

var speed = 400

func _ready():
	spawned_road_1 = road.instance()
	spawned_road_2 = road.instance()
	spawned_road_3 = road.instance()
	spawned_road_1.position = position1
	spawned_road_2.position = position2
	spawned_road_3.position = position3
	add_child(spawned_road_1)
	add_child(spawned_road_2)
	add_child(spawned_road_3)

func _process(delta):
	spawned_road_1.position.y += speed * delta
	spawned_road_2.position.y += speed * delta
	spawned_road_3.position.y += speed * delta
	
	if spawned_road_1.position.y >= 1390:
		spawned_road_1.queue_free()
		spawned_road_1 = road.instance()
		spawned_road_1.position = position3
		add_child(spawned_road_1)
	if spawned_road_2.position.y >= 1390:
		spawned_road_2.queue_free()
		spawned_road_2 = road.instance()
		spawned_road_2.position = position3
		add_child(spawned_road_2)
	if spawned_road_3.position.y >= 1390:
		spawned_road_3.queue_free()
		spawned_road_3 = road.instance()
		spawned_road_3.position = position3
		add_child(spawned_road_3)
