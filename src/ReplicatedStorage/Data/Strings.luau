--!strict
-- SEMUA pesan sistem (EN, verbatim kanon). Tabel murni id → teks; format lewat Shared/Strings.
-- Sumber: DESAIN_AI_NPC_V0 §7.3 (diutamakan bila ada dua versi) + DESAIN_SISTEM_V0 §5–§6.
-- Placeholder: {name} {stars} {party} {a} {sa} {b} {sb} {item} {n} … ('X'/'Party 1' di sumber).
-- String non-kanon diberi komentar -- NONKANON.

local Strings: { [string]: string } = {
	-- DESAIN_AI_NPC_V0 §7.3
	STRESS_WARN = "[Warning!]\n[Hero '{name} ({stars})'s stress level is dangerous!]", -- [K] ch.284
	SUDDEN_DEATH = "['{name} ({stars})' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]\n[Sudden death!]\n[Cause – Suicide due to stress]", -- [K] ch.7
	REFUSED = "['{name} ({stars})' refused to participate!]", -- [K] ch.47
	PARTY_UNCTRL = "['{party}' has become uncontrollable.]", -- [K] ch.48
	STRIKE_TIPS = "[Tips/Heroes sometimes strike. You can resolve this by accepting their demands or punishing the ringleader.]", -- [K] ch.48
	MASS_STRIKE = "[Mass strike!]\n[Heroes are rioting!]", -- [K] ch.65
	DUEL_CHALL = "['{a} ({sa})' challenges '{b} ({sb})' to a duel!]", -- [K] ch.28
	ENMITY = "['{a}' shows hostility towards '{b}'!]\n[Enmity has been established! Observe carefully between the heroes!]", -- [K] ch.49
	BOND_CREATED = "[A bond '{bond}' has been created!]", -- [K] ch.27
	BOND_DISBAND = "[The relationship '{bond}' will be disbanded.]", -- [K] ch.29
	COMFORT = "[Hero '{a} ({sa})' comforts her teammates!]\n[The morale of the raid team is rising!]", -- [K] ch.222
	AUTO_EXPLORE = "[Autonomous action is activated!]\n[Master hero '{name} ({stars})' starts exploring!]\n[The dowry is automatically distributed to the hero. 10000G consumed.]", -- [K] ch.218
	WANTS_GIFT = "['{name} ({stars})' wants '{item} X {n}'. Do you want to gift it?]", -- [K] ch.128
	REQ_FACILITY = "[Master hero '{name} ({stars})' requests the '{facility}' facility!]", -- [K] ch.244
	REQ_RETREAT = "[Master hero '{name} ({stars})' requests to retreat from the field!]", -- [K] ch.235
	ARCHIVE_DONE = "[The archive is complete! You can look back on the heroes who left in the arms of the goddess.]", -- [K] ch.79
	GRIEF_VISIT = "['{name}' spent the evening at the archive, in front of '{deceased}'s belongings.]", -- NONKANON
	MENTIONS_DECEASED = "['{name}' mentioned '{deceased}' again today.]", -- NONKANON (id §7.2; contoh §7.3 menyebut MENTIONS_DEAD)
	EXTORT = "['{a}' took '{item}' from '{b}' by force.]", -- NONKANON

	-- DESAIN_SISTEM_V0 §5.1 waiting room
	SPACETIME_OPEN = "[Open the space-time!]", -- [K] ch.7
	SPACETIME_COUNTDOWN = "[The door will open in 10 seconds. Get ready!]", -- [K] ch.8
	DAILY_MIRROR = "Just go inside the mirror!", -- [K] ch.25, 56 (tanpa kurung di sumber)
	ROOM_NAME_FIXED = "[Waiting room's name is fixed to '{room}'.]", -- [K] ch.41
	ROOM_LEVEL_UP = "[Waiting room evolves to level {level}! The number of floors increases.]", -- [K] ch.64 (sumber: "level 2")
	FACILITIES_OPENED = "[Additional facilities have been opened.]", -- [K] ch.85, 123

	-- §5.2 fasilitas · §5.3 research
	FACILITY_BUILD_PROMPT = "[Build the facility. Please touch the type of facility you want.]", -- [K] ch.8
	FACILITY_BUILD_CONFIRM = "[You have selected '{facility}'. Would you like to build? {gems} gems are consumed for construction.]", -- [K] ch.8 (sumber: "500 gems")
	RESEARCH_OPEN = "[Research is open.]", -- [K] ch.24, 34
	RESEARCHER_LIST = "[Researcher recommendation list!]", -- [K] ch.53
	DISSATISFIED = "['{name}' expresses dissatisfaction!]", -- [K] ch.53
	RESEARCH_LEVEL = "[Research '{research}' has become Lv.{level}.]", -- [K] ch.53

	-- §5.4 organisasi · §5.5 autonomous action · §5.6 peri
	RECOMMEND_LIST = "[List of recommended {position}!]", -- [K] ch.16, 17
	APPOINT_CONFIRM = "[Do you want to appoint '{name}' as {position}?]", -- [K] ch.16, 17 (sumber: "as …?")
	AUTONOMY_TIPS = "[If you want to stop unruly heroes, turn off the 'autonomous action' function!]", -- [K] ch.218, 262
	REQ_JOIN_PARTY = "['{name}' wants to join '{party}'. Do you allow it?]", -- [K] ch.16
	REQ_FIXED_PARTY = "[Hero '{name}' proposes a fixed party!]", -- [K] ch.30
	REQ_MISSION = "[Request – Go to the {floor} floor]\n[Purpose – {purpose}]\n[Do you accept?]", -- [K] ch.110 (sumber: "25th floor")
	FAIRY_PLAZA = "[The Master told me to come to the plaza when I log in!]", -- [K] §5.6

	-- §5.7 party · §5.8 duel & mock battle
	PARTY_FORM = "[Form a party.]", -- [K] ch.7
	PARTY_DRAG = "[Drag and drop heroes!]", -- [K] ch.7
	PARTY_JOINED = "['{name}' joins '{party}'!]", -- [K] ch.24
	PARTY_EXCLUDE = "[Exclude '{name}' from '{party}']", -- [K] ch.133
	PARTY_PROPOSE = "['{name}' proposes a party composition!]", -- [K] ch.30
	PARTY_PLAN = "['{party}' plan]", -- [K] ch.30
	PARTY_EXCLUDED = "['{name}' is excluded from '{party}'!]", -- [K] ch.30, 73
	PARTY_ENTERED_DAILY = "['{party}' has entered the Daily Dungeon]", -- [K] ch.25
	PARTY_LIMIT = "['{party}' is the limit level, so you won't grow!]", -- [K] ch.271
	DUEL_TIPS = "[Tips/Duels are one of the means of resolving disputes between heroes. Depending on the agreement of both sides, special conditions can be imposed.]", -- [K] ch.28
	DUEL_ACCEPTED = "['{b}' has accepted the duel.]", -- [K] ch.28
	DUEL_CONDITION = "[The duel condition suggested by each hero is '{condition}'. Do you agree?]", -- [K] ch.28
	DUEL_WON = "['{a}' won the duel!]", -- [K] ch.28, 71
	MOCK_TYPE = "[Type – 1 VS 1: Confrontation with AI]", -- [K] ch.148
	MOCK_COUNTDOWN = "[60 seconds until the game starts!]", -- [K] ch.148

	-- §6.1 stres · §6.3 likeability · §6.5 mogok · §6.8 pendidikan
	TIPS_STRESS = "[Heroes get tired, depressed, or panic. Reduce your stress level!]", -- [K] ch.7
	HERO_DIED = "['{name} ({stars})' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]", -- [K] ch.7
	COOKING_DISSATISFIED = "['{name}' is dissatisfied with the cooking.]", -- [K] ch.16
	GIFT_DELIGHTED = "['{name}' is delighted to receive the '{item}'.]", -- [K] ch.51, 121
	LIKE_UP = "[Likeability has risen!]", -- [K] ch.51, 121
	GIFT_DISAPPOINTED = "['{name}' is disappointed to receive the '{item}'.]", -- [K] ch.107, 135
	LIKE_DOWN = "[Lowered favorability!]", -- [K] ch.107, 135
	LIKE_DROP = "[Likeness has drastically decreased!]", -- [K] ch.107
	GIFT_NO_CHANGE = "['{name}' has no change.]", -- [K] ch.284
	GIFT_COST = "[{gold} gold will be consumed]", -- [K] ch.128
	PARTY_INOPERABLE = "['{party}' has become inoperable.]", -- [K] ch.65
	PARTY_OPERATIONAL = "['{party}' has become operational.]", -- [K] ch.52
	CHANGED_MIND = "[Excellent Master. The hero has changed his mind!]", -- [K] ch.52
	SKILL_AWAKENING = "[Heroes' souls awaken in critical situations!]\n[Skill Awakening!]", -- [K] ch.20, 140
}

return Strings
