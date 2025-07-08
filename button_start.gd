extends TextureButton

const main_scene = "res://scenes/main.tscn"

func _pressed():
	load_scene_game_over()

func load_scene_game_over():
	var _change_scene = get_tree().change_scene(main_scene)
