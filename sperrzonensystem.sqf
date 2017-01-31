/*
Author: Stig (http://steamcommunity.com/profiles/76561198074709001)
Description: Script to create and manage cool restriction zones visible on the map with a easy-to-use GUI (which is inside this SQF script).

You can use/edit this script as long as you give full credits and dont remove my name.
If you use parts of it, do not use them for commercial purposes and give credits.
*/



diag_log "Sperrzonensystem wird geladen.";
if ((call BIS_fnc_getNetMode != "DedicatedServer") or serverName == "")exitWith{diag_log "Sperrzonensystem konnte nicht geladen werden. Es unterstützt nur die Anwendung auf dedizierten Servern. Hilfe: http://steamcommunity.com/profiles/76561198074709001";};
[[],
	{
	waitUntil {!isNull player && player == player && time > 1 && serverTime > 1};
	if(side player != west)exitWith{};
	diag_log "Sperrzonensystem wird geladen.";
	diag_log "Author (Stig): http://steamcommunity.com/profiles/76561198074709001";

	with uiNamespace do {
	disableSerialization;
	_display = {findDisplay 12};

	_sz1name = (call _display) ctrlCreate ["RscButton", -1];
	_sz1name ctrlSetText "1";
	_sz1name ctrlSetPosition [0, 0.68, 0.0375, 0.08];
	_sz1name ctrlSetBackgroundColor [-1,-1,-1,1];
	_sz1name ctrlCommit 0;
	_sz1name buttonSetAction "1 call stig_sz_find";
	_sz1name ctrlSetTooltip "Vorhandene Sperrzone grau markieren";

	_sz2name = (call _display) ctrlCreate ["RscButton", -1];
	_sz2name ctrlSetText "2";
	_sz2name ctrlSetPosition [0, 0.76, 0.0375, 0.08];
	_sz2name ctrlSetBackgroundColor [-1,-1,-1,1];
	_sz2name ctrlCommit 0;
	_sz2name buttonSetAction "2 call stig_sz_find";
	_sz2name ctrlSetTooltip "Vorhandene Sperrzone grau markieren";

	_sz3name = (call _display) ctrlCreate ["RscButton", -1];
	_sz3name ctrlSetText "3";
	_sz3name ctrlSetPosition [0, 0.84, 0.0375, 0.08];
	_sz3name ctrlSetBackgroundColor [-1,-1,-1,1];
	_sz3name ctrlCommit 0;
	_sz3name buttonSetAction "3 call stig_sz_find";
	_sz3name ctrlSetTooltip "Vorhandene Sperrzone grau markieren";

	_sz4name = (call _display) ctrlCreate ["RscButton", -1];
	_sz4name ctrlSetText "4";
	_sz4name ctrlSetPosition [0, 0.92, 0.0375, 0.08];
	_sz4name ctrlSetBackgroundColor [-1,-1,-1,1];
	_sz4name ctrlCommit 0;
	_sz4name buttonSetAction "4 call stig_sz_find";
	_sz4name ctrlSetTooltip "Vorhandene Sperrzone grau markieren";

	_add1 = (call _display) ctrlCreate ["RscButton", -1];
	_add1 ctrlSetText "+";
	_add1 ctrlSetPosition [0.0375, 0.68, 0.0625, 0.08];
	_add1 ctrlSetTextColor [-1,1,-1,1];
	_add1 ctrlCommit 0;
	_add1 buttonSetAction "1 call stig_sz_add";
	_add1 ctrlSetTooltip "Sperrzone erstellen";

	_add2 = (call _display) ctrlCreate ["RscButton", -1];
	_add2 ctrlSetText "+";
	_add2 ctrlSetPosition [0.0375, 0.76, 0.0625, 0.08];
	_add2 ctrlSetTextColor [-1,1,-1,1];
	_add2 ctrlCommit 0;
	_add2 buttonSetAction "2 call stig_sz_add";
	_add2 ctrlSetTooltip "Sperrzone erstellen";

	_add3 = (call _display) ctrlCreate ["RscButton", -1];
	_add3 ctrlSetText "+";
	_add3 ctrlSetPosition [0.0375, 0.84, 0.0625, 0.08];
	_add3 ctrlSetTextColor [-1,1,-1,1];
	_add3 ctrlCommit 0;
	_add3 buttonSetAction "3 call stig_sz_add";
	_add3 ctrlSetTooltip "Sperrzone erstellen";

	_add4 = (call _display) ctrlCreate ["RscButton", -1];
	_add4 ctrlSetText "+";
	_add4 ctrlSetPosition [0.0375, 0.92, 0.0625, 0.08];
	_add4 ctrlSetTextColor [-1,1,-1,1];
	_add4 ctrlCommit 0;
	_add4 buttonSetAction "4 call stig_sz_add";
	_add4 ctrlSetTooltip "Sperrzone erstellen";


	_del1 = (call _display) ctrlCreate ["RscButton", -1];
	_del1 ctrlSetText "X";
	_del1 ctrlSetPosition [0.1, 0.68, 0.0625, 0.08];
	_del1 ctrlSetTextColor [1,-1,-1,1];
	_del1 ctrlCommit 0;
	_del1 buttonSetAction "1 call stig_sz_del";
	_del1 ctrlSetTooltip "Sperrzone entfernen";


	_del2 = (call _display) ctrlCreate ["RscButton", -1];
	_del2 ctrlSetText "X";
	_del2 ctrlSetPosition [0.1, 0.76, 0.0625, 0.08];
	_del2 ctrlSetTextColor [1,-1,-1,1];
	_del2 ctrlCommit 0;
	_del2 buttonSetAction "2 call stig_sz_del";
	_del2 ctrlSetTooltip "Sperrzone entfernen";


	_del3 = (call _display) ctrlCreate ["RscButton", -1];
	_del3 ctrlSetText "X";
	_del3 ctrlSetPosition [0.1, 0.84, 0.0625, 0.08];
	_del3 ctrlSetTextColor [1,-1,-1,1];
	_del3 ctrlCommit 0;
	_del3 buttonSetAction "3 call stig_sz_del";
	_del3 ctrlSetTooltip "Sperrzone entfernen";


	_del4 = (call _display) ctrlCreate ["RscButton", -1];
	_del4 ctrlSetText "X";
	_del4 ctrlSetPosition [0.1, 0.92, 0.0625, 0.08];
	_del4 ctrlSetTextColor [1,-1,-1,1];
	_del4 ctrlCommit 0;
	_del4 buttonSetAction "4 call stig_sz_del";
	_del4 ctrlSetTooltip "Sperrzone entfernen";

	stig_sz_status = (call _display) ctrlCreate ["RscText", -1];
	stig_sz_status ctrlSetPosition [0.275, 0.76, 0.35, 0.08];
	stig_sz_status ctrlSetBackgroundColor [-1,-1,1,0.5];
	stig_sz_status ctrlCommit 0;

	stig_sz_regler = (call _display) ctrlCreate ["RscSlider", -1];
	stig_sz_regler ctrlSetPosition [0.1625, 0.88, 0.4625, 0.12];
	stig_sz_regler ctrlSetBackgroundColor [-1,-1,-1,1];
	stig_sz_regler ctrlCommit 0;
	stig_sz_regler ctrlSetTooltip "Verschiebe den Regler, um den Radius zu bestimmen.";

	_radius_text = (call _display) ctrlCreate ["RscText", -1];
	_radius_text ctrlSetText "Radius der Sperrzone:";
	_radius_text ctrlSetPosition [0.1625, 0.84, 0.2625, 0.04];
	_radius_text ctrlSetTextColor [1,1,1,1];
	_radius_text ctrlSetBackgroundColor [-1,-1,1,0.5];
	_radius_text ctrlCommit 0;

	_status_text = (call _display) ctrlCreate ["RscText", -1];
	_status_text ctrlSetText "Status:";
	_status_text ctrlSetPosition [0.1625, 0.76, 0.1125, 0.08];
	_status_text ctrlSetBackgroundColor [-1,-1,1,0.5];
	_status_text ctrlCommit 0;

	stig_sz_radius = (call _display) ctrlCreate ["RscText", -1];
	stig_sz_radius ctrlSetPosition [0.425, 0.84, 0.2, 0.04];
	stig_sz_radius ctrlSetBackgroundColor [-1,-1,1,0.5];
	stig_sz_radius ctrlCommit 0;

	_button_info = (call _display) ctrlCreate ["RscButton", -1];
	_button_info ctrlSetText "Stigs Sperrzonen GUI";
	_button_info ctrlSetPosition [0.1625, 0.68, 0.4625, 0.08];
	_button_info ctrlSetBackgroundColor [1,1,1,1];
	_button_info ctrlCommit 0;
	_button_info ctrlSetTooltip "Sperrzonensystem von Stig";
	_button_info buttonSetAction "hint ""Kreise sind rund."";";

	comment "Slider Setup";
	stig_sz_regler sliderSetRange [300,1000];
	stig_sz_regler sliderSetSpeed [50,50];

	comment "Text Setup";
	stig_sz_status ctrlSetText "Bereit zum Erstellen.";
	stig_sz_radius ctrlSetText str ( sliderPosition stig_sz_regler );
	};

	onMapSingleClick {stig_sz_mapclick = +_pos;};
	stig_sz_vorschau = "";
	stig_sz_mapclick = [0,0];
	(findDisplay 12) displayAddEventHandler ["keyDown",{if(_this select 1==28)then{stig_sz_enter=true;}}];

	stig_sz_vorschaumarker_var = createMarkerLocal ["stig_sz_vorschaumarker", [0,0]];
	stig_sz_vorschaumarker_var setMarkerShapeLocal "ELLIPSE";
	stig_sz_vorschaumarker_var setMarkerColorLocal "ColorBlack";
	stig_sz_vorschaumarker_var setMarkerSizeLocal [0,0];

	stig_sz_add =
	{
	_this spawn {
		if!((getMarkerPos ( format ["stig_sz_markerA%1",_this] )) isEqualTo [0,0,0]) exitWith { hint format ["Sperrzone %1 kann nicht erstellt werden. Du musst sie erst entfernen.",_this]; };
		(uiNamespace getVariable "stig_sz_status") ctrlSetText "Wähle das Sperrzonenzentrum.";
		_a = stig_sz_mapclick;
		waitUntil { !(_a isEqualTo stig_sz_mapclick) };
		stig_sz_enter = false;
		(uiNamespace getVariable "stig_sz_status") ctrlSetText "Bestätige mit ENTER.";
		waitUntil{
			stig_sz_vorschaumarker_var setMarkerSizeLocal [sliderPosition (uiNamespace getVariable "stig_sz_regler"),sliderPosition (uiNamespace getVariable "stig_sz_regler")];
			stig_sz_vorschaumarker_var setMarkerPosLocal stig_sz_mapclick;
			(uiNamespace getVariable "stig_sz_radius") ctrlSetText str round sliderPosition (uiNamespace getVariable "stig_sz_regler");
			stig_sz_enter OR !visibleMap;
			};
			
		if(!visibleMap)exitWith{diag_log "SZ GUI - Erstellung abgebrochen: Map geschlossen."; (uiNamespace getVariable "stig_sz_status") ctrlSetText "Abbruch: Map geschlossen. Bereit.";};
		if!((getMarkerPos ( format ["stig_sz_markerA%1",_this] )) isEqualTo [0,0,0]) exitWith { hint "Fehler: Sperrzonenerstellung wurde automatisch abgebrochen. Grund: Mehrere Personen erstellten gleichzeitig die gleiche Sperrzone."; };
		
		comment "Marker Teil 1 erstellen (Schräge Striche)";
		_m = createMarker [format ["stig_sz_markerA%1",_this],stig_sz_mapclick];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerColor "ColorBlue";
		_m setMarkerSize [(sliderPosition (uiNamespace getVariable "stig_sz_regler")),(sliderPosition (uiNamespace getVariable "stig_sz_regler"))];
		_m setMarkerText (format["Polizeisperrzone %1",_this]);
		_m setMarkerAlpha 0.5;
		_m setMarkerBrush "FDiagonal";
		
		comment "Marker Teil 2 erstellen (Zone)";
		_m = createMarker [format ["stig_sz_markerB%1",_this],stig_sz_mapclick];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerColor "ColorBlue";
		_m setMarkerSize [(sliderPosition (uiNamespace getVariable "stig_sz_regler")),(sliderPosition (uiNamespace getVariable "stig_sz_regler"))];
		_m setMarkerText (format["Polizeisperrzone %1",_this]);
		_m setMarkerAlpha 0.5;
		_m setMarkerBrush "SolidBorder";
		
		(uiNamespace getVariable "stig_sz_status") ctrlSetText "Sperrzone erstellt. Bereit.";
		
		stig_sz_vorschaumarker_var setMarkerPosLocal [0,0];
		stig_sz_vorschaumarker_var setMarkerSizeLocal [0,0];

		_this remoteExecCall ["stig_sz_msg_add",0,false];
		
		}; comment "End of Thread";
	};

	stig_sz_find =
	{
	if((getMarkerPos ( format ["stig_sz_markerA%1",_this] )) isEqualTo [0,0,0]) exitWith { hint format ["Sperrzone %1 existiert nicht.",_this]; };
	stig_sz_vorschaumarker_var setMarkerPosLocal (getMarkerPos ( format ["stig_sz_markerA%1",_this] ));
	stig_sz_vorschaumarker_var setMarkerSizeLocal (getMarkerSize ( format ["stig_sz_markerA%1",_this] ));
	};

	stig_sz_del =
	{
	if ((getMarkerPos ( format ["stig_sz_markerA%1",_this] )) isEqualTo [0,0,0]) exitWith { hint format ["Sperrzone %1 kann nicht gelöscht werden, da sie nicht erstellt wurde.",_this]; };
	deleteMarker (format["stig_sz_markerA%1",_this]);
	deleteMarker (format["stig_sz_markerB%1",_this]);
	(uiNamespace getVariable "stig_sz_status") ctrlSetText "Sperrzone entfernt. Bereit.";

	_this remoteExecCall ["stig_sz_msg_del",0,false];
	};
	
	
	diag_log "Sperrzonensystem erfolgreich geladen.";
	}
] remoteExec ["bis_fnc_spawn",-2,true];


stig_sz_msg_add =
{
_text = round (( player distance2D (getMarkerPos ( format ["stig_sz_markerA%1",_this]))) - ((getMarkerSize ( format ["stig_sz_markerA%1",_this])) select 0 ) );
if(_text < 0)then{
_text = "<br/><t color='#FF0000'>WARNUNG: Du bist in der Sperrzone!</t>"
}else{
_text = format ["<br/>Diese liegt %1 Meter von dir entfernt.",_text];
};

hint parseText format ["<t size='2'><t color='#0026FF'>Sperrzone</t></t><br/>Die Polizei hat eine neue Sperrzone ausgerufen.<br/>%1 <br/><br/>Für weitere Informationen, siehe auf dein GPS Gerät.",_text];
};
publicVariable "stig_sz_msg_add";


stig_sz_msg_del =
{
hint parseText "<t size='2'><t color='#0026FF'>Sperrzone</t></t><br/>Die Polizei hat eine Sperrzone entfernt.<br/>Du kannst das Gebiet nun wieder sicher betreten.";
};
publicVariable "stig_sz_msg_del";

diag_log "Sperrzonensystem erfolgreich geladen.";
