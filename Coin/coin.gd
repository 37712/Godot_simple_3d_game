extends Area

onready var counter = get_tree().get_root().find_node("counter", true, false)

func _on_coin_body_entered(_body):
	counter.text = String(1 + int(counter.text))
	if counter.text == "10":
		get_tree().change_scene("res://YouWin.tscn")
	$JumpPlayer.play("Jump")
