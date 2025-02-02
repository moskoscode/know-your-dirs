class_name GameData extends Object

# Points accumulated so far
var points := 0

# How many challenges the player has completed
var challenges := 0

# How many lives the player has
var lives := 3


# Points gained since last sync
var acc_points := 0

# Lives gained (or lost) since last sync
var acc_lives := 0

func add_points(gained_points: int):
	acc_points += gained_points

func add_lives(gained_lives: int):
	acc_lives += gained_lives


# apply changes
func sync():
	points += acc_points
	lives += acc_lives

	acc_points = 0
	acc_lives = 0

