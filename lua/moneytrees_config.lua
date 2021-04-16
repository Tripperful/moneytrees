--[[-------------------------------------------------------------------------
Money trees addon configuration file
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
General addon configuration section
---------------------------------------------------------------------------]]
-- How often should think functions be called in the addon. The smaller this
-- interval, the more often things are updated and networked, it doesn't
-- really make any gameplay difference, but you may lower this number if you
-- want things to look a bit smoother or upper increase it to use less
-- computational and network resources, but things will become more "twitchy"
MoneyTrees.think_functions_interval = 0.1

-- The color of 3D2D labels (there are a few of them, but you can customize
-- this color to fit your server's color scheme)
MoneyTrees.label_color = Color( 0, 255, 0, 255 )


--[[-------------------------------------------------------------------------
Money Tree configuration section
---------------------------------------------------------------------------]]

-- The time needed for a plant to fully grow (how many seconds should pass 
-- between the moment when the tree is planted and the moment when it starts 
-- givng cash)
MoneyTrees.tree_grow_time = 120

-- The maximum amount of money that one tree can hold untill it's collected.
-- When this amount is reached, a tree can not add more cash into it until
-- the money it has is collected
MoneyTrees.tree_max_cash = 1000

-- The time needed for a tree to produce the maximum amount of cash (how many
-- seconds should pass between the moment when the tree has fully grown and
-- the moment when it produces the maximum amount of money)
MoneyTrees.tree_max_cash_grow_time = 120

-- The time needed for a tree to "cool down" after it's cash is collected
-- to be able to start producing more cash (how many seconds should pass
-- between the moment when cash is collected and the moment when the tree 
-- starts producing more cash again)
MoneyTrees.tree_cash_cooldown = 60

-- The minimum amount of money that a tree should have in order to be able
-- to collect it. If a tree has less money than that, you should wait until
-- it produces more, only then you can collect it
MoneyTrees.tree_min_collectable_cash = 50

-- The time needed for a tree to fully consume one cell of money juice (how
-- many seconds will pass between you fill a money tree with one juice cell
-- and the moment when it uses all of it and becomes dry)
MoneyTrees.tree_one_juice_cell_consumption_time = 180

-- The health of the tree. When the tree has no more money juice to live,
-- it starts dying. One HP of damage is applied to the tree every second.
-- The more health it has, the longer it will live without juice, yet still
-- fading and needing to heal up when it has juice again.
MoneyTrees.tree_health = 10

-- The scale of a money tree when it has been just planted. Doesn't affect
-- gameplay
MoneyTrees.tree_min_scale = 0.2

-- The maximum scale to which a money tree can grow. Doesn't affect
-- gameplay
MoneyTrees.tree_max_scale = 1.0

-- The minimum distance at which the amount of money on a tree is shown.
-- How many inches close should be player's eye to the position where a label
-- should be drawn to display it. Doesn't affect gameplay
MoneyTrees.tree_cash_label_distance = 200

--[[-------------------------------------------------------------------------
Money Tree Pot configuration section
---------------------------------------------------------------------------]]

-- How much does it cost to buy a money tree pot (tier 1)
MoneyTrees.pot_price = 100

-- How much does it cost to update a money tree pot to advanced (tier 2)
MoneyTrees.pot_advanced_price = 100

-- How much does it cost to update a money tree pot to ultimate (tier 3)
MoneyTrees.pot_ultimate_price = 250

-- The maximum amount of money tree pots one player can buy
MoneyTrees.pot_max_amount = 10

-- The volume of juice that a simple pot can hold (in cells)
MoneyTrees.pot_simple_volume = 3

-- The volume of juice that an advanced pot can hold (in cells)
MoneyTrees.pot_advanced_volume = 6

-- The volume of juice that an ultimate pot can hold (in cells)
MoneyTrees.pot_ultimate_volume = 12

-- Pot health (how much damage it can take before breaking, set to false to
-- make it unbreakable)
MoneyTrees.pot_health = 50

-- Pot lighting state update interval (in seconds)
MoneyTrees.pot_light_update_interval = 1


--[[-------------------------------------------------------------------------
Money Juice Extractor configuration section
---------------------------------------------------------------------------]]

-- How much does it cost to buy a money juice extractor
MoneyTrees.extractor_price = 850

-- The maximum amount of money juice cells one player can buy
MoneyTrees.extractor_max_amount = 3

-- How long does it take for a money juice extractor to fill an empty cell
MoneyTrees.extractor_cell_fill_time = 10

-- How much money a money juice extractor needs to use to fill one money 
-- juice cell
MoneyTrees.extractor_cell_fill_price = 250

-- Extractor health (how much damage it can take before breaking, set to 
-- false to make it unbreakable)
MoneyTrees.extractor_health = 150


--[[-------------------------------------------------------------------------
Money Juice Cell configuration section
---------------------------------------------------------------------------]]

-- How much does it cost to buy an empty cell for money juice
MoneyTrees.cell_empty_price = 50

-- The maximum amount of money juice cells one player can buy
MoneyTrees.cell_max_amount = 5

-- How many seconds does it take to empty a full juice cell when watering a 
-- money tree
MoneyTrees.cell_dump_time = 5

-- Juice cell health (how much damage it can take before breaking, set to 
-- false to make it unbreakable)
MoneyTrees.cell_health = 10


--[[-------------------------------------------------------------------------
Money Tree Seeds configuration section
---------------------------------------------------------------------------]]

-- How much does it cost to buy money tree seeds
MoneyTrees.seeds_price = 260

-- The maximum amount of money tree seeds one player can buy
MoneyTrees.seeds_max_amount = 5

-- Seeds health (how much damage it can take before breaking, set to false 
-- to make it unbreakable)
MoneyTrees.seeds_health = 5


--[[-------------------------------------------------------------------------
Money Tree Light configuration section
---------------------------------------------------------------------------]]

-- How much does it cost to buy a money tree light
MoneyTrees.light_price = 500

-- The maximum amount of money tree lights one player can buy
MoneyTrees.light_max_amount = 5

-- Light health (how much damage it can take before breaking, set to false 
-- to make it unbreakable)
MoneyTrees.light_health = 100

-- The distance from the tree to the light at which a tree is considered to
-- be well lit
MoneyTrees.light_distance = 120

-- The color of the money tree light
MoneyTrees.light_color = Color( 100, 255, 100 )

-- The rate at which the tree grows and produces cash is multiplied by this
-- value if the tree is well lit (if it grows under the sky or there are
-- money tree lights nearby)
MoneyTrees.light_multiplier = 3

--[[-------------------------------------------------------------------------
End of config
---------------------------------------------------------------------------]]















--[[-------------------------------------------------------------------------
Post Config Section. DO NOT EDIT ANYTHING UNDER THIS LINE
---------------------------------------------------------------------------]]

MoneyTrees.think_functions_rate = 1 / MoneyTrees.think_functions_interval