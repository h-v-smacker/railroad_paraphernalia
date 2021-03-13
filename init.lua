mesecon.rules.flat2 =
{{x = 2, y = 0, z = 0},
 {x =-2, y = 0, z = 0},
 {x = 0, y = 0, z = 2},
 {x = 0, y = 0, z =-2}
}

mesecon.rules.shunting_signal =
{{x = 1, y = 0, z = 0},
 {x =-1, y = 0, z = 0},
 {x = 0, y = 0, z = 1},
 {x = 0, y = 0, z =-1},
 {x = 0, y = -1, z = 0}
}

mesecon.rules.switch = {
 p0 = {{x = 0, y = 0, z = 1}},
 p1 = {{x = 1, y = 0, z = 0}},
 p2 = {{x = 0, y = 0, z = -1}},
 p3 = {{x = -1, y = 0, z = 0}}
}

-- param = 2
-- {{x = 0, y = 0, z = -1}}
-- param = 0
-- {{x = 0, y = 0, z = 1}}
-- param = 3
-- {{x = -1, y = 0, z = 0}}
-- param = 1
-- {{x = 1, y = 0, z = 0}}


local function switch_get_rules(orientation)
	if orientation == 0 then
		return {{x = 0, y = 0, z = 1}}
	elseif orientation == 1 then
		return {{x = 1, y = 0, z = 0}}
	elseif orientation == 2 then
		return {{x = 0, y = 0, z = -1}}
	elseif orientation == 3 then
		return {{x = -1, y = 0, z = 0}}
	end
	return {{ x = 0, y = 0, z = 0 }}
end

-- POINT LEVERS WITH ARROW INDICATORS

minetest.register_node("railroad_paraphernalia:switch_with_arrow", {
	description = 'Point lever w/arrow',
	drawtype = "mesh",
	mesh = "switch_arrow_2_off.b3d",
	tiles = { "points_lever_arrow.png" },
	node_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	selection_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	collisionbox = {-0.5, -0.5, -1.5, 0.5, 1, -0.5},
	walkable = false,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_blocking_trains = 1},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	mesecons = { 
		receptor = {
			state = mesecon.state.off,
			rules = mesecon.rules.flat
		}
	},
	after_place_node = function (pos, placer, itemstack, pointed_thing)
		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, { name = "railroad_paraphernalia:switch_with_arrow_act", param2 = minetest.get_node(pos).param2 } )
		minetest.sound_play("piston_extend", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
		mesecon.receptor_on(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	drop = "railroad_paraphernalia:switch_with_arrow"
})

minetest.register_node("railroad_paraphernalia:switch_with_arrow_act", {
	--description = 'Point lever w/arrow',
	drawtype = "mesh",
	mesh = "switch_arrow_2_on.b3d",
	tiles = { "points_lever_arrow.png" },
	node_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	selection_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	collisionbox = {-0.5, -0.5, -1.5, 0.5, 1, -0.5},
	walkable = false,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_in_creative_inventory=1, not_blocking_trains = 1},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	mesecons = { 
		receptor = {
			state = mesecon.state.off,
			rules = mesecon.rules.flat2
		}
	},
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, { name = "railroad_paraphernalia:switch_with_arrow", param2 = minetest.get_node(pos).param2 } )
		minetest.sound_play("piston_retract", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	drop = "railroad_paraphernalia:switch_with_arrow"
})

