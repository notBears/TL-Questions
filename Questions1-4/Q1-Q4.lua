--Q1 - Fix or improve the implementation of the below methods

--[[Added variable for storing the item key we are looking for to reduce
the amount of magic numbers in the script and to avoid confusing it with the 
milliseconds value set on the addEvent. Also changed the setStorageValue in the 
releaseStorage function to set the value to 0 instead of -1. Reasoning being that
if the item is set to -1 and the player gets 1 more of that item it would register
as them not having the item since the new amount in their inventory would be 0]]
itemKey = 1000

local function releaseStorage(player)
  player:setStorageValue(itemKey, 0)
end

function onLogout(player)
  if player:getStorageValue(itemKey) == 1 then
    addEvent(releaseStorage, 1000, player)
  end
  return true
end


--Q2 - Fix or improve the implementation of the below method

--[[Changed 'result' when referencing query result to the appropriate 'resultId' variable.
Also changed the getString method to the DBResult luaobject method getDataString(). then
I realized that this would only return one name from the results and implemented a for loop
that gets the number of rows in the result and iterates through them grabbing the current row's
guild name and then moving to the next row in the results.]]

function printSmallGuildNames(memberCount)
-- this method is supposed to print names of all guilds that have less than memberCount max members
  local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
  local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
  local resultRowCount = resultId.getRowCount()
  local guildName
  for name in resultRowCount do
    guildName = resultId.getDataString("name")
    print(guildName)
    resultId.next()
  end
end


--Q3 - Fix or improve the name and the implementation of the below method

--[[Changed function name to removePartyMember to better reflect what is happening here.
Removed the for loop since it appears unnecassary. The function within the loop that removes
the party member refers to passed in parameter 'membername' rather than any component provided
due to the loop. This shows that we can remove the loop and access the removal of the player
directly via the 'membername' variable.]]

function removePartyMember(playerId, membername)
  local player = Player(playerId)
  local party = player:getParty()
  party:removeMember(Player(membername)))
end

--Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

--[[In the first if statement we use 'new Player' so we need to account for this in the
rest of the function to make sure we are freeing the allocated memory with delete ]]

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);
	if (!player) {
		player = new Player(nullptr);
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			delete player;
			return;
		}
	}

	Item* item = Item::CreateItem(itemId);
	if (!item) {
		delete player;
		return;
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	if (player->isOffline()) {
		IOLoginData::savePlayer(player);
	}
	delete player;
}