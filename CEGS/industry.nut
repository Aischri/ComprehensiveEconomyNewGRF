class EconIndustry{

	id = null; 					// Id should be equal to default industry id
	type_id = null;				// Industry type as ID from GSIndustryTypeList	

	level = null;				// Industry level from 1-5? 

	
	
	current_balance = null;	// Amount of money industry currently has
	
	
	constructor(in_id, in_type){
		this.id = in_id;
		this.type_id = in_type;
		this.level = 0;
		this.current_balance = Money.Inflate(100000);	
	}
}



function EconIndustry::GetProducts(){
	return GSIndustryType.GetProducedCargo(this.type_id);
}
function EconIndustry::GetDemands(){
	return GSIndustryType.GetAcceptedCargo(this.type_id);

}
function EconIndustry::IsPrimary(){
	
}