local animationDelay = 200
local combat = {}

local area = {
    {
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 1, 0, 0, 0},
	    {0, 0, 0, 0, 0, 1, 1, 0, 0},
	    {1, 0, 0, 0, 2, 0, 1, 1, 1},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 1, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0}
    },
	{
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 1, 0, 1, 0, 0, 0},
	    {0, 0, 1, 0, 0, 1, 1, 0, 0},
	    {1, 1, 1, 0, 2, 0, 1, 1, 1},
	    {0, 0, 1, 1, 1, 1, 0, 0, 0},
	    {0, 0, 0, 1, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 1, 1, 1, 0, 0, 0},
	    {0, 0, 1, 1, 1, 1, 1, 0, 0},
	    {1, 1, 1, 1, 2, 1, 1, 1, 1},
	    {0, 0, 1, 1, 1, 1, 1, 0, 0},
	    {0, 0, 0, 1, 1, 1, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 1, 1, 1, 0, 0, 0},
	    {0, 0, 1, 1, 0, 0, 1, 0, 0},
	    {1, 1, 0, 0, 2, 0, 0, 1, 1},
	    {0, 0, 1, 0, 1, 1, 0, 0, 0},
	    {0, 0, 0, 1, 0, 1, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 1, 1, 1, 0, 0, 0},
	    {0, 0, 1, 1, 1, 1, 1, 0, 0},
	    {0, 0, 0, 0, 2, 1, 0, 0, 0},
	    {0, 0, 0, 0, 0, 1, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 1, 1, 1, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 2, 1, 0, 0, 0},
	    {0, 0, 0, 0, 1, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0},
	    {0, 0, 0, 0, 0, 0, 0, 0, 0}
    }
}

for i = 1, #area do
  combat[i] = Combat()
  combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
  combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
end

for x in ipairs(area) do
  combat[x]:setArea(createCombatArea(area[x]))
end

--function that addEvent calls to create the animated effect by playing each area in sequence.
function combatFrame(p, i)
  combat[i]:execute(p.player, p.var)
end

--Loops through the area array and uses addEvent to have each area appear sequentially with a pause between
function onCastSpell(player, var)
  local p = {player = player, var = var, combat = combat}

  for i = 1, #area do
    if i == 1 then
      combat[i]:execute(player, var)
	else
	  addEvent(combatFrame, (animationDelay * i) - animationDelay, p, i)
	end
  end
  return true
end