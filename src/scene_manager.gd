class_name SceneManager extends Control

@export var first_scene := Scene.MainMenu
@onready var overlay_node: ColorRect = $Overlay

var current_scene: Node = null


func _ready() -> void:
	overlay_node.visible = false
	G.scene_manager = self

	current_scene = create_scene(first_scene)
	add_child(current_scene)


func go_to(scene: Scene):
	var next_scene := create_scene(scene)
	add_child(next_scene)
	remove_child(current_scene)
	current_scene.queue_free()
	current_scene = next_scene


func transition_to(scene: Scene, transition_time := 0.3):
	# show overlay but transparent
	overlay_node.color.a = 0
	overlay_node.visible = true

	current_scene.process_mode = Node.PROCESS_MODE_DISABLED

	var next_scene := create_scene(scene)
	next_scene.process_mode = Node.PROCESS_MODE_DISABLED
	next_scene.visible = false

	add_child(next_scene)

	var tw := create_tween()

	var opaque_color := overlay_node.color
	opaque_color.a = 1
	tw.tween_property(overlay_node, "color", opaque_color, transition_time / 2)
	tw.tween_callback(func ():
		next_scene.visible = true

		remove_child(current_scene)
		current_scene.queue_free()

		current_scene = next_scene
	)

	var transparent_color := overlay_node.color
	tw.tween_property(overlay_node, "color", transparent_color, transition_time / 2)
	tw.tween_callback(func ():
		overlay_node.visible = false
		current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	)


func create_scene(scene: Scene) -> Node:
	return _scene_lookup[scene].instantiate()


enum Scene {
	MainMenu,
	SimpleDirection,
	Intermission,
	GameOver,
}

const _scene_lookup = [
	preload("res://src/MainMenu.tscn"),
	preload("res://src/SimpleDirection.tscn"),
	preload("res://src/Intermission.tscn"),
	preload("res://src/GameOver.tscn"),
]
