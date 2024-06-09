class_name MeleeAttackManager
extends AttackManager

func _ready():
	super._ready()
	start_attack.connect(perform_attack)

func perform_attack():
	super.perform_attack()
	var damage_data = DamageData.new()
	damage_data.amount = damage_dealt
	damage_data.hit_pos = Vector3.ZERO
	player.hurt(damage_data)
