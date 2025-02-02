extends Control

@onready var points_label: Label = $Points;
@onready var challenge_label: Label = $Layout/Challenge;
@onready var progress_bar: ProgressBar = $ProgressBar;
@onready var current_lang: G.Language = G.Language.values().pick_random()
@onready var current_side: G.Side = G.Side.values().pick_random()
@onready var tween: Tween = null

func _ready() -> void:
	points_label.text = '{points} pts'.format({'points': G.game_data.points})
	progress_bar.value = 10
	challenge_label.text = G.side_name(current_lang, current_side)

	tween = create_tween()
	tween.tween_property(progress_bar, "value", 0, 3)
	tween.tween_callback(_on_time_end)


func _on_time_end() -> void:
	G.scene_manager.transition_to(SceneManager.Scene.GameOver)


func _on_btn_pressed(side: G.Side) -> void:
	if side != current_side:
		# Wrong side, lost game
		get_tree().change_scene_to_packed(G.game_over_scene)
		return

	var time_left := int(progress_bar.value)
	G.game_data.points += time_left

	G.scene_manager.transition_to(SceneManager.Scene.SimpleDirection)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed('left'):
		_on_btn_pressed(G.Side.Left)
	if event.is_action_pressed('right'):
		_on_btn_pressed(G.Side.Right)
