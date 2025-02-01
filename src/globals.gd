extends Node

var main_menu_scene := load("res://src/MainMenu.tscn")
var simple_direction_scene := preload("res://src/SimpleDirection.tscn")
var game_over_scene := preload("res://src/GameOver.tscn")

enum Sides {
	Left, Right
}

var game_data: GameData = GameData.new()
