extends Control

@onready var points_label: Label = $Points;
@onready var challenge_label: Label = $Layout/Challenge;
@onready var progress_bar: ProgressBar = $ProgressBar;
@onready var current_lang: G.Language = G.Language.values().pick_random()
@onready var current_side: G.Side = G.Side.values().pick_random()
@onready var tween: Tween = null

func _ready() -> void:
	progress_bar.value = progress_bar.max_value
	points_label.text = '{points} pts'.format({'points': G.game_data.points})
	challenge_label.text = G.side_name(current_lang, current_side)

	var time_to_answer := maxf(3. - (G.game_data.challenges / 8.), 0.6)

	print('challenges ', G.game_data.challenges)
	print('time_to_answer ', time_to_answer)

	tween = create_tween()
	tween.tween_property(progress_bar, "value", 0, time_to_answer)
	tween.tween_callback(_on_time_end)


func _on_time_end() -> void:
	G.game_data.lives -= 1
	G.scene_manager.transition_to(SceneManager.Scene.Intermission)


func _on_btn_pressed(side: G.Side) -> void:
	if side != current_side:
		# Wrong side, lost life
		G.game_data.add_lives(-1)

	else:
		var time_left := int(progress_bar.value)
		G.game_data.add_points(time_left)

	G.scene_manager.transition_to(SceneManager.Scene.Intermission)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed('left'):
		_on_btn_pressed(G.Side.Left)
	if event.is_action_pressed('right'):
		_on_btn_pressed(G.Side.Right)
