@tool
extends EditorContextMenuPlugin
class_name OZResourceInstancerContextMenuPlugin

func _popup_menu(paths: PackedStringArray) -> void:
	if paths.is_empty():
		return
	
	var all_script_paths: Array[StringName] = []
	var all_new_resource_paths: Array[StringName] = []
	for path in paths:
		if path.get_extension() == "gd":
			all_script_paths.append(path)
			all_new_resource_paths.append(path.replace("gd", "tres"))
	
	if all_script_paths:
		var callable := _on_pressed_context_menu_item.bindv([all_script_paths, all_new_resource_paths])
		var menu_label: String = "Create Ressource from GDScript"
		if all_script_paths.size() > 1:
			menu_label = "Create Ressources from GDScripts"
		add_context_menu_item(menu_label, callable)


func _on_pressed_context_menu_item(
	array: Array,
	all_script_paths: Array[StringName], 
	all_new_resource_paths: Array[StringName]
) -> void:
	for i in all_script_paths.size():
		var new_resource_path: String = all_new_resource_paths[i]
		var script_path: String = all_script_paths[i]
		
		if ResourceLoader.exists(new_resource_path):
			push_warning("[Resource Instancer] %s already exist, skipping instantiation!" % [new_resource_path])
			continue
		
		var script: GDScript = load(script_path)
		if script.is_abstract():
			push_warning("[Resource Instancer] Cannot instantiate resource from abstract script %s!" % [script_path])
			continue
		
		var resource := script.new() as Resource
		if resource:
			ResourceSaver.save(resource, new_resource_path)
