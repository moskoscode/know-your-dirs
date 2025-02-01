extends Control

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_start_btn_pressed() -> void:
	G.game_data = GameData.new()
	get_tree().change_scene_to_packed(G.simple_direction_scene)

