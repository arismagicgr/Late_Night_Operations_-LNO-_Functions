params [
  ["_obj", objNull, [objNull]],
  ["_varName", "LNO_recruitableUnits", [""]]
];

private _hash = missionNamespace getVariable [_varName, createHashMap];
private _allTypes = keys _hash;

private _conditionShow = "(_this distance _target) <= 5";
private _conditionProgress = "(_caller distance _target) <= 5";
{
  // Get the display name for the unit's className
  private _cfg = (configFile >> "CfgVehicles" >> _x);
  _name = [_cfg] call BIS_fnc_displayName;

  // Hold action's text
  private _text = format ["<t color='#008000'>Recruit %1</t>", _name]; 
  [
	  _obj,														// Object the action is attached to
	  _text,													// Title of the action
	  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa",	// Idle icon shown on screen
	  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa",	// Progress icon shown on screen
	  _conditionShow,									// Condition for the action to be shown
	  _conditionProgress,									// Condition for the action to progress
	  {},																// Code executed when action starts
	  {},																// Code executed on every progress tick
	  { 
     private _class = _this select 3 select 0;
     private _variableName = _this select 3 select 1;
     private _newUnit = (group _caller) createUnit [_class, getPosATL _target, [], 2, "NONE"];
     [_newUnit, _variableName] call LNO_fnc_applyLoadout;
    },							// Code executed on completion
	  {},																// Code executed on interrupted
	  [_x, _varName],																// Arguments passed to the scripts as _this select 3
	  1,																// Action duration in seconds
	  0,																// Priority
	  true,															// Remove on completion
	  false,															// Show in unconscious state
    true                              // Show window
  ] BIS_fnc_holdActionAdd;
} forEach _allTypes;
