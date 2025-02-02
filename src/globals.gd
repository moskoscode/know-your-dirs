extends Node

var game_data: GameData = GameData.new()
var scene_manager: SceneManager = null

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
