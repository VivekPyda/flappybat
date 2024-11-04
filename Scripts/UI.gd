extends CanvasLayer

class_name UI

signal start_game

@onready var points_label = $MarginContainer/PointsLabel
@onready var game_over_box = $MarginContainer/GameOverBox
@onready var bird = get_node("../Bird") as Bird


func _ready():
	points_label.text = "%d" % 0


func update_points(points: int):
	points_label.text = "%d" % points


func on_game_over():
	game_over_box.visible = true
	$GameOverTimer.start() 
	await $GameOverTimer.timeout


func _on_restart_button_pressed():
	get_tree().reload_current_scene()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$Message.hide()
	bird.should_process_input = true;
	bird.animation_player.play("flap_wings")
	bird.game_started.emit()
	bird.is_started = true
	bird.jump()
	start_game.emit()


func _on_game_over_timer_timeout() -> void:
	get_tree().reload_current_scene()
