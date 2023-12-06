
local BASE_RegisterHandlers = RegisterHandlers;

local HOHNoticificationHash = DB.MakeHash("NOTIFICATION_OnGachaOfReviere")

function RegisterHandlers()

	BASE_RegisterHandlers();

	--m_DWRHash ?
	g_notificationHandlers[HOHNoticificationHash]						= MakeDefaultHandlers();
	g_notificationHandlers[HOHNoticificationHash].AddSound				= "ALERT_NEGATIVE";
end