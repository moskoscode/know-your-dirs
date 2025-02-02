extends Control

@onready var points_label: Label = %Points

func _ready() -> void:
	points_label.text = 'Points: {points}'.format({'points': G.game_data.points})


func _on_main_menu_btn_pressed() -> void:
	G.scene_manager.transition_to(SceneManager.Scene.MainMenu)
