params [
  ["_unit", objNull, [objNull]],
  ["_varName", "LNO_recruitableUnits", [""]]
];

if (!local _unit) exitWith { "The loadout will be applied only where the unit is local"; };

private _hash = missionNamespace getVariable [_varName, createHashMap];
private _class = typeOf _unit;
private _loadout = _hash get _class;

if (!isNil "_class") then {
  _unit setUnitLoadout _loadout;
  [_unit, _loadout];
} else { false; };
