/*

 */

require("version.nut");

class FMainClass extends GSInfo {
	function GetAuthor()		{ return "Aischri"; }
	function GetName()			{ return "PoliEconGS"; }
	function GetDescription() 	{ return "Yeet"; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return SELF_DATE; }
	function CreateInstance()	{ return "MainClass"; }
	function GetShortName()		{ return "PEGS"; } // Replace this with your own unique 4 letter string
	function GetAPIVersion()	{ return "1.2"; }
	function GetURL()			{ return ""; }

	function GetSettings() {
	
		AddSetting({
				name = "industry_NewGRF", 
				description = "Set which Industry set to use.",
				easy_value = 1, 
				medium_value = 1, 
				hard_value = 1, 
				custom_value = 1, 
				flags = CONFIG_INGAME, 
				min_value = 1, 
				max_value = 3
				});
		AddLabels(
				"industry_NewGRF", 
				{_1 = "XIS", 
				_2 = "Firs_Extreme", 
				_3 = "Default"
				});
		AddSetting({name = "log_level", description = "Debug: Log level (higher = print more)", easy_value = 3, medium_value = 3, hard_value = 3, custom_value = 3, flags = CONFIG_INGAME, min_value = 1, max_value = 3});
		AddLabels("log_level", {_1 = "1: Info", _2 = "2: Verbose", _3 = "3: Debug" } );
	}
}

RegisterGS(FMainClass());
