extends Node

var game_data: GameData = GameData.new()

var main_menu_scene := load("res://src/MainMenu.tscn")
var simple_direction_scene := preload("res://src/SimpleDirection.tscn")
var game_over_scene := preload("res://src/GameOver.tscn")

enum Side {
	Left,
	Right,
}

enum Language {
	English,
	Portuguese,
}

const _side_name_lookup = [
	["Left", "Right"],  # Language.English
	["Esquerda", "Direita"],  # Language.Portuguese
]


func side_name(lang: G.Language, side: G.Side):
	return _side_name_lookup[lang][side]
