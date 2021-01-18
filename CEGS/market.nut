
class EconMarket
{
	entity = null;					// Either Town or Industry, links to EconTown or EconIndustry Class to handle budgets.
	market_type = null;				// 0 if town, 1 if industry, determines which id is which.
	parent_id = null;				// Equal to town id or industry id

	market_name = null;				// Name of the market's parent.
	
	
	demand_array = null;        	// The amount of each cargo in the cargo_array that a market demands, per month (based on average monthly production of cargo if secondary)
	supply_array = null;       		// The amount of each cargo in the cargo_array that a market supplies, per month .
	                           
	cargo_array = null;        		// Array of all the cargo types in a market.
	price_array = null;        		// Array of all the prices of cargo at a market.
	
	
	
	
	
	
	constructor(m_type, id){
		parent_id = id;
		market_type = m_type;
		
		
		
		
		
		demand_array = [];
		supply_array = [];
		
		cargo_array = []; 
		price_array = []; 
		
		switch (market_type){ 
		case(0):  // Town
		
			Log.Info("Town Market", Log.LVL_DEBUG)
			market_name = GSTown.GetName(parent_id);
		
			entity = EconTown(parent_id);
			break;
		
		case(1):  // Industry
			Log.Info("Industry Market", Log.LVL_DEBUG)
		
			market_name = GSIndustry.GetName(parent_id);
		
		
			foreach(key, value in GSIndustryType.GetProducedCargo(GSIndustry.GetIndustryType(parent_id))){
				cargo_array.append(GetCargoLabel(key));
				price_array.append(0);
			}
			foreach(key, value in GSIndustryType.GetAcceptedCargo(GSIndustry.GetIndustryType(parent_id))){
				cargo_array.append(GetCargoLabel(key));
				price_array.append(0);
			}
			
			entity = EconIndustry(parent_id);
			break;
		}
			
		//Log.Info("Market " + market_name +  " has the following cargotypes at the listed price." , Log.LVL_DEBUG);
		Log.Info("Market: " + market_name + "Cargo Types: " + cargo_array.tostring() + " Prices: " + price_array.tostring(), Log.LVL_DEBUG);
		
	}
}



function EconMarket::RecalcDemand(){	// Trigger monthly


}

function EconMarket::RecalcSupply(){	// Trigger monthly


}

function EconMarket::RecalcPrice(){ 	// Trigger monthly


}
/**
This function should run monthly to send out orders for a market for the private AI to read 
so to be able to meet supply and demand.
**/
function EconMarket::PlaceOrders(){


}




function EconMarket::RecalcMonth(){
	this.RecalcDemand();
	this.RecalcDemand();
	this.RecalcPrice();
	this.PlaceOrders();
}