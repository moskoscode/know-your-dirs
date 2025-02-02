extends Control

@onready var points_label: Label = %Points;
var live_labels: Array[Label] = []


func _ready() -> void:
	live_labels.assign($Layout/Lives.get_children())
	var tw = create_tween()


	_set_points_label(G.game_data.points)
	tw.tween_method(_set_points_label, G.game_data.points, (G.game_data.points + G.game_data.acc_points), 0.4)

	var lives_tw := create_tween()
	lives_tw.tween_interval(0.2)
	# set lives lost
	var i = 0
	for live_label in live_labels:
		if i >= G.game_data.lives:
			live_label.text = ':('

		if i >= G.game_data.lives + G.game_data.acc_lives:
			lives_tw.tween_property(live_label, "text", ':(', 0.3)
			lives_tw.tween_interval(0.2)

		i += 1

	tw.tween_interval(1)
	tw.tween_callback(func ():
		if G.game_data.lives > 0:
			G.scene_manager.transition_to(SceneManager.Scene.SimpleDirection)
		else:
			G.scene_manager.transition_to(SceneManager.Scene.GameOver)
	)

	G.game_data.sync()

func _set_points_label(points: int):
	print(points)
	points_label.text = 'Points: {points}'.format({'points': points})
