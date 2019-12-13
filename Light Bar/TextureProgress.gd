tool
extends TextureProgress


func initialize(current, maximum):
	max_value = 200
	min_value = 0
	value = 200


func animate_value(end, tween_duration=0.6):
	$Tween.interpolate_property(self, 'value', value, end, tween_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")


func _on_Player_light_battery(battery):
	value = battery
	yield(animate_value(battery), "completed")

func _on_StatusBar_light_battery_canvas(battery):
	value = battery
	yield(animate_value(battery), "completed")
