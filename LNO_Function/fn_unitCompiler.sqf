/*
*  This function get the class names and the loadouts
*  of all units that are synchronized with the _logic object
*  and store them in a HashMap with the class name as key and
*  the loadout of the unit as the value. Additionally, it deletes all
*  synchronized units and the _logic object and stores the HashMap
*  in a global variable in mission namespace under the _varName.
*
*  Params:
*  0: _logic [object] - default value: objNull . The object that the units will be synchronized to.
*  1: _varName [string] - default value: "LNO_recruitableUnits" . The variable name under which hashMap will be stored in mission namespace.
*
*  Example: [this, "LNO_enemyUnits"] call LNO_fnc_unitCompiler;
*  This will be called from the init field of an object of type Game Logic.
*/



if (!isServer) exit with { "This function executes only in Server Machine" };

params [
  ["_logic", objNull, [objNull]],
  ["_varName", "LNO_recruitableUnits", [""]],
  ["_recruitObj", objNull, [objNull]]
];

// Create the hashMap and get all synced objects
private _hash = createHashMap;
private _allObj = synchronizedObjects _logic;

// Iterate through all objects, get their classNames and their loadouts and add them in hashMap
{
  private _type = typeOf _x;
  private _loadout = getUnitLoadout _x;
  _hash set [_type, _loadout, true];

  // Delete the unit.
  deleteVehicle _x;

  // Delete the group if it is empty
  if ((count (units (group _x))) isEqualTo 0) then { deleteGroup (group _x); }; 
} forEach allObj;

// Create the global variable and store it in mission namespace
missionNamespace setVariable [_varName, _hash, true];

// Delete the _logic object
deleteVehicle _logic;

// Return true if the function has been executed
true;
