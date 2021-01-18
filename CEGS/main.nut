require("economy.nut");

//require("political.nut");


/** Import SuperLib for GameScript **/
import("util.superlib", "SuperLib", 40);
Result <- SuperLib.Result;
Log <- SuperLib.Log;
Helper <- SuperLib.Helper;
Tile <- SuperLib.Tile;
Direction <- SuperLib.Direction;
Town <- SuperLib.Town;
Industry <- SuperLib.Industry;
Story <- SuperLib.Story;
Money <- SuperLib.Money;
// Additional SuperLib sub libraries can be found here:
// http://dev.openttdcoop.org/projects/superlib/repository

/** Import other libs **/
// There are several other libraries for Game Scripts out there. Check out
// http://bananas.openttd.org/en/gslibrary/ for an up to date list.
//
// Remember to set dependencies in the bananas web manager for all libraries
// that you use. This way users will automatically get all libraries of the
// version you selected when they download your Game Script.


/** Import other source code files **/
require("version.nut"); // get SELF_VERSION
//require("some_file.nut");
//..


class MainClass extends GSController 
{
	_loaded_data = null;
	_loaded_from_version = null;
	_init_done = null;
	_economy = null;

	/*
	 * This method is called when your GS is constructed.
	 * It is recommended to only do basic initialization of member variables
	 * here.
	 * Many API functions are unavailable from the constructor. Instead do
	 * or call most of your initialization code from MainClass::Init.
	 */
	constructor()
	{
		this._init_done = false;
		this._loaded_data = null;
		this._loaded_from_version = null;
		this._economy = null;
	}
}

/*
 * This method is called by OpenTTD after the constructor, and after calling
 * Load() in case the game was loaded from a save game. You should never
 * return back from this method. (if you do, the script will crash)
 *
 * Start() contains of two main parts. First initialization (which is
 * located in Init), and then the main loop.
 */
function MainClass::Start()
{

	foreach (cargo, value in GSCargoList()){
	Log.Info(cargo + " (" + GSCargo.GetCargoLabel(cargo) + ")", Log.LVL_INFO)
	
	}

	//Wait a bit
	local systime = GSDate.GetSystemTime() % 101;
	GSController.Sleep(systime);
	

	GSGame.Pause();
	Log.Info("Initialising...", Log.LVL_INFO);
	this.Init();
	Log.Info("Initialisation Complete, beginning loop.", Log.LVL_INFO)
	GSGame.Unpause();

	// Main Game Script loop
	local last_loop_date = GSDate.GetCurrentDate();
	while (true) {
		local loop_start_tick = GSController.GetTick();

		// Handle incoming messages from OpenTTD
		this.HandleEvents();

		// Reached new year/month?
		local current_date = GSDate.GetCurrentDate();
		if (last_loop_date != null) {
			local year = GSDate.GetYear(current_date);
			local month = GSDate.GetMonth(current_date);
			local day = GSDate.GetDayOfMonth(current_date);
			
			if (year != GSDate.GetYear(last_loop_date)) {
				this.EndOfYear();
			}
			if (month != GSDate.GetMonth(last_loop_date)) {
				this.EndOfMonth();
			}
			if (day != GSDate.GetDayOfMonth(last_loop_date)){
				this.EndOfDay();
			}
		}
		last_loop_date = current_date;
		
		
		
		
		
		local loop_end_tick = GSController.GetTick();
		if (loop_end_tick - loop_start_tick > 10){
			Log.Warning("Loop took more than 10 ticks.", Log.LVL_INFO);
		}
	}
}


function MainClass::Init()
{
	if (this._loaded_data != null) {
		// Copy loaded data from this._loaded_data to this.*
		// or do whatever you like with the loaded data
	} else {
		
		this._economy = Economy()
	}

	// Indicate that all data structures has been initialized/restored.
	this._init_done = true;
	this._loaded_data = null; // the loaded data has no more use now after that _init_done is true.
}

/*
 * This method handles incoming events from OpenTTD.
 */
function MainClass::HandleEvents()
{
	if(GSEventController.IsEventWaiting()) {
		local ev = GSEventController.GetNextEvent();
		if (ev == null) return;

		local ev_type = ev.GetEventType();
		switch (ev_type) {
			case GSEvent.ET_COMPANY_NEW: {
			}

			// other events ...
		}
	}
}
/*
 * Called by main loop after each day.
 *
 */
function MainClass::EndOfDay()
{

}



/*
 * Called by main loop when a new month has been reached.
 */
function MainClass::EndOfMonth()
{
}

/*
 * Called by main loop when a new year has been reached.
 */
function MainClass::EndOfYear()
{
}

/*
 * This method is called by OpenTTD when an (auto)-save occurs. You should
 * return a table which can contain nested tables, arrays of integers,
 * strings and booleans. Null values can also be stored. Class instances and
 * floating point values cannot be stored by OpenTTD.
 */
function MainClass::Save()
{
	Log.Info("Saving data to savegame", Log.LVL_INFO);

	// In case (auto-)save happens before we have initialized all data,
	// save the raw _loaded_data if available or an empty table.
	if (!this._init_done) {
		return this._loaded_data != null ? this._loaded_data : {};
	}

	return { 
		some_data = null,
		//some_other_data = this._some_variable,
	};
}

/*
 * When a game is loaded, OpenTTD will call this method and pass you the
 * table that you sent to OpenTTD in Save().
 */
function MainClass::Load(version, tbl)
{
	Log.Info("Loading data from savegame made with version " + version + " of the game script", Log.LVL_INFO);

	// Store a copy of the table from the save game
	// but do not process the loaded data yet. Wait with that to Init
	// so that OpenTTD doesn't kick us for taking too long to load.
	this._loaded_data = {}
   	foreach(key, val in tbl) {
		this._loaded_data.rawset(key, val);
	}

	this._loaded_from_version = version;
}
