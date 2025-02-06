extends Control

@onready var challenge_label: Label = $Layout/Challenge
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var top_btn: Button = %TopBtn
@onready var bottom_btn: Button = %BottomBtn

@onready var current_lang: G.Language = G.Language.values().pick_random()
@onready var current_side: G.Side = G.Side.values().pick_random()
@onready var current_top_btn: G.Side = G.Side.values().pick_random()
@onready var current_bottom_btn: G.Side = G.Side.Left if current_top_btn == G.Side.Right else G.Side.Right

var progress_tw: Tween = null


func _ready() -> void:
	progress_bar.value = progress_bar.max_value
	challenge_label.text = ['<-', '->'][current_side] 
	top_btn.text = G.side_name(current_lang, current_top_btn)
	bottom_btn.text = G.side_name(current_lang, current_bottom_btn)

	var time_to_answer := maxf(4. - (G.game_data.challenges / 8.), 1.)

	progress_tw = create_tween()
	progress_tw.tween_property(progress_bar, "value", 0, time_to_answer)
	progress_tw.tween_callback(_on_time_end)


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


func _on_top_btn_pressed() -> void:
	_on_btn_pressed(current_top_btn)


func _on_bottom_btn_pressed() -> void:
	_on_btn_pressed(current_bottom_btn)


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("up"):
		_on_top_btn_pressed()
	if event.is_action_pressed("down"):
		_on_bottom_btn_pressed()
