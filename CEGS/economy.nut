require("market.nut");
require("town.nut");
require("industry.nut");
require("cargo.nut");

class Economy
{

	econ_towns = null
	econ_industries = null
	econ_markets = null
	econ_industry_types = null;
	
	
	constructor(load_econ_data=null){

		
		
		
		
		// If no data to load, make it.
		if(!load_econ_data){
			Init();
		// Else, load it.
		}else{
			
		
		
		
		}
	
	
	
	
	}
}

function Economy::Init()
{
	econ_towns = InitTowns(GSTownList());
	econ_industries = InitIndustries(GSIndustryList());
	econ_markets = InitMarkets(econ_towns, econ_industries);
	econ_industry_types = InitIndustryTypes(industries);
}
function Economy::InitTowns(in_towns = GSTownList())
{
	local out_towns = [];
	foreach(town, _ in in_towns)
	{

		

	}

}

function Economy::InitIndustries(industries = GSIndustryList())
{
	

}

function Economy::InitMarkets(in_towns, in_industries)
{
	local out_markets = [];
	foreach(id, value in in_towns)
	{
		Log.Info("Generating Market for Town #" + id, Log.LVL_DEBUG);
		out_markets.append(EconMarket(0, id));
	}
	foreach(id, value in in_industries)
	{
		Log.Info("Generating Market for Industry #" + id, Log.LVL_DEBUG);
		out_markets.append(EconMarket(1, id));
	}
	return out_markets;
}

function Economy::UpdatePrices(){


}