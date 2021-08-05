public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_WALK && !IsPlayerInAnyVehicle(playerid))
    {
        new
            i = 0,
            frmt_quests_list[105 * 9];

        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));
        strcat(frmt_quests_list, GetQuestString(playerid, ++i, ...));

        return ShowPlayerDialogEx(playerid, DIALOG_STARTLINE_QUESTS_LIST, DIALOG_STYLE_LIST, !"...", frmt_quests_list, !"...", !"...");
    }
}

stock QuestDialog(playerid, dialogid, response, listitem)
{
	switch(dialogid)
	{

        case DIALOG_QUEST_ACCEPT:
        {
            if (!response)
                return 1;

            new selected = SelectedQuest[playerid];

            if ( pQuests[playerid][selected][qStatus] == QUEST_FORBIDDEN )
                return SendClientMessage(playerid, COLOR_WHITE, !"");

            if ( pQuests[playerid][selected][qStatus] == ... )
                return SendClientMessage(playerid, COLOR_WHITE, !"");

            if ( pQuests[playerid][selected][qStatus] == ... )
                return SendClientMessage(playerid, COLOR_WHITE, !"");

            if ( pQuests[playerid][selected][qStatus] == QUEST_AVAILABLE )
            {
                pQuests[playerid][selected][qStatus] = QUEST_INPROCESS;
                SendQuestAcceptMessage(playerid, selected);
                CheckPlayerQuestComplete(playerid, selected);
            }

            return 1;
        }

        case DIALOG_STARTLINE_QUESTS_LIST:
		{
			if (!response)
				return 1;

			new selected = -1;

			switch(listitem)
			{
				case 0: selected = QUEST_STARTLINE_...;
				case 1: selected = QUEST_STARTLINE_...;
				case 2: selected = QUEST_STARTLINE_...;
				case 3: selected = QUEST_STARTLINE_...;
				case 4: selected = QUEST_STARTLINE_...;
				case 5: selected = QUEST_STARTLINE_...;
				case 6: selected = QUEST_STARTLINE_...;
				case 7: selected = QUEST_STARTLINE_...;
				case 8: selected = QUEST_STARTLINE_...;
			}

			if ( selected == -1 )
				return SendClientMessage(playerid, -1, "...");

			if ( pQuests[playerid][selected][qStatus] == QUEST_FORBIDDEN )
				return SendClientMessage(playerid, COLOR_WHITE, !"");

			if ( pQuests[playerid][selected][qStatus] == QUEST_... )
				return SendClientMessage(playerid, COLOR_WHITE, !"");

			if ( pQuests[playerid][selected][qStatus] == QUEST_... )
				return ShowPlayerDialogEx(playerid, INVALID_DIALOG_ID, DIALOG_STYLE_MSGBOX, gQuestsNames[selected], GetPlayerQuestProcess(playerid, selected), !"Закрыть", !"");

			SelectedQuest[playerid] = selected;

			return ShowPlayerDialogEx(playerid, DIALOG_QUEST_ACCEPT, DIALOG_STYLE_MSGBOX, gQuestsNames[selected], GetQuestAcceptInfo(selected), !"Принять", !"Закрыть");
		}

    }

    return 1;

}