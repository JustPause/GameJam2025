extends Node

enum TowerAttackTypes {BUBBLES, FIRE, HEAVY}

signal active_item(index : int)

func emit_active_itime(index : int):
    print(index)
    active_item.emit(index)