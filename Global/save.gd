extends Node

const SAVE_PATH = "res://save.json"

func _ready():
	load_game()

func save_game():

	var save_dictionary = {
		player = {
			battle_sprite = global.player.battle_sprite,
			current_hp = global.player.current_hp,
			level = global.player.level,
			max_hp = global.player.max_hp,
			moves = global.player.moves,
			pos = {
				x = global.player.pos.x,
				y = global.player.pos.y
			},
			sprite_path = global.player.sprite_path,
			sprite_frame = global.player.sprite_frame,
			stats = global.player.stats,
			stats_sprite = global.player.stats_sprite,
			total_mobs_killed = global.player.total_mobs_killed,
			xp = global.player.xp

		}
	}

	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(save_dictionary.to_json())
	save_file.close()

	global.game_state.is_saving = false

func load_game():
	var save_file = File.new()
	var data = {}

	if not save_file.file_exists(SAVE_PATH):
		return

	save_file.open(SAVE_PATH, File.READ)
	data.parse_json(save_file.get_as_text())

	global.player.battle_sprite = data["player"]["battle_sprite"]
	global.player.current_hp = data["player"]["current_hp"]
	global.player.level = data["player"]["level"]
	global.player.max_hp = data["player"]["max_hp"]
	global.player.moves = data["player"]["moves"]
	global.player.pos = Vector2(data["player"]["pos"]["x"], data["player"]["pos"]["y"])
	global.player.sprite_path = data["player"]["sprite_path"]
	global.player.sprite_frame = data["player"]["sprite_frame"]
	global.player.stats = data["player"]["stats"]
	global.player.stats_sprite = data["player"]["stats_sprite"]
	global.player.total_mobs_killed = data["player"]["total_mobs_killed"]
	global.player.xp = data["player"]["xp"]
