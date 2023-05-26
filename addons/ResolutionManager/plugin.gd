@tool
extends EditorPlugin

# Resolution menu button:
var resolution_menu_btn: MenuButton = null;

# Add menu button to canvas editor:
func _enter_tree() -> void:
	resolution_menu_btn = preload("ResolutionButton.tscn").instantiate();
	add_control_to_container(CONTAINER_CANVAS_EDITOR_MENU, resolution_menu_btn);
	
	resolution_menu_btn.resolution_set.connect(_on_resolution_set)


func _on_resolution_set() -> void:
	for open_scene_path in get_editor_interface().get_open_scenes():
		# This is a trick to save all current opened scenes before reloading them
		get_editor_interface().play_current_scene()
		get_editor_interface().stop_playing_scene()
		get_editor_interface().reload_scene_from_path(open_scene_path)


# Remove menu button from canvas editor:
func _exit_tree()-> void:
	remove_control_from_container(CONTAINER_CANVAS_EDITOR_MENU, resolution_menu_btn);
	resolution_menu_btn.queue_free();


# Plugin name:
func get_plugin_name()-> String:
	return "Resolution Manager";
