local function AddCustomThings()

	DarkRP.createCategory{

		name = "Money Trees",
		categorises = "entities",
		startExpanded = true,
		color = Color( 0, 107, 0, 255 ),
		canSee = function( Ply ) return true end,
		sortOrder = 0,
	}

	DarkRP.createEntity( "Money Tree Pot", {

		ent = "moneytree_pot",
		model = "models/moneytrees/pot.mdl",
		price = MoneyTrees.pot_price,
		max = MoneyTrees.pot_max_amount,
		cmd = "buymoneytreepot",
		category = "Money Trees",
	} )

	DarkRP.createEntity( "Money Tree Seeds", {

		ent = "moneytree_seeds",
		model = "models/moneytrees/seeds.mdl",
		price = MoneyTrees.seeds_price,
		max = MoneyTrees.seeds_max_amount,
		cmd = "buymoneytreeseeds",
		category = "Money Trees",
	} )

	DarkRP.createEntity( "Money Juice Extractor", {

		ent = "moneyjuice_extractor",
		model = "models/moneytrees/moneyjuice_extractor.mdl",
		price = MoneyTrees.extractor_price,
		max = MoneyTrees.extractor_max_amount,
		cmd = "buymoneyjuiceextractor",
		category = "Money Trees",
	} )

	DarkRP.createEntity( "Money Juice Cell", {

		ent = "moneyjuice_cell",
		model = "models/moneytrees/moneyjuice_cell.mdl",
		price = MoneyTrees.cell_empty_price,
		max = MoneyTrees.cell_max_amount,
		cmd = "buymoneyjuicecell",
		category = "Money Trees",
	} )

	DarkRP.createEntity( "Money Tree Light", {

		ent = "moneytree_light",
		model = "models/props_combine/combine_light001a.mdl",
		price = MoneyTrees.light_price,
		max = MoneyTrees.light_max_amount,
		cmd = "buymoneytreelight",
		category = "Money Trees",
	} )
end

hook.Add( "loadCustomDarkRPItems", "MoneyTrees", AddCustomThings )
