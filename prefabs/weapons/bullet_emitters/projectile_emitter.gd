extends BulletEmitter

@export var projectile_prefab: PackedScene

func fire():
	var projectile = projectile_prefab.instantiate() as Projectile
	projectile.global_transform = global_transform
	projectile.damage = damage
	get_tree().get_root().add_child(projectile)
	projectile.add_to_group("instanced")
	projectile.set_bodies_to_exclude(bodies_to_exclude)
	super()
	
