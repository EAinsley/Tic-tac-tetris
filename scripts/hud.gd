extends Control

@export var continue_texture : Texture
@export var pause_texture : Texture

@export var sound_off_texture : Texture
@export var sound_on_texture : Texture

var is_paused : bool = false
var is_bgm_playing: bool = true

@onready var score_value: Label = $PanelContainer/MarginContainer/GridContainer/ScoreValue
@onready var pause: TextureButton = $Pause
@onready var bgm: AudioStreamPlayer = $Pause/BGM
@onready var sound: TextureButton = $Sound
@onready var lost_text: Panel = $LostText


func _ready() -> void:
	if GameManager.game_board != null:
		_connect_board(GameManager.game_board)
	else:
		GameManager.game_board_changed.connect(_connect_board)
	
func _connect_board(board: Board) -> void:
	board.score_changed.connect(_on_score_changed)
	board.lost.connect(_on_lost)

func _on_score_changed(score: int) -> void:
	score_value.text = str(score)
	


func _on_pause_pressed() -> void:
	is_paused = !is_paused
	if is_paused:
		pause.texture_normal = continue_texture
		get_tree().paused = true
	else:
		pause.texture_normal = pause_texture
		get_tree().paused = false
		


func _on_sound_pressed() -> void:
	is_bgm_playing = !is_bgm_playing
	if !is_bgm_playing:
		sound.texture_normal = sound_off_texture
		bgm.stop()
	else:
		sound.texture_normal = sound_on_texture
		bgm.play()


func _on_config_pressed() -> void:
	get_tree().quit()
	
func _on_lost() -> void:
	lost_text.visible = true
