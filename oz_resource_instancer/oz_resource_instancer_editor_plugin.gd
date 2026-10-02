@tool
extends EditorPlugin
class_name OZResourceInstancerEditorPlugin

var _context_menu_plugin: OZResourceInstancerContextMenuPlugin

func _enter_tree() -> void:
	_context_menu_plugin = OZResourceInstancerContextMenuPlugin.new()
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM, _context_menu_plugin)


func _exit_tree() -> void:
	remove_context_menu_plugin(_context_menu_plugin)
