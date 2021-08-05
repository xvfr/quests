enum
{
	QUEST_STARTLINE_...,
	QUEST_STARTLINE_...,
	QUEST_STARTLINE_...,
	QUEST_STARTLINE_...,

	QUEST_SIDELINE_...,
	QUEST_SIDELINE_...,
	QUEST_SIDELINE_...,
	QUEST_SIDELINE_....,
}

enum
{
	QUEST_AVAILABLE,
	QUEST_FORBIDDEN,
	QUEST_...,
	QUEST_...,
	QUEST_...
}

new gQuestsNames[][] =
{
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	""
}

enum E_QUESTS_INFO
{
	qProcess,
	qStatus
}

new
	SelectedQuest[MAX_PLAYERS],
	pQuests[MAX_PLAYERS][QUESTS_COUNT][E_QUESTS_INFO];

stock GetQuestStatusString(playerid, questid)
{
	new
		frmt_status[30];

	switch(pQuests[playerid][questid][qStatus])
	{
		case QUEST_AVAILABLE:
			strcat(frmt_status, "[Доступно]");

		case QUEST_FORBIDDEN:
			strcat(frmt_status, "[Недоступно]");
	}

	return frmt_status;
}

stock GetQuestString(playerid, i, questid)
{
	new
		frmt_quest[5 + 55 + 30 + 8 + 8];

	format(frmt_quest, sizeof frmt_quest, "{FF9900}%d.{FFFFFF} %s %s\n", i, gQuestsNames[questid], GetQuestStatusString(playerid, questid));

	return frmt_quest;
}


forward LoadPlayerQuests(playerid);
public LoadPlayerQuests(playerid)
{
	for(new quest = 0; quest < QUESTS_COUNT; quest++)
	{
		pQuests[playerid][quest][qStatus] = QUEST_FORBIDDEN;
		pQuests[playerid][quest][qProcess] = 0;
	}

	pQuests[playerid][QUEST_DAILY_...][qStatus] = QUEST_AVAILABLE;
	pQuests[playerid][QUEST_DAILY_...][qStatus] = QUEST_AVAILABLE;
	pQuests[playerid][QUEST_DAILY_...][qStatus] = QUEST_AVAILABLE;

	// -------- -------- -------- //

	new rows, fields;
	cache_get_data(rows, fields);

	if ( !rows )
	{
		pQuests[playerid][QUEST_STARTLINE_...][qStatus] = QUEST_AVAILABLE;
		pQuests[playerid][QUEST_STARTLINE_...][qProcess] = 0;
	}
	else
	{
		for(new i; i < rows; i++)
		{
			new questid = cache_get_field_content_int(i, "quest_id");
			pQuests[playerid][questid][qStatus] = cache_get_field_content_int(i, "status");
			pQuests[playerid][questid][qProcess] = cache_get_field_content_int(i, "process");
		}
	}

	return 1;

}

stock SavePlayerQuests(playerid)
{
	new
		frmt_save_quests[85],
		quests_save_quest[sizeof frmt_save_quests * QUESTS_COUNT];

	strcat(quests_save_quest, "INSERT INTO `quests` (`player_id`, `quest_id`, `status`, `process`) VALUES ");

	for(new quest; quest < QUESTS_COUNT; quest++)
	{
		format(frmt_save_quests, sizeof frmt_save_quests, "(%d, %d, %d, %d)%s", PI[playerid][pID], quest, pQuests[playerid][quest][qStatus], pQuests[playerid][quest][qProcess], (quest + 1 == QUESTS_COUNT) ? ("") : (","));
		strcat(quests_save_quest, frmt_save_quests);
	}

	strcat(quests_save_quest, " ON DUPLICATE KEY UPDATE `status` = VALUES(`status`), `process` = VALUES(`process`)");

	mysql_tquery(mysql, quests_save_quest);

	return 1;
}

stock CheckPlayerQuestComplete(playerid, questid)
{
	new
		process = pQuests[playerid][questid][qProcess],
		status = pQuests[playerid][questid][qStatus],
		new_status = -1;
	
	if ( status != QUEST_... )
		return 1;

	switch(questid)
	{
		case ...: 
		{
			if ( process >= 2000 )
			{
				GiveMoney(playerid, 500, "...");
				PI[playerid][pExp] += 2;
				CheckNextLevel(playerid);
				new_status = QUEST_COMPLETED;
				SendClientMessage(playerid, COLOR_WHITE, !"");
				if ( PI[playerid][pLevel] < 8 )
					pQuests[playerid][...][qStatus] = QUEST_AVAILABLE;
			} 
		}

	}

	if ( new_status != -1 )
		pQuests[playerid][questid][qStatus] = new_status;

	return 1;
}



