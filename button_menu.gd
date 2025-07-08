extends TextureButton

const menu_scene = "res://scenes/menu.tscn"

func _pressed():
	load_scene_menu()

func load_scene_menu():
	var _change_scene = get_tree().change_scene(menu_scene)