minetest.register_craft({
	output = 'railroad_paraphernalia:switch_with_arrow 3',
	recipe = {
		{'dye:black', 'dye:white', 'dye:black'},
		{'', 'default:stick', 'default:stick'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
	
-- POINT LEVERS WITH LAMP INDICATORS

minetest.register_node("railroad_paraphernalia:switch_with_lamp", {
	description = 'Point lever w/lamp',
	drawtype = "mesh",
	mesh = "switch_lamp_2_off.b3d",
	tiles = { "points_lever_lamp.png" },
	node_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	selection_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	collisionbox = {-0.5, -0.5, -1.5, 0.5, 1, -0.5},
	walkable = false,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_blocking_trains = 1},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	mesecons = { 
		receptor = {
			state = mesecon.state.off,
			rules = mesecon.rules.flat
		}
	},
	after_place_node = function (pos, placer, itemstack, pointed_thing)
		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, { name = "railroad_paraphernalia:switch_with_lamp_act", param2 = minetest.get_node(pos).param2 } )
		minetest.sound_play("piston_extend", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
		mesecon.receptor_on(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	drop = "railroad_paraphernalia:switch_with_lamp"
})


minetest.register_node("railroad_paraphernalia:switch_with_lamp_act", {
	--description = 'Point lever w/lamp',
	drawtype = "mesh",
	mesh = "switch_lamp_2_on.b3d",
	tiles = { "points_lever_lamp.png" },
	node_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	selection_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	collisionbox = {-0.5, -0.5, -1.5, 0.5, 1, -0.5},
	walkable = false,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_in_creative_inventory=1, not_blocking_trains = 1},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	mesecons = { 
		receptor = {
			state = mesecon.state.off,
			rules = mesecon.rules.flat2
		}
	},
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, { name = "railroad_paraphernalia:switch_with_lamp", param2 = minetest.get_node(pos).param2 } )
		minetest.sound_play("piston_retract", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	drop = "railroad_paraphernalia:switch_with_lamp"
})

	
minetest.register_craft({
	output = 'railroad_paraphernalia:switch_with_lamp 3',
	recipe = {
		{'dye:grey', 'dye:yellow', 'dye:white'},
		{'', 'default:stick', 'default:stick'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})


-- POINT LEVERS WITH A RED  BALL

-- minetest.register_node("railroad_paraphernalia:switch_with_ball", {
-- 	description = 'Point lever w/ball',
-- 	drawtype = "mesh",
-- 	mesh = "switch_ball_off.b3d",
-- 	tiles = { "switch_ball_off.png" },
-- 	selection_box = { type = "fixed",
-- 				 fixed = {{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}}
-- 				 },
-- 	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
-- 	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3},
-- 	on_place = minetest.rotate_node,
-- 	paramtype = "light",
-- 	paramtype2 = "facedir",
-- 	mesecons = { 
-- 		receptor = {
-- 			state = mesecon.state.off,
-- 			rules = mesecon.rules.flat
-- 			}
-- 		},
-- 	after_place_node = function (pos, placer, itemstack, pointed_thing)
-- 		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
-- 	end,
-- 	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
-- 		minetest.set_node(pos, { name = "railroad_paraphernalia:switch_with_ball_act", param2 = minetest.get_node(pos).param2 } )
-- 		minetest.sound_play("piston_extend", {
-- 			pos = pos,
-- 			max_hear_distance = 20,
-- 			gain = 0.3,
-- 		})
-- 		mesecon.receptor_on(pos, switch_get_rules(minetest.get_node(pos).param2))
-- 	end
-- })
-- 
-- 
-- minetest.register_node("railroad_paraphernalia:switch_with_ball_act", {
-- 	--description = 'Point lever w/ball',
-- 	drawtype = "mesh",
-- 	mesh = "switch_ball_on.b3d",
-- 	tiles = { "switch_ball_on.png" },
-- 	selection_box = { type = "fixed",
-- 				 fixed = {{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}}
-- 				 },
-- 	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
-- 	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_in_creative_inventory=1},
-- 	on_place = minetest.rotate_node,
-- 	paramtype = "light",
-- 	paramtype2 = "facedir",
-- 	mesecons = { 
-- 		receptor = {
-- 			state = mesecon.state.off,
-- 			rules = mesecon.rules.flat2
-- 		}
-- 	},
-- 	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
-- 		minetest.set_node(pos, { name = "railroad_paraphernalia:switch_with_ball", param2 = minetest.get_node(pos).param2 } )
-- 		minetest.sound_play("piston_retract", {
-- 			pos = pos,
-- 			max_hear_distance = 20,
-- 			gain = 0.3,
-- 		})
-- 		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
-- 	end
-- })
	
	
-- TRACK BLOCKER


minetest.register_node("railroad_paraphernalia:track_blocker", {
	description = 'Track Blocker',
	drawtype = "mesh",
	mesh = "switch_blocker_off.b3d",
	tiles = { "track_blocker.png" },
	node_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	selection_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	collisionbox = {-0.5, -0.5, -1.5, 0.5, 1, -0.5},
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_blocking_trains = 1},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	--light_source = 3,
	mesecons = { receptor = {
		state = mesecon.state.off,
		rules = mesecon.rules.flat
	}},
	walkable = false,
	after_place_node = function (pos, placer, itemstack, pointed_thing)
		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, { name = "railroad_paraphernalia:track_blocker_act", param2 = minetest.get_node(pos).param2 } )
		minetest.sound_play("piston_extend", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
		mesecon.receptor_on(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	drop = "railroad_paraphernalia:track_blocker"
})

minetest.register_node("railroad_paraphernalia:track_blocker_act", {
	--description = 'Track Blocker',
	drawtype = "mesh",
	mesh = "switch_blocker_on.b3d",
	tiles = { "track_blocker.png" },
	node_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	selection_box = { 
				type = "fixed",
				fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
						{-0.5, -0.5, -1.5, 0.5, 1, -0.5}
						}
				},
	collisionbox = {-0.5, -0.5, -1.5, 0.5, 1, -0.5},
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3, not_in_creative_inventory=1},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	--light_source = 3,
	mesecons = { receptor = {
		state = mesecon.state.off,
		rules = mesecon.rules.flat2
	}},
	walkable = true,
	on_rightclick = function (pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, { name = "railroad_paraphernalia:track_blocker", param2 = minetest.get_node(pos).param2 } )
		minetest.sound_play("piston_retract", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
		mesecon.receptor_off(pos, switch_get_rules(minetest.get_node(pos).param2))
	end,
	drop = "railroad_paraphernalia:track_blocker"
})
	
minetest.register_craft({
	output = 'railroad_paraphernalia:track_blocker 2',
	recipe = {
		{'dye:white', 'dye:black', 'dye:white'},
		{'', 'default:stick', ''},
		{'dye:red', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
	
-- -------------------------
-- SHUNT SIGNAL

-- 'tracktype' here actually just means something changeable with the trackworker
advtrains.trackplacer.register_tracktype("railroad_paraphernalia:shunting_signal")

local supported_aspects = {
	main = {false},
	shunt = nil
}

local function gen_setaspect(rot)
	return function(pos, node, asp)
		local newstate = asp.shunt and "act" or "off"
		advtrains.ndb.swap_node(pos,
				{name="railroad_paraphernalia:shunting_signal_"..newstate.."_"..rot,
				param2 = node.param2})
	end
end

minetest.register_alias("railroad_paraphernalia:shunting_signal",
		"railroad_paraphernalia:shunting_signal_off_0")
minetest.register_alias("railroad_paraphernalia:shunting_signal_act",
		"railroad_paraphernalia:shunting_signal_act_0")

for _, rot in ipairs({"0","30","45","60"}) do
	for typ, prts in pairs({
		["off"] = {tile = "blue", atlatc_state = "off", swapnode = "act",
		swapstate = "on", asp = { main = false, shunt = false}},
		["act"] = {tile = "white", atlatc_state = "on", swapnode = "off",
		swapstate = "off", asp = { main = false, shunt = true}}
	}) do

local nodename = "railroad_paraphernalia:shunting_signal_"..typ.."_"..rot
local swapnode = "railroad_paraphernalia:shunting_signal_"..prts.swapnode.."_"..rot
minetest.register_node(nodename, {
	description = "Shunting signal",
	drawtype = "mesh",
	mesh = "shunting_signal_"..rot..".b3d",
	tiles = { "shunting_signal_"..prts.tile..".png" },
	selection_box = {
		type = "fixed",
		fixed = {{-0.33, -0.5, -0.33, 0.33, 0.4, 0.33}}
	},
	collisionbox = {-0.33, -0.5, -0.33, 0.33, 0.4, 0.33},
	groups = {
		snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3,
		not_blocking_trains = 1,
		advtrains_signal = 2,
		save_in_at_nodedb = 1
	},
	on_place = minetest.rotate_node,
	hide_in_creative = not (typ == "off" or rot == "0"),
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 1,
	mesecons = {
		effector = {
			rules = mesecon.rules.shunting_signal,
			action_on = (typ == "off" and function(pos, node)
				advtrains.ndb.swap_node(pos, {name = swapnode, param2 = node.param2}, true)
			end) or nil,
			action_off = (typ == "act" and function (pos, node)
				advtrains.ndb.swap_node(pos, {name = swapnode, param2 = node.param2}, true)
			end) or nil,
		},
	},
	on_rightclick = advtrains.interlocking and advtrains.interlocking.signal_rc_handler or
	function(pos, node, player, itemstack, pointed_thing)
		if not advtrains.check_turnout_signal_protection(pos, player:get_player_name()) then
			return
		end
		minetest.set_node(pos, {name = swapnode, param2 = advtrains.ndb.get_node(pos).param2} )
		minetest.sound_play("piston_extend", {
			pos = pos,
			max_hear_distance = 20,
			gain = 0.3,
		})
	end,
	can_dig = advtrains.interlocking and advtrains.interlocking.signal_can_dig,
	advtrains = {
		set_aspect = gen_setaspect(rot),
		get_aspect = function(pos, node)
			return prts.asp
		end,
		supported_aspects = supported_aspects,
		getstate = prts.atlatc_state,
		setstate = function(pos, node, newstate)
			if newstate == prts.swapstate then
				advtrains.ndb.swap_node(pos, {name = swapnode, param2 = node.param2}, true)
			end
		end,
	},
	at_nnpref = "shunting_signal",
	at_suffix = typ,
	at_rotation = rot,
	drop = "railroad_paraphernalia:shunting_signal_0",
})

advtrains.trackplacer.add_worked("railroad_paraphernalia:shunting_signal", typ,
		"_" .. rot, "_" .. prts.swapnode)

end
end

minetest.register_craft({
	output = 'railroad_paraphernalia:shunting_signal',
	recipe = {
		{'', 'dye:white', ''},
		{'', 'dye:blue', ''},
		{'', 'default:stone', ''},
	}
})

-- MISC ---------------------

minetest.register_node("railroad_paraphernalia:limit_post", {
	description = "Delimiting post",
	drawtype = "mesh",
	mesh = "limit_post.b3d",
	tiles = { "limit_post.png" },
	selection_box = { type = "fixed",
				 fixed = {{-0.33, -0.5, -0.33, 0.33, 0.4, 0.33}}
				 },
	collisionbox = {-0.33, -0.5, -0.33, 0.33, 0.4, 0.33},
	groups = {
		snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3,
		advtrains_signal = 1, save_in_at_nodedb = 1
	},
	on_place = minetest.rotate_node,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	advtrains = {
		get_aspect = function(pos, node)
			return {main = false, shunt = false}
		end
	},
	on_rightclick = advtrains.interlocking and advtrains.interlocking.signal_rc_handler,
	can_dig = advtrains.interlocking and advtrains.interlocking.signal_can_dig,
})

minetest.register_craft({
	output = 'railroad_paraphernalia:limit_post',
	recipe = {
		{'', 'dye:black', ''},
		{'', 'dye:white', ''},
		{'', 'default:stone', ''},
	}
})

----

