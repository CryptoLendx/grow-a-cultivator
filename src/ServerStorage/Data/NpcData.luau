--!strict
-- M0 "kehendak bebas NPC": SEMUA koefisien DESAIN_AI_NPC_V0 (§1–§8). Tabel murni, tanpa logika;
-- rumus dijalankan di Autonomy/, Mental/, Social/. Nama tabel di RENCANA §2: AutonomyData → NpcData.
-- Semua angka (TERBUKA) = default docs, dikalibrasi §9 (tugas 4.4) — kecuali berlabel [K]/[N].
-- Bentuk rumus sebagai data:
--   Linear  = k + Σ koef·variabel (variabel: H E X A C O cou couEff xp ld vul st a t f I star level rReceived)
--   Product = base × Π Linear
-- Satuan waktu: hari in-game (1 hari Bumi = 3 hari in-game). Kebutuhan, stres, sifat: 0–100.

export type Linear = { [string]: number }
export type Product = { base: number, factors: { Linear } }
export type Range = { min: number, max: number }
export type Step = { days: number, mult: number }

export type ActionConfig = {
	gain: { [string]: number }, -- Δ kebutuhan bila aksi dipilih (dipakai di U dan saat resolusi)
	bias: Linear, -- bias sifat (0 bila tidak ada)
	goal: { [string]: number }?, -- bias bila goal hero cocok
	params: { [string]: number }?, -- syarat, efek lain, risiko
	social: boolean, -- aksi sosial (−50 % saat st ≥ 70 / luka moral)
	light: boolean, -- aksi ringan (boleh ditambah di samping aksi utama bila rest ≥ 30)
}

export type NpcConfig = {
	traits: {
		dims: { string },
		mean: number,
		sd: number,
		min: number,
		max: number,
		cMeanByStar: { number },
	},
	drift: {
		minShift: number,
		maxShift: number,
		pNoShift: number,
		intimateDeath: { [string]: number },
		synthesisWitnessedOptions: { { [string]: number } },
		mvpRepeat: { [string]: number },
		mvpRepeatCount: number,
		mentorDays: number,
		mentor: { [string]: number },
		punished: { [string]: number },
		isolationDays: number,
		isolationEPer30: number,
		isolationOPer60: number,
		isolationForgetMult: number,
		stagnationCPerWeek: number,
	},
	xp: {
		min: number,
		max: number,
		seedByStar: { number },
		habituation: number,
		habituationCritical: number,
		criticalHpPct: number,
		cap: Linear,
		sensitization: number,
		sensitizationComradeDied: number,
		recoveryDays: number,
		recoveryStBelow: number,
		fearCountsAsEpisode: boolean,
		susceptibleEMin: number,
		susceptibleMult: number,
		mentorPerWeek: number,
	},
	couEff: Linear,
	awareness: { trainBias: number, envyStatGap: number, envyStatWeight: number },
	memory: {
		capacity: number,
		valenceMin: number,
		valenceMax: number,
		kinds: { string },
		keyKinds: { string },
	},
	needs: {
		ids: { string },
		min: number,
		max: number,
		initial: number,
		rest: {
			decay: number,
			trainingMult: Linear,
			mission: number,
			position: number,
			crowd: Linear,
			restAction: number,
			bathhouse: number,
		},
		food: {
			decay: number,
			meal: number,
			chefMatch: number,
			mealFloor1NoRestaurant: number,
		},
		aut: {
			decay: number,
			decayMult: Linear,
			forced: number,
			requestDenied: number,
			requestGranted: number,
			ownChoice: number,
		},
		cmp: {
			decay: number,
			decayMult: Linear,
			mvp: number,
			floorUp: number,
			duelLost: number,
			monotoneDays: number,
			monotonePerDay: number,
			monotoneHighOMult: number,
			monotoneHighO: number,
		},
		rel: {
			decay: number,
			decayMult: Linear,
			target: Linear,
			fixedParty: number,
			eatTogether: number,
			comforted: number,
			intimateFloor: number,
		},
	},
	stress: {
		vul: Linear,
		initialSt: number,
		initialLd: number,
		vulPerIntimateLoss: number,
		breakThreshold: Linear,
		recoverBase: Product,
		needPull: { [string]: number },
		riseMult: Linear,
		ld: { riseAtSt: number, riseAfterDays: number, fallBelowSt: number, fallAfterDays: number },
		sources: {
			mission: number,
			combatStreakMult: { Step },
			humanoid: Range,
			comradeDiedBeside: number,
			intimateMult: number,
			roomDeath: number,
			synthesisWitnessed: number,
			synthesisWitnessedClose: number,
			synthesisThreat: number,
			trainingSessionsFree: number,
			trainingPerExtraSession: number,
			researchHoursFree: number,
			researchPerExtraHour: number,
			notInvolvedDays: number,
			notInvolvedPerDay: number,
			positionPerDay: number,
			demoted: number,
			punished: number,
			moralInjury: number,
		},
		reducers: {
			rest: number,
			sleepMult: number,
			trustedSupportMult: number,
			trustedSupportMinT: number,
			hobby: number,
			hobbyMult: number,
			vacationPerDay: number,
			giftMatch: number,
			giftMatchMaxSt: number,
			cheering: number,
			eatTogether: number,
			floorUpOrMvp: number,
			comfortItemPerDay: number,
			griefRitual: number,
			goalAchieved: number,
		},
	},
	moralInjury: {
		guiltMin: number,
		guiltMax: number,
		guiltCap: number,
		synthesisMinA: number,
		humanoidMinA: number,
		likeMaster: number,
		withdrawalSocialMult: number,
		withdrawalDays: number,
		redemption: number,
		comfortMinT: number,
	},
	suddenDeath: {
		relBelow: number,
		protectT: number,
		protectA: number,
		lossWithinDays: number,
		failedMissions: number,
		comfortedWithinDays: number,
		p: Product,
		warnMargin: number,
		warnWindow: Range,
	},
	likeability: {
		min: number,
		max: number,
		initial: number,
		up: { [string]: number },
		down: { [string]: number },
		giftMaxSt: number,
		greatlyDisappointedMaxH: number,
	},
	relations: {
		dims: { [string]: Range },
		neutral: { [string]: number },
		enmityA: number,
		groupEnmityA: number,
		bond: { t: number, a: number },
		oath: { a: number, t: number, f: number },
		interaction: {
			floorPerDay: number,
			plazaEveryDays: number,
			maxPerDay: number,
		},
		fWeights: { [string]: number },
		hall: { friend: number, close: number, intimate: number },
		homophilyMaxDiff: number,
		aPositive: number,
		tKept: number,
		tCompetence: number,
		tIntegrity: number,
		tIntegrityRecoveryMult: number,
		rPrestige: number,
		rLeaderSuccess: number,
		rLeaderFail: number,
		dHelped: number,
		dRepaid: number,
		debtGuiltMin: number,
		debtGuiltDays: number,
		debtGuilt: number,
		envy: {
			maxStarGap: number,
			admirationStarGap: number,
			benignTrainingBonus: number,
			benignDays: number,
			maliciousA: number,
			unfairGiftRatio: number,
		},
		fusionDecayDays: number,
		fusionDecay: number,
		decayDays: number,
		fFloorOfPeak: number,
		slots: number,
		intimateSlots: number,
		innerCircle: Range,
		focus: Linear,
		implicit: { [string]: { [string]: number } },
	},
	mentor: {
		minR: number,
		minTeacherA: number,
		minStarGap: number,
		skillMultMax: number,
		teacherCmpPerDay: number,
		fMult: number,
		studentDPerWeek: number,
		refuseStudentHBelow: number,
		refuseStudentCBelow: number,
		surpassR: number,
		surpassCmp: number,
		surpassProudMinA: number,
		surpassEnvyBelowA: number,
		oathOrMentorGriefMult: number,
	},
	groups: {
		tags: { string },
		inGroupA: number,
		grvMin: number,
		grvMax: number,
		references: Range,
		voiceGrvMin: number,
		voiceXMin: number,
		voiceSpread: number,
		cliqueT: number,
		cliqueA: number,
		cliqueMin: number,
		factionGrvMin: number,
		leaderScore: Linear,
		leaderFloorPercentile: number,
		identityShareMin: number,
		cynicismTrainingMult: number,
		punishedGrv: number,
		punishedMoralMinA: number,
		punishedLike: number,
		acceptedGrv: number,
		acceptedLike: number,
		freeRiderSize: number,
		freeRiderIdle: number,
		evaluateEveryDays: number,
	},
	utility: {
		weights: { [string]: number },
		stressedSt: number,
		stressedWeightMult: { [string]: number },
		stressedSocialMult: number,
		noise: number,
		lightMinRest: number,
		order: { string },
		actions: { [string]: ActionConfig },
	},
	duty: { skipTrainingMaxC: number, skipTrainingMaxA: number, skipTrainingLeaderA: number },
	command: {
		base: number,
		danger: number,
		dangerFrom: number,
		unfair: number,
		like: number,
		aut: number,
		leaderTrust: number,
		max: number,
		traitMult: Linear,
		requestMinStar: number,
		requestMinLike: number,
		requestShare: number,
		subMasterInitiativeMult: number,
		solidarityMinA: number,
		solidarityP: number,
		compound: {
			restDaysMin: number,
			sameConcessionRepeat: number,
			repeatMult: number,
			forcedMinP: number,
			forcedAut: number,
		},
	},
	strike: {
		acceptGrv: number,
		acceptLike: number,
		acceptAut: number,
		punishMoralMinA: number,
		punishLike: number,
		punishGrv: number,
		sendOtherDays: number,
		sendOtherAut: number,
		massStrikeFloorShare: number,
		ignoredGrvPerDay: number,
		ignoredCynicismDays: number,
		ignoredCynicismMaxCouEff: number,
		ignoredLeaveDays: number,
		ignoredLeaveMinCouEff: number,
	},
	initiative: { revengeP: number, revengeDays: number, revengeAbsentDays: number },
	duel: {
		disputeA: number,
		seatMaxR: number,
		maliciousEnvyDays: number,
		pDispute: Product,
		pSeat: number,
		pSeatGoalMult: number,
		acceptMinCouEff: number,
		acceptMaxH: number,
		synthesisMaxA: number,
		synthesisMaxH: number,
		loserR: number,
		humiliatedA: number,
		humiliatorMaxA: number,
		interference: boolean,
	},
	theft: {
		maxH: number,
		stealNeedMax: number,
		caught: number,
		caughtManagerBonus: number,
		victimT: number,
		jailDays: number,
		jailSt: number,
		jailAut: number,
		pardonLike: number,
		extortMinX: number,
		extortMinTargetR: number,
		extortVictimGrv: number,
		extortVictimAut: number,
		extortVictimDuelMinCouEff: number,
		extortReportP: number,
		extortRepeat: number,
		extortRepeatFloorGrv: number,
	},
	provoke: { a: number, targetMaxA: number, enmitySummonEvery: number, enmitySummonP: number },
	reconcile: {
		minA: number,
		minX: number,
		p: number,
		partnerMinA: number,
		a: number,
		giftBonusA: number,
	},
	social: {
		befriendP: Linear,
		comfortP: Linear,
		comfortMinX: number,
		comfortMinA: number,
		comfortMinAff: number,
		comfortTargetSt: number,
		comfortSt: number,
		comfortGuilt: number,
		comfortA: number,
		comfortD: number,
		oathP: number,
		cliqueFixedPartyMin: number,
	},
	requests: {
		p: { [string]: number },
		giftMaxCmp: number,
		facilityMaxRest: number,
		facilityMinC: number,
		joinMaxRel: number,
		fixedMinX: number,
		recordMinC: number,
		mockMinO: number,
		mockMinLike: number,
		declineMinAut: number,
		subMasterMult: number,
		grantedAut: number,
		grantedLike: number,
		grantedD: number,
		deniedAut: number,
		deniedLike: number,
		deniedStreak: number,
		deniedMemoryValence: number,
	},
	grief: {
		mournMinA: number,
		mournMinT: number,
		intensity: Product,
		intimateMult: number,
		suddenMult: number,
		duration: Product,
		supportMult: number,
		witnessedMult: number,
		serialLossDays: number,
		serialLossMult: number,
		priorStressSt: number,
		priorStressMult: number,
		reliefMaxA: number,
		reliefDays: number,
		intimateDurationMult: number,
		lossModePStart: number,
		lossModePEnd: number,
		productivityMult: number,
		lossModeRel: number,
		stressPeakPerI: number,
		secondPeakDays: Range,
		mementoStPerDay: number,
		mentionPStart: number,
		mentionPEnd: number,
		ritualSt: number,
		ritualF: number,
		ritualMasterLike: number,
		ignoredGrv: number,
		ignoredDurationMult: number,
		survivorGuilt: number,
		survivorCouldHelpGuilt: number,
		survivorCouldHelpHpPct: number,
		leaderGuilt: number,
		soleSurvivorGuilt: number,
		soleSurvivorDurationMult: number,
		humorMinX: number,
		humorMaxE: number,
		humorP: number,
		humorSt: number,
		humorA: number,
		traitShiftP: number,
	},
	events: {
		cookingMaxFood: number,
		cookingP: number,
		cookingTipsShare: number,
		researchMaxHours: number,
		stagnationMinFloor: number,
		stagnationMinNeed: number,
		stagnationDays: number,
		boredomDays: number,
		judgeMasterMaxLike: number,
		judgeMasterDays: number,
		judgeMasterRequestMult: number,
		contagionMinA: number,
		contagionSourceSt: number,
		contagionStPerDay: number,
		denialDays: Range,
		denialShoutMinE: number,
		denialSilentMaxE: number,
		denialCancelLike: number,
	},
	hidden: {
		fearResistance: Linear,
		stressBandAt: { number },
		compatibility: Linear,
		compatibilityMaliciousPenalty: number,
		compatibilityRange: Range,
		hesitation: Linear,
		hesitationMinA: number,
	},
	mission: {
		awakeningCmp: number,
		lowContributionMissions: number,
		lowContributionCmp: number,
		lowContributionGuilt: number,
	},
	catchUp: {
		maxDays: number,
		daysPerEarthDay: number,
		restNeedTarget: number,
		restStPerDay: number,
		onlineTickHours: number,
		yieldEveryHeroes: number,
	},
}

local NpcData: NpcConfig = {
	-- §1.2 roll sifat "genetik": clamp(round(N(mean, sd)), min, max) per dimensi; tidak berkorelasi dengan ★.
	traits = {
		dims = { "H", "E", "X", "A", "C", "O", "cou" }, -- urutan byte di hero.npc.tr (§1.6)
		mean = 50, -- TERBUKA
		sd = 15, -- TERBUKA: [PSI §1] SD 15
		min = 0, -- skala 0–100
		max = 100, -- skala 0–100
		cMeanByStar = { 45, 50, 55 }, -- TERBUKA: μ C untuk 1★ / 2★ / 3★+ (seleksi asal [N] ch.10)
	},

	-- §1.2 plastisitas lambat: peristiwa besar menggeser sifat 2–5 poin; 50 % hero tidak bergeser.
	drift = {
		minShift = 2, -- TERBUKA: 0,1 SD
		maxShift = 5, -- TERBUKA: 0,3 SD — batas per peristiwa
		pNoShift = 0.5, -- TERBUKA: sebagian hero tidak bergeser sama sekali
		intimateDeath = { E = 3, X = -2 }, -- TERBUKA: kematian ikatan intim
		synthesisWitnessedOptions = { { H = -2 }, { A = -2 } }, -- TERBUKA: sintesis rekan disaksikan (H −2 ATAU A −2)
		mvpRepeat = { X = 2 }, -- TERBUKA: MVP berulang
		mvpRepeatCount = 5, -- TERBUKA: ≥5× MVP
		mentorDays = 90, -- TERBUKA: menjadi instruktur/mentor 90 hari
		mentor = { A = 2, C = 2 }, -- TERBUKA
		punished = { A = -3 }, -- TERBUKA: dihukum
		isolationDays = 60, -- TERBUKA: tanpa interaksi ternotasi ≥60 hari (kanon Aaron ch.352–353)
		isolationEPer30 = 1, -- TERBUKA: E +1 per 30 hari isolasi
		isolationOPer60 = -1, -- TERBUKA: O −1 per 60 hari isolasi
		isolationForgetMult = 2, -- TERBUKA: memori tertua non-kunci terhapus 2× lebih cepat
		stagnationCPerWeek = -1, -- TERBUKA: §6.11 stagnasi kemewahan, C −1/minggu [N] ch.156
	},

	-- §1.2a pengalaman tempur `xp` (lingkungan) — habituasi vs sensitisasi.
	xp = {
		min = 0, -- skala 0–100
		max = 100, -- skala 0–100
		seedByStar = { 0, 15, 40 }, -- TERBUKA: seed 1★ / 2★ / 3★+ [N] ch.10
		habituation = 2, -- TERBUKA: misi selamat tanpa panic
		habituationCritical = 4, -- TERBUKA: selamat dari situasi kritis tanpa panic
		criticalHpPct = 30, -- TERBUKA: kritis = minHpPct < 30 atau rekan party mati (§8.2)
		cap = { k = 40, cou = 0.6 }, -- TERBUKA: xp_max = 40 + 0,6·cou
		sensitization = -3, -- TERBUKA: episode panic/despair tanpa ≥3 hari pemulihan
		sensitizationComradeDied = -6, -- TERBUKA: episode itu berujung rekan mati di sisinya
		recoveryDays = 3, -- TERBUKA: hari pemulihan yang membatalkan sensitisasi
		recoveryStBelow = 50, -- TERBUKA: pemulihan = st < 50
		fearCountsAsEpisode = false, -- TERBUKA §10.2 #7: `fear` saja bukan episode sensitisasi (default: tidak)
		susceptibleEMin = 65, -- TERBUKA: differential susceptibility E ≥ 65
		susceptibleMult = 1.5, -- TERBUKA: pengali kedua arah
		mentorPerWeek = 1, -- TERBUKA: §4.5 murid berflag mentor +1/minggu
	},

	-- §1.2a nyali efektif (dipakai semua rumus reaksi; clamp 0–100): cou + 0,3·xp − 0,2·ld.
	couEff = { k = 0, cou = 1, xp = 0.3, ld = -0.2 }, -- TERBUKA

	-- §1.6a Hero Reactivity Lv.1 (`awr` di core): hanya berlaku bila flag aktif.
	awareness = {
		trainBias = 0.3, -- TERBUKA: bias latih +0,3·(1 − rank_percentile stat kelas di party)
		envyStatGap = 15, -- TERBUKA: selisih stat kelas ≥15 pada mitra ★ sama memicu evaluasi iri
		envyStatWeight = 0.5, -- TERBUKA: bobot ×0,5 dari pemicu peristiwa
	},

	-- §1.5 memori episodik {day, kind, otherId?, valence}.
	memory = {
		capacity = 10, -- TERBUKA: 5–10 per hero, kapasitas 10
		valenceMin = -2, -- rentang valensi
		valenceMax = 2, -- rentang valensi
		kinds = {
			"survivedTogether", -- selamat-bersama
			"diedBesideMe", -- rekan-mati-di-sisiku
			"mvp", -- MVP
			"lostDuel", -- kalah-duel
			"wonDuel", -- menang-duel
			"punished", -- dihukum
			"demandAccepted", -- tuntutan-diterima
			"memorableGift", -- gift-berkesan
			"savedBy", -- diselamatkan-oleh
			"saved", -- menyelamatkan
			"betrayed", -- dikhianati
			"floorUp", -- naik-lantai
			"floorDown", -- turun-lantai
			"comradeSynthesized", -- disintesis-rekanku
		},
		keyKinds = { "diedBesideMe" }, -- ASUMSI: memori kunci = kematian ikatan intim (flag kunci per memori, bukan per kind)
	},

	-- §2.2 kebutuhan non-hierarkis (poin/hari in-game).
	needs = {
		ids = { "rest", "food", "aut", "cmp", "rel" },
		min = 0, -- skala 0–100
		max = 100, -- skala 0–100
		initial = 50, -- ASUMSI: docs tidak menyebut nilai awal saat summon; netral seperti likeability awal (LAPORAN 2026-09-26b Q2). rel awal = max(ini, lantai sendiri)
		rest = {
			decay = -8, -- TERBUKA
			trainingMult = { k = 1, C = 0.003 }, -- TERBUKA: ×(1 + 0,3·C/100) bila berlatih
			mission = -25, -- TERBUKA
			position = -3, -- TERBUKA: jabatan
			crowd = { k = -2, X = 0.02 }, -- TERBUKA: keramaian −2·(1 − X/100) (party 5 + plaza penuh)
			restAction = 25, -- TERBUKA §5.2 aksi istirahat
			bathhouse = 35, -- TERBUKA §5.2 istirahat dengan Bathhouse
		},
		food = {
			decay = -20, -- TERBUKA
			meal = 30, -- TERBUKA: makan tersedia
			chefMatch = 10, -- TERBUKA: Chef cocok
			mealFloor1NoRestaurant = 18, -- TERBUKA: lantai 1 tanpa Restaurant (menggantikan `meal`)
		},
		aut = {
			decay = -1, -- TERBUKA
			decayMult = { k = 1, O = 0.01 }, -- TERBUKA: ×(1 + O/100)
			forced = -15, -- TERBUKA: dipaksa (frustrasi ≠ tidak dipenuhi)
			requestDenied = -5, -- TERBUKA
			requestGranted = 8, -- TERBUKA
			ownChoice = 3, -- TERBUKA: memilih aksi sendiri
		},
		cmp = {
			decay = -3, -- TERBUKA
			decayMult = { k = 1.2, H = -0.006 }, -- TERBUKA: ×(0,6 + (100−H)/100·0,6)
			mvp = 25, -- TERBUKA
			floorUp = 20, -- TERBUKA
			duelLost = -10, -- TERBUKA
			monotoneDays = 5, -- TERBUKA: tugas monoton ≥5 hari
			monotonePerDay = -2, -- TERBUKA
			monotoneHighOMult = 1.5, -- TERBUKA: O tinggi ×1,5
			monotoneHighO = 60, -- TERBUKA: "O tinggi" = O ≥ 60 (§6.11)
		},
		rel = {
			decay = -3, -- TERBUKA
			decayMult = { k = 0.4, X = 0.01 }, -- TERBUKA: ×(0,4 + X/100) — penyendiri turun lambat
			target = { k = 40, X = 0.6 }, -- TERBUKA: target rel = 40 + 0,6·X (kontinum, bukan kategori)
			fixedParty = 2, -- TERBUKA
			eatTogether = 3, -- TERBUKA
			comforted = 6, -- TERBUKA
			intimateFloor = 40, -- TERBUKA: ada ikatan intim → rel tidak pernah < 40
		},
	},

	-- §3.2–§3.3 stres (diatesis–stres + allostatic load).
	stress = {
		vul = { k = 50, E = 0.5, cou = -0.3, C = -0.2 }, -- TERBUKA: 0,5·E + 0,3·(100−cou) + 0,2·(100−C) (cou genetik)
		initialSt = 0, -- ASUMSI: hero baru tanpa stres (docs tidak menyebut)
		initialLd = 0, -- ASUMSI: allostatic load mulai 0 (akumulator)
		vulPerIntimateLoss = 3, -- TERBUKA: tiap kehilangan ikatan intim, permanen-ish
		breakThreshold = { k = 90, vul = -0.3, ld = -0.2 }, -- TERBUKA: 90 − 0,3·vul − 0,2·ld
		recoverBase = { base = 4, factors = { { k = 1.4, vul = -0.008 }, { k = 1, xp = 0.002 } } }, -- TERBUKA: 4·(0,6 + (100−vul)/100·0,8)·(1 + 0,2·xp/100)
		needPull = { rest = 0.1, aut = 0.05, cmp = 0.05, rel = 0.05 }, -- TERBUKA: st += koef·(100 − need)
		riseMult = { k = 1, ld = 0.005 }, -- TERBUKA: laju naik stres ×(1 + ld/200)
		ld = {
			riseAtSt = 60, -- TERBUKA: ld +1/hari bila st ≥ 60
			riseAfterDays = 1, -- TERBUKA: naik hanya setelah ≥1 hari st ≥ 60 (brief 2.3)
			fallBelowSt = 40, -- TERBUKA: ld −1/hari bila st < 40 …
			fallAfterDays = 7, -- TERBUKA: … selama ≥7 hari berturut
		},
		sources = {
			mission = 10, -- TERBUKA: per misi [K] ch.8
			combatStreakMult = { { days = 4, mult = 1.5 }, { days = 8, mult = 2.5 } }, -- TERBUKA: hari tempur beruntun ke-≥4 / ≥8
			humanoid = { min = 5, max = 10 }, -- TERBUKA: misi vs humanoid bila keengganan/A tinggi [N] ch.57
			comradeDiedBeside = 20, -- TERBUKA [N] ch.42
			intimateMult = 2, -- TERBUKA: ikatan intim ×2
			roomDeath = 4, -- TERBUKA: rekan lain di room mati
			synthesisWitnessed = 8, -- TERBUKA [N] ch.48, 64
			synthesisWitnessedClose = 15, -- TERBUKA: bila rekan dekat
			synthesisThreat = 15, -- TERBUKA [N] ch.48
			trainingSessionsFree = 2, -- TERBUKA: latihan >2 sesi/hari …
			trainingPerExtraSession = 4, -- TERBUKA: … +4/sesi [N] ch.70
			researchHoursFree = 3, -- TERBUKA: jam riset >3 … [K] ch.53
			researchPerExtraHour = 3, -- TERBUKA: … +3/jam
			notInvolvedDays = 7, -- TERBUKA: tidak dilibatkan ≥7 hari (goal ≠ calm) …
			notInvolvedPerDay = 2, -- TERBUKA: … +2/hari [N] ch.159
			positionPerDay = 2, -- TERBUKA: beban jabatan [N] ch.162
			demoted = 12, -- TERBUKA: diturunkan lantai/party; digantikan
			punished = 15, -- TERBUKA [N] ch.113
			moralInjury = 10, -- TERBUKA: + guilt (§3.4)
		},
		reducers = {
			rest = -8, -- TERBUKA: aksi istirahat [N] ch.7
			sleepMult = 1.5, -- TERBUKA: tidur cukup ×1,5
			trustedSupportMult = 1.4, -- TERBUKA: pengali pulih dari rekan dipercaya [K] ch.222
			trustedSupportMinT = 9, -- TERBUKA: "dipercaya" = t ≥ 9
			hobby = -5, -- TERBUKA [N] ch.383, 273
			hobbyMult = 1.2, -- TERBUKA: pengali pulih hobi
			vacationPerDay = -20, -- TERBUKA [N] ch.134
			giftMatch = -10, -- TERBUKA: hanya bila st < giftMatchMaxSt [K] ch.284 "no change"
			giftMatchMaxSt = 70, -- TERBUKA
			cheering = -5, -- TERBUKA [N] ch.120
			eatTogether = -2, -- TERBUKA [N] ch.22
			floorUpOrMvp = -8, -- TERBUKA [N] ch.156
			comfortItemPerDay = -1, -- TERBUKA [N] ch.166
			griefRitual = -6, -- TERBUKA: semua yang hadir [K] ch.79
			goalAchieved = -15, -- TERBUKA [N] ch.355
		},
	},

	-- §3.4 luka moral (terpisah dari takut).
	moralInjury = {
		guiltMin = 15, -- TERBUKA: guilt +15…+30 per pemicu
		guiltMax = 30, -- TERBUKA
		guiltCap = 100, -- skala guilt 0–100
		synthesisMinA = 8, -- TERBUKA: pemicu (a) semua yang a ≥ 8 ke korban sintesis
		humanoidMinA = 65, -- TERBUKA: pemicu (b) melawan humanoid bagi A ≥ 65
		likeMaster = -10, -- TERBUKA: pengkhianatan oleh otoritas
		withdrawalSocialMult = 0.5, -- TERBUKA: aksi sosial −50 % …
		withdrawalDays = 14, -- TERBUKA: … selama 14 hari
		redemption = -20, -- TERBUKA: menyelamatkan rekan → guilt −20
		comfortMinT = 9, -- TERBUKA: penerimaan rekan = dihibur oleh t ≥ 9
	},

	-- §3.5 sudden death — roll harian hanya bila SEMUA faktor terpenuhi.
	suddenDeath = {
		relBelow = 30, -- TERBUKA: rel < 30
		protectT = 9, -- TERBUKA: relasi ke hero HIDUP t ≥ 9 mematikan roll
		protectA = 8, -- TERBUKA: … atau a ≥ 8
		lossWithinDays = 30, -- TERBUKA: kehilangan besar ≤30 hari …
		failedMissions = 3, -- TERBUKA: … ATAU gagal berulang ≥3 misi tanpa kontribusi
		comfortedWithinDays = 3, -- TERBUKA: dihibur dalam 3 hari terakhir = pelindung
		p = { base = 0.03, factors = { { k = 1, vul = 0.01 }, { k = 1, ld = 0.01 } } }, -- TERBUKA: 0,03·(1 + vul/100)·(1 + ld/100) per hari
		warnMargin = 15, -- TERBUKA: warning [K] ch.284 saat st ≥ ambang − 15, 1× per episode
		warnWindow = { min = 3, max = 10 }, -- TERBUKA: jendela pemain 3–10 hari (hasil yang diharapkan)
	},

	-- §3.6 likeability ke master (0–100).
	likeability = {
		min = 0, -- skala 0–100
		max = 100, -- skala 0–100
		initial = 50, -- TERBUKA: nilai awal saat summon, netral (LAPORAN 2026-09-25 Q4)
		up = {
			giftMatch = 8, -- TERBUKA: hanya saat st < giftMaxSt [K] ch.51
			strikeAccepted = 10, -- TERBUKA [K] ch.52
			requestGranted = 4, -- TERBUKA
			welfarePerDay = 0.3, -- TERBUKA: Restaurant + Bathhouse
			cheering = 2, -- TERBUKA
			ritualAttended = 5, -- TERBUKA: master menghadiri ritual duka
		},
		down = {
			giftHated = -12, -- TERBUKA [K] ch.107, 135
			greatlyDisappointed = -20, -- TERBUKA: "greatly disappointed" bila H < 40 [K] ch.107
			requestDenied = -3, -- TERBUKA
			synthesisWitnessed = -6, -- TERBUKA [N] ch.48
			punishment = -15, -- TERBUKA
			moralInjury = -10, -- TERBUKA
			floor1NoFacilityPerDay = -0.3, -- TERBUKA [N] ch.157
		},
		giftMaxSt = 70, -- TERBUKA: gift tidak bekerja saat st ≥ 70 [K] ch.284
		greatlyDisappointedMaxH = 40, -- TERBUKA
	},

	-- §4.2–§4.4 relasi berarah (a, t, f, r, d, env).
	relations = {
		dims = {
			a = { min = -7, max = 7 }, -- kasih
			t = { min = 0, max = 15 }, -- percaya
			f = { min = 0, max = 15 }, -- akrab (log-skala)
			r = { min = 0, max = 15 }, -- hormat
			d = { min = -7, max = 7 }, -- utang (+ = aku berutang)
			env = { min = 0, max = 2 }, -- iri: 0 none · 1 benign · 2 malicious
		},
		neutral = { a = 0, t = 4, f = 0, r = 4, d = 0, env = 0 }, -- TERBUKA
		enmityA = -5, -- TERBUKA: Enmity [K] ch.49 = a ≤ −5 dua arah
		groupEnmityA = -5, -- TERBUKA: enmity kelompok ke penantang (manhwa ch.16 [T-gambar])
		bond = { t = 12, a = 5 }, -- TERBUKA: Bond [K] ch.27 = t ≥ 12 & a ≥ 5
		oath = { a = 6, t = 12, f = 12 }, -- TERBUKA: Ikatan Sumpah dua arah (§6.8)
		interaction = {
			floorPerDay = 1, -- TERBUKA: lantai sama, 1 acak/hari (party sama: tiap hari)
			plazaEveryDays = 3, -- TERBUKA: plaza, 1 acak seluruh room / 3 hari
			maxPerDay = 4, -- TERBUKA: sampling ≤4 interaksi/hari/hero
		},
		fWeights = {
			work = 1, -- TERBUKA: kerja berdampingan/latihan ×1
			meal = 2, -- TERBUKA: makan bersama ×2
			hobby = 2, -- TERBUKA: hobi bersama ×2
			mission = 5, -- TERBUKA: misi bersama ×5
			survivedWipe = 10, -- TERBUKA: selamat dari wipe/kehilangan bersama ×10
		},
		hall = { friend = 5, close = 9, intimate = 12 }, -- TERBUKA: ambang f (Hall ≈ 50/90/200 jam; 1 jam ≈ 1 hari)
		homophilyMaxDiff = 25, -- TERBUKA: |ΔC|, |ΔO| < 25 atau tag sama
		aPositive = 1, -- TERBUKA: a +1 interaksi positif
		tKept = 1, -- TERBUKA: t +1 mitra menepati
		tCompetence = -2, -- TERBUKA: pelanggaran kompetensi
		tIntegrity = -6, -- TERBUKA: pelanggaran integritas [PSI Kim 2004]
		tIntegrityRecoveryMult = 0.3, -- TERBUKA: pulih ×0,3 (lebih lambat)
		rPrestige = 1, -- TERBUKA
		rLeaderSuccess = 1, -- TERBUKA
		rLeaderFail = -1, -- TERBUKA: leader gagal berulang
		dHelped = 2, -- TERBUKA: ditolong
		dRepaid = -2, -- TERBUKA: membalas
		debtGuiltMin = 5, -- TERBUKA: utang ≥5 …
		debtGuiltDays = 60, -- TERBUKA: … tak dibayar 60 hari …
		debtGuilt = 5, -- TERBUKA: … guilt +5
		envy = {
			maxStarGap = 1, -- TERBUKA: dievaluasi bila selisih ★ ≤ 1
			admirationStarGap = 2, -- TERBUKA: selisih ★ ≥ 2 → hormat, bukan iri
			benignTrainingBonus = 0.2, -- TERBUKA: latihan +20 % …
			benignDays = 14, -- TERBUKA: … selama 14 hari
			maliciousA = -2, -- TERBUKA
			unfairGiftRatio = 3, -- TERBUKA: mitra dapat gift ≥3× lebih banyak = tidak layak
		},
		fusionDecayDays = 30, -- TERBUKA: f dari misi −1 per 30 hari tanpa peristiwa bersama baru
		fusionDecay = -1, -- TERBUKA
		decayDays = 30, -- TERBUKA: tanpa interaksi 30 hari, a/t/r bergerak 1 ke netral
		fFloorOfPeak = 0.6, -- TERBUKA: f tidak turun di bawah 60 % puncaknya
		slots = 8, -- TERBUKA: ≤8 slot relasi ternotasi
		intimateSlots = 5, -- TERBUKA: lapisan intim ≤5
		innerCircle = { min = 2, max = 3 }, -- TERBUKA: lingkaran dalam 2–3 orang
		focus = { k = 0.8, X = -0.004 }, -- TERBUKA: porsi interaksi ke lingkaran dalam = 0,8 − 0,4·X/100
		implicit = {
			party = { a = 1, t = 2, f = 2 }, -- TERBUKA: relasi implisit party sama
			floor = { t = 1 }, -- TERBUKA: lantai sama
			tag = { a = 1 }, -- TERBUKA: tag sama
			faction = { a = 1, t = 2 }, -- TERBUKA: faksi sama
			factionEnmity = { a = -2 }, -- TERBUKA: enmity faksi
		},
	},

	-- §4.5 guru–murid.
	mentor = {
		minR = 8, -- TERBUKA: r(murid→guru) ≥ 8
		minTeacherA = 40, -- TERBUKA: A(guru) ≥ 40
		minStarGap = 1, -- TERBUKA: ★ guru ≥ ★ murid + 1 (atau jabatan Instructor)
		skillMultMax = 10, -- [N] ch.98, 100 (DESAIN_SISTEM §6.8): instruktur 6★ = 10×; laju ×(1 + gap★) TERBUKA
		teacherCmpPerDay = 2, -- TERBUKA
		fMult = 2, -- TERBUKA: f ×2
		studentDPerWeek = 1, -- TERBUKA: murid d +1/minggu
		refuseStudentHBelow = 30, -- TERBUKA: guru boleh menolak murid H < 30 (BK-3 #43)
		refuseStudentCBelow = 30, -- TERBUKA: … atau C < 30
		surpassR = 3, -- TERBUKA: murid melampaui guru → r guru→murid +3
		surpassCmp = 10, -- TERBUKA: guru cmp +10 (kebanggaan) bila A ≥ surpassProudMinA
		surpassProudMinA = 50, -- TERBUKA
		surpassEnvyBelowA = 40, -- TERBUKA: malicious envy bila A < 40
		oathOrMentorGriefMult = 1.5, -- TERBUKA: §6.10 duka intim/Sumpah/mentor D ×1,5
	},

	-- §4.6 identitas, keluhan (grv), klik, faksi (SIMCA).
	groups = {
		tags = { "origin", "batch" }, -- tag identitas: asal & angkatan summon
		inGroupA = 1, -- TERBUKA: a +1 awal antar tag sama
		grvMin = 0, -- skala grv 0–100
		grvMax = 100, -- skala grv 0–100
		references = { min = 1, max = 3 }, -- TERBUKA: 1–3 acuan setara
		voiceGrvMin = 50, -- TERBUKA: menyuarakan bila grv ≥ 50 …
		voiceXMin = 50, -- TERBUKA: … & X ≥ 50
		voiceSpread = 3, -- TERBUKA: mitra tag/lantai sama grv +3
		cliqueT = 9, -- TERBUKA: klik = t ≥ 9 …
		cliqueA = 3, -- TERBUKA: … & a ≥ 3 dua arah …
		cliqueMin = 3, -- TERBUKA: … dengan ≥3 anggota
		factionGrvMin = 60, -- TERBUKA: rata-rata grv klik ≥ 60
		-- leader = skor efikasi tertinggi di klik, sah bila ≥ persentil `leaderFloorPercentile` skor seluruh hero lantai itu (Q3 opsi C)
		leaderScore = { k = 0, X = 0.4, star = 4.5, level = 0.3, rReceived = 0.3 }, -- TERBUKA: 0,4·X + 0,3·(★·15 + level) + 0,3·Σr diterima
		leaderFloorPercentile = 80, -- TERBUKA: kalibrasi 4.4 (LAPORAN 2026-09-25 Q3)
		identityShareMin = 0.5, -- TERBUKA: ≥50 % anggota berbagi tag/lantai
		cynicismTrainingMult = 0.7, -- TERBUKA: sinisme → latihan −30 %
		punishedGrv = 10, -- TERBUKA: ringleader dihukum → grv semua anggota +10
		punishedMoralMinA = 5, -- TERBUKA: luka moral pada yang a ≥ 5 ke ringleader
		punishedLike = -15, -- TERBUKA
		acceptedGrv = -40, -- TERBUKA: tuntutan diterima
		acceptedLike = 10, -- TERBUKA
		freeRiderSize = 8, -- TERBUKA: kelompok >8 tanpa Manager …
		freeRiderIdle = 0.1, -- TERBUKA: … aksi menganggur +10 %
		evaluateEveryDays = 7, -- TERBUKA: §5.1 langkah 7 (hari kelipatan 7)
	},

	-- §5.2 skor utilitas U = Σ w·(100−need)·gain + bias + noise(−8..+8).
	utility = {
		weights = { rest = 1.0, food = 1.2, aut = 0.8, cmp = 0.8, rel = 0.7 }, -- TERBUKA
		stressedSt = 70, -- TERBUKA: hero st ≥ 70 …
		stressedWeightMult = { rest = 2, aut = 2 }, -- TERBUKA: … w.rest & w.aut ×2 …
		stressedSocialMult = 0.5, -- TERBUKA: … aksi sosial −50 % [K] ch.284
		noise = 8, -- TERBUKA: ±8 ≈ 10–20 % ketidakpastian [PSI §7]
		lightMinRest = 30, -- TERBUKA: aksi ringan tambahan bila rest ≥ 30
		order = {
			"train",
			"rest",
			"hobby",
			"daily",
			"explore",
			"eatTogether",
			"befriend",
			"comfort",
			"teach",
			"provoke",
			"duel",
			"steal",
			"extort",
			"voice",
			"request",
			"remember",
			"idle",
		},
		actions = {
			-- latih [K] ch.243; [N] ch.9, 22 — syarat: Training Center ada; bukan hari misi
			train = {
				gain = { cmp = 3 }, -- TERBUKA
				bias = { k = 0, C = 0.5 }, -- TERBUKA: +0,5·C
				goal = { strongest = 10 }, -- TERBUKA: "goal terkuat" +10
				params = {
					gainChallenging = 6, -- TERBUKA: cmp +6 bila mitra lebih kuat
					benignEnvy = 8, -- TERBUKA: benign envy +8
					memoryLostDuel = 5, -- TERBUKA: memori kalah-duel +5
					rest = -8, -- TERBUKA
					stressFromSession = 3, -- TERBUKA: stres +4 mulai sesi ke-3 …
					stress = 4, -- TERBUKA
				},
				social = false,
				light = false,
			},
			-- istirahat [K] ch.8
			rest = {
				gain = { rest = 25 }, -- TERBUKA (Bathhouse: needs.rest.bathhouse)
				bias = { k = 10, C = -0.2 }, -- TERBUKA: (50−C)·0,2
				params = { highStMin = 60, highSt = 15, stress = -8 }, -- TERBUKA: st ≥ 60 +15; stres −8
				social = false,
				light = false,
			},
			-- hobi [N] ch.134, 273, 369, 383 — syarat: item hobi ada
			hobby = {
				gain = { rel = 3, aut = 4, rest = 10 }, -- TERBUKA
				bias = { k = 0, O = 0.3 }, -- TERBUKA
				params = { idioHobby = 12, stress = -5 }, -- TERBUKA: idiosinkrasi hobi +12; stres −5
				social = false,
				light = true,
			},
			-- daily dungeon sukarela [K] ch.24; [N] ch.25 — lantai ≥5; jendela; autonomous ON; 1×/hari
			daily = {
				gain = { cmp = 5, food = 5 }, -- TERBUKA
				bias = { k = 0, couEff = 0.3, C = 0.3 }, -- TERBUKA
				goal = { strongest = 5 }, -- TERBUKA
				params = { minFloor = 5, perDay = 1, aversionTerrain = -15, deathRisk = 0.01 }, -- TERBUKA
				social = false,
				light = false,
			},
			-- eksplorasi otonom [K] ch.218 (Belquist BK-2 #40)
			explore = {
				gain = { aut = 20, cmp = 15 }, -- TERBUKA
				bias = { k = 0, couEff = 0.4, O = 0.3 }, -- TERBUKA
				params = {
					minAccountLevel = 10, -- TERBUKA: akun ≥ L10
					minCouEff = 60, -- TERBUKA: cou_eff ≥ 60 & aut ≤ 40 …
					maxAut = 40, -- TERBUKA
					dowry = 10000, -- [K] ch.218 "10000G consumed"
					absentHours = 48, -- [K] ch.67 "Remaining time until return – 48:00:00"
					risk = 0.03, -- TERBUKA
				},
				social = false,
				light = false,
			},
			-- makan bersama (ringan) [N] ch.22 — syarat: Restaurant
			eatTogether = {
				gain = { food = 3, rel = 3 }, -- TERBUKA: "food, rel +3" = +3 keduanya (LAPORAN 2026-09-25 Q6)
				bias = { k = 0, X = 0.3 }, -- TERBUKA
				params = { tablemateA = 1 }, -- TERBUKA: a +1 rekan meja
				social = true,
				light = true,
			},
			-- berteman §6.6 [K] ch.222 — mitra sampling a ≥ 0
			befriend = {
				gain = { rel = 6 }, -- TERBUKA
				bias = { k = 0, X = 0.5, A = 0.2 }, -- TERBUKA
				params = { partnerMinA = 0 }, -- TERBUKA
				social = true,
				light = false,
			},
			-- menghibur §6.7 [K] ch.222 — rekan st ≥ 60/berduka & a ≥ 3
			comfort = {
				gain = { rel = 4 }, -- TERBUKA
				bias = { k = 0, X = 0.6, A = 0.4 }, -- TERBUKA
				goal = { protect = 10 }, -- TERBUKA
				params = { targetMinSt = 60, minA = 3, targetStress = -6, targetGuilt = -5 }, -- TERBUKA
				social = true,
				light = false,
			},
			-- mengajar §4.5 [N] ch.73, 351 — flag mentor
			teach = {
				gain = { cmp = 4, rel = 2 }, -- TERBUKA
				bias = { k = 0, A = 0.3, C = 0.3 }, -- TERBUKA
				params = { fMult = 2 }, -- TERBUKA
				social = true,
				light = false,
			},
			-- provokasi §6.5 [K] ch.49 — target a ≤ −3 atau malicious envy
			provoke = {
				gain = { cmp = 4 }, -- TERBUKA
				bias = { k = 80, A = -0.5, H = -0.3, X = -0.3 }, -- TERBUKA: 0,5·(100−A) + 0,3·(100−H) − 0,3·X
				params = { targetMaxA = -3, targetRel = -5, a = -2 }, -- TERBUKA
				social = true,
				light = false,
			},
			-- duel §6.4 [K] ch.28, 71 — sengketa a ≤ −5 atau kursi party
			duel = {
				gain = { cmp = 10 }, -- TERBUKA
				bias = { k = 40, couEff = 0.4, A = -0.4 }, -- TERBUKA: 0,4·cou_eff + 0,4·(100−A)
				goal = { strongest = 10, prove = 10 }, -- TERBUKA
				social = false,
				light = false,
			},
			-- mencuri §6.5 [N] ch.113 — H ≤ 25 & (food ≤ 30 atau cmp ≤ 30)
			steal = {
				gain = { food = 20, cmp = 5 }, -- TERBUKA: food +20 ATAU cmp +5 (sesuai kebutuhan yang memicu)
				bias = { k = 15, H = -0.5 }, -- TERBUKA: (30−H)·0,5
				social = false,
				light = false,
			},
			-- memeras §6.5 [N] ch.158 — H ≤ 25 & X ≥ 50 & target r(target→pelaku) ≥ 8 & lebih lemah
			extort = {
				gain = { food = 15, cmp = 8 }, -- TERBUKA: food +15 ATAU cmp +8
				bias = { k = 15, H = -0.5, X = 0.2 }, -- TERBUKA: (30−H)·0,5 + 0,2·X
				social = false,
				light = false,
			},
			-- menyuarakan keluhan [N] ch.65 — grv ≥ 50 & X ≥ 50
			voice = {
				gain = { aut = 5, cmp = 3 }, -- TERBUKA
				bias = { k = 0, X = 0.3 }, -- TERBUKA
				social = true,
				light = false,
			},
			-- request ke master §6.9 [K] ch.128, 244, 110 — master online / antrean mail
			request = {
				gain = { aut = 5 }, -- TERBUKA (dikabulkan: needs.aut.requestGranted)
				bias = { k = 0, X = 0.3, O = 0.2 }, -- TERBUKA
				goal = { recognized = 5 }, -- TERBUKA
				social = false,
				light = false,
			},
			-- mengenang §6.10 [K] ch.79, 146 — duka aktif, loss_mode (bias = trajektori, tanpa angka sifat)
			remember = {
				gain = { rel = 2 }, -- TERBUKA
				bias = { k = 0 }, -- TERBUKA: tanpa bias sifat di §5.2
				social = false,
				light = false,
			},
			-- menganggur (default) [N] ch.159
			idle = {
				gain = { rest = 10 }, -- TERBUKA
				bias = { k = 0 }, -- TERBUKA: tanpa bias sifat di §5.2
				params = { uninvolvedDays = 7, stress = 1 }, -- TERBUKA: stres +1 bila ≥7 hari tanpa keterlibatan (goal ≠ calm)
				social = false,
				light = false,
			},
		},
	},

	-- §5.1 langkah 1: latihan wajib party leader.
	duty = {
		skipTrainingMaxC = 30, -- TERBUKA: anggota C < 30 …
		skipTrainingMaxA = 40, -- TERBUKA: … & A < 40 boleh skip …
		skipTrainingLeaderA = -1, -- TERBUKA: … → a −1 ke leader
	},

	-- §6.1 penilaian perintah misi (gate sebelum MissionRequest).
	command = {
		base = 0.02, -- TERBUKA
		danger = 0.30, -- TERBUKA: 0,30·(bahaya − 0,5)₊
		dangerFrom = 0.5, -- TERBUKA
		unfair = 0.20, -- TERBUKA: 0,20·(1 − adil), adil = (100 − grv)/100
		like = 0.10, -- TERBUKA: 0,10·(1 − like/100)
		aut = 0.10, -- TERBUKA: 0,10·(1 − aut/100)
		leaderTrust = -0.15, -- TERBUKA: −0,15·(t rata-rata ke leader / 15)
		max = 0.6, -- TERBUKA: clamp 0..0,6
		traitMult = { k = 1.3, A = -0.006 }, -- TERBUKA: ×(1,3 − 0,6·A/100)
		requestMinStar = 3, -- TERBUKA: ★ ≥ 3 …
		requestMinLike = 60, -- TERBUKA: … & like ≥ 60 …
		requestShare = 0.7, -- TERBUKA: … → 70 % kasus berbentuk request
		subMasterInitiativeMult = 2, -- TERBUKA: sub-master p_tolak = 0 [N] ch.48; request/inisiatif ×2
		solidarityMinA = 4, -- TERBUKA: rekan a ≥ 4 ke penolak …
		solidarityP = 0.5, -- TERBUKA: … ikut menolak p 0,5 [N] ch.48
		compound = {
			restDaysMin = 3, -- [FINAL 24 Sep] konsesi istirahat ≥3 hari (TERBUKA angka)
			sameConcessionRepeat = 3, -- [FINAL] konsesi sama ≥3× berturut pada party sama …
			repeatMult = 0.5, -- [FINAL] … p_tolak ×0,5 (bukan 0)
			forcedMinP = 0.3, -- [FINAL] tetap "dipaksa" bila p_tolak sebelum pengali ≥ 0,3 …
			forcedAut = -15, -- [FINAL] … aut −15
		},
	},

	-- §6.2 mogok, faksi, mass strike.
	strike = {
		acceptGrv = -40, -- TERBUKA: terima tuntutan
		acceptLike = 10, -- TERBUKA
		acceptAut = 15, -- TERBUKA
		punishMoralMinA = 5, -- TERBUKA: hukum ringleader → luka moral pada a ≥ 5 ke ringleader
		punishLike = -15, -- TERBUKA
		punishGrv = 10, -- TERBUKA
		sendOtherDays = 7, -- TERBUKA: kirim party lain → penolak tetap uncontrollable 7 hari
		sendOtherAut = 5, -- TERBUKA: aut +5 (dihormati)
		massStrikeFloorShare = 0.4, -- TERBUKA: ≥40 % hero satu lantai menolak dalam 1 hari
		ignoredGrvPerDay = 3, -- [FINAL 24 Sep] diabaikan: grv +3/hari (TERBUKA angka)
		ignoredCynicismDays = 14, -- [FINAL] setelah 14 hari …
		ignoredCynicismMaxCouEff = 50, -- [FINAL] … anggota cou_eff < 50 mundur ke sinisme
		ignoredLeaveDays = 30, -- [FINAL] setelah 30 hari …
		ignoredLeaveMinCouEff = 60, -- [FINAL] … ringleader cou_eff ≥ 60 & autonomous ON pergi sendiri
	},

	-- §6.3 inisiatif: auto-dispatch membalas kematian rekan.
	initiative = {
		revengeP = 0.1, -- TERBUKA: p 0,1/hari …
		revengeDays = 14, -- TERBUKA: … selama 14 hari
		revengeAbsentDays = 1, -- TERBUKA: hero absen 1 hari
	},

	-- §6.4 duel tak disuruh.
	duel = {
		disputeA = -5, -- TERBUKA: (a) sengketa a ≤ −5 dua arah
		seatMaxR = 2, -- TERBUKA: (b) kursi party vs anggota terlemah dengan r ≤ 2
		maliciousEnvyDays = 30, -- TERBUKA: (c) malicious envy ≥ 30 hari
		pDispute = { base = 0.04, factors = { { k = 0, couEff = 0.01 }, { k = 2, A = -0.01 } } }, -- TERBUKA: 0,04·cou_eff/100·(1 + (100−A)/100)
		pSeat = 0.02, -- TERBUKA: (b) 0,02 …
		pSeatGoalMult = 1.5, -- TERBUKA: … ×1,5 bila goal terkuat/membuktikan
		acceptMinCouEff = 40, -- TERBUKA: diterima bila cou_eff ≥ 40 …
		acceptMaxH = 40, -- TERBUKA: … atau H ≤ 40 (gengsi)
		synthesisMaxA = 20, -- TERBUKA: syarat "Synthesis" hanya bila A ≤ 20 …
		synthesisMaxH = 30, -- TERBUKA: … & H ≤ 30
		loserR = 3, -- TERBUKA: kalah terhormat → r +3 ke pemenang
		humiliatedA = -2, -- TERBUKA: dipermalukan → a −2 …
		humiliatorMaxA = 30, -- TERBUKA: … bila pemenang A ≤ 30
		interference = false, -- [FINAL 24 Sep] ikut campur duel OFF untuk V0
	},

	-- §6.5 pencurian & pemerasan.
	theft = {
		maxH = 25, -- TERBUKA: mencuri/memeras hanya H ≤ 25
		stealNeedMax = 30, -- TERBUKA: food ≤ 30 atau cmp ≤ 30
		caught = 0.5, -- TERBUKA: ketahuan 0,5 …
		caughtManagerBonus = 0.2, -- TERBUKA: … +0,2 bila ada Manager
		victimT = -6, -- TERBUKA: t korban→pelaku −6 (integritas)
		jailDays = 7, -- TERBUKA: kurung 7 hari …
		jailSt = 15, -- TERBUKA: … st +15 …
		jailAut = -20, -- TERBUKA: … aut −20
		pardonLike = 5, -- TERBUKA: ampun → like +5
		extortMinX = 50, -- TERBUKA: memeras H ≤ 25 & X ≥ 50
		extortMinTargetR = 8, -- TERBUKA: target r(target→pelaku) ≥ 8
		extortVictimGrv = 10, -- TERBUKA: korban grv +10 …
		extortVictimAut = -10, -- TERBUKA: … aut −10
		extortVictimDuelMinCouEff = 50, -- TERBUKA: korban cou_eff ≥ 50 boleh menantang duel …
		extortReportP = 0.3, -- TERBUKA: … atau melapor p 0,3
		extortRepeat = 3, -- TERBUKA: pemerasan ≥3× lantai sama …
		extortRepeatFloorGrv = 5, -- TERBUKA: … grv lantai +5
	},

	-- §6.5 provokasi & Enmity.
	provoke = {
		a = -2, -- TERBUKA: a dua arah −2
		targetMaxA = -3, -- TERBUKA: target a ≤ −3 (§5.2)
		enmitySummonEvery = 10, -- TERBUKA: Enmity bawaan: 1 pasangan per 10 summon berturut …
		enmitySummonP = 0.05, -- TERBUKA: … p 5 % [K] ch.49
	},

	-- §6.5 rekonsiliasi (kanon Katio diredakan Han ch.128).
	reconcile = {
		minA = 60, -- TERBUKA: hero A ≥ 60 …
		minX = 50, -- TERBUKA: … & X ≥ 50
		p = 0.05, -- TERBUKA: p 0,05/hari
		partnerMinA = 30, -- TERBUKA: mitra A ≥ 30
		a = 2, -- TERBUKA: a +2 dua arah
		giftBonusA = 1, -- TERBUKA: gift master ke keduanya +1 lagi
	},

	-- §6.6–§6.8 berteman, menghibur, Ikatan Sumpah.
	social = {
		befriendP = { k = 0.03, X = 0.001 }, -- TERBUKA: 0,10·(0,3 + X/100)
		comfortP = { k = 0, X = 0.001, A = 0.001 }, -- TERBUKA: 0,20·(X + A)/200
		comfortMinX = 40, -- TERBUKA: penghibur X ≥ 40 …
		comfortMinA = 40, -- TERBUKA: … & A ≥ 40 …
		comfortMinAff = 3, -- TERBUKA: … & a(penghibur→target) ≥ 3
		comfortTargetSt = 60, -- TERBUKA: target st ≥ 60 atau berduka
		comfortSt = -6, -- TERBUKA: target st −6
		comfortGuilt = -5, -- TERBUKA: target guilt −5
		comfortA = 2, -- TERBUKA: a dua arah +2
		comfortD = 1, -- TERBUKA: d(target→penghibur) +1
		oathP = 0.05, -- TERBUKA: Ikatan Sumpah p 0,05/hari
		cliqueFixedPartyMin = 3, -- TERBUKA: klik ≥3 → leader cenderung usul fixed party [K] ch.30
	},

	-- §6.9 request & usulan ke master (p per hari bila syarat terpenuhi).
	requests = {
		p = {
			gift = 0.05, -- TERBUKA [K] ch.128
			facility = 0.1, -- TERBUKA [K] ch.244
			joinParty = 0.08, -- TERBUKA [K] ch.16
			fixedParty = 0.05, -- TERBUKA [K] ch.30
			mission = 0.08, -- TERBUKA [K] ch.110
			recording = 0.05, -- TERBUKA [K] ch.108
			mockBattle = 0.02, -- TERBUKA [K] ch.148
			declinePosition = 1.0, -- TERBUKA: 100 % bila syarat [N] ch.347
			reportExtortion = 0.3, -- TERBUKA §6.5
		},
		giftMaxCmp = 40, -- TERBUKA: cmp ≤ 40 & hobi koleksi
		facilityMaxRest = 30, -- TERBUKA: rest ≤ 30 tanpa Bathhouse …
		facilityMinC = 70, -- TERBUKA: … atau C ≥ 70 tanpa Training Center
		joinMaxRel = 40, -- TERBUKA: rel ≤ 40 & ada klik di party itu
		fixedMinX = 60, -- TERBUKA: leader X ≥ 60 & klik ≥3
		recordMinC = 60, -- TERBUKA: C ≥ 60 & Playstone
		mockMinO = 60, -- TERBUKA: O ≥ 60 …
		mockMinLike = 70, -- TERBUKA: … & like ≥ 70
		declineMinAut = 60, -- TERBUKA §6.11: goal terkuat & aut ≥ 60
		subMasterMult = 2, -- TERBUKA: sub-master ×2
		grantedAut = 8, -- TERBUKA
		grantedLike = 4, -- TERBUKA
		grantedD = 1, -- TERBUKA: d(hero→master) +1
		deniedAut = -5, -- TERBUKA
		deniedLike = -3, -- TERBUKA
		deniedStreak = 3, -- TERBUKA: ditolak ≥3 berturut …
		deniedMemoryValence = -1, -- TERBUKA: … memori "dikhianati" valensi −1
	},

	-- §6.10 kematian & duka (Dual Process, trajektori emergen, continuing bonds).
	grief = {
		mournMinA = 3, -- TERBUKA: berduka bila a ≥ 3 …
		mournMinT = 9, -- TERBUKA: … atau t ≥ 9 atau berflag (+ rekan party saat kematian, guru/murid)
		intensity = { base = 1, factors = { { k = 0.5, a = 1 / 14 }, { k = 0, f = 1 / 15 }, { k = 0.6, E = 0.01 } } }, -- TERBUKA: (a+7)/14 × f/15 × (0,6 + E/100)
		intimateMult = 2, -- TERBUKA: flag intim ×2
		suddenMult = 1.5, -- TERBUKA: mendadak/di sisinya ×1,5
		duration = { base = 14, factors = { { k = 1, I = 3 }, { k = 0.6, vul = 0.01 } } }, -- TERBUKA: D = 14·(1 + 3·I)·(0,6 + vul/100) hari
		supportMult = 0.7, -- TERBUKA: dukungan t ≥ 9 ada ×0,7
		witnessedMult = 1.2, -- TERBUKA: menyaksikan ×1,2
		serialLossDays = 60, -- TERBUKA: kehilangan beruntun ≤60 hari …
		serialLossMult = 1.3, -- TERBUKA: … ×1,3
		priorStressSt = 60, -- TERBUKA: st ≥ 60 sebelum kematian …
		priorStressMult = 1.5, -- TERBUKA: … ×1,5
		reliefMaxA = -3, -- TERBUKA: a ≤ −3 → "membaik" …
		reliefDays = 3, -- TERBUKA: … D = 3 hari
		intimateDurationMult = 1.5, -- TERBUKA: intim/Sumpah/mentor D ×1,5
		lossModePStart = 0.7, -- TERBUKA: p loss_mode 0,7 → …
		lossModePEnd = 0.3, -- TERBUKA: … 0,3 selama trajektori
		productivityMult = 0.7, -- TERBUKA: produktivitas −30 %
		lossModeRel = -2, -- TERBUKA: rel −2 saat loss_mode
		stressPeakPerI = 20, -- TERBUKA: kurva stres duka +I·20 hari 1, meluruh ke 0
		secondPeakDays = { min = 90, max = 120 }, -- TERBUKA: puncak kedua kecil (besarnya tidak disebut §6.10)
		mementoStPerDay = -1, -- TERBUKA: memento = comfort item −1 stres/hari
		mentionPStart = 0.3, -- TERBUKA: p "menyebut X" 0,3 → …
		mentionPEnd = 0.05, -- TERBUKA: … 0,05, tidak pernah nol
		ritualSt = -6, -- TERBUKA: Archive/ritual → semua yang berduka st −6 [K] ch.79
		ritualF = 1, -- TERBUKA: f antar yang hadir +1
		ritualMasterLike = 5, -- TERBUKA: master hadir like +5
		ignoredGrv = 10, -- TERBUKA: kematian diabaikan → grv kolektif +10 …
		ignoredDurationMult = 1.3, -- TERBUKA: … durasi ×1,3
		survivorGuilt = 15, -- TERBUKA: rekan party hidup saat korban mati
		survivorCouldHelpGuilt = 15, -- TERBUKA: +15 lagi bila "bisa menolong" …
		survivorCouldHelpHpPct = 50, -- TERBUKA: … HP > 50 % saat itu
		leaderGuilt = 10, -- TERBUKA: leader +10 (kanon Siris ch.375)
		soleSurvivorGuilt = 40, -- TERBUKA: penyintas tunggal (Kishasha ch.159) …
		soleSurvivorDurationMult = 1.5, -- TERBUKA: … D ×1,5
		humorMinX = 60, -- TERBUKA: humor gelap X ≥ 60 …
		humorMaxE = 40, -- TERBUKA: … & E ≤ 40
		humorP = 0.1, -- TERBUKA: p 0,1 saat duka kolektif
		humorSt = -3, -- TERBUKA: st −3 untuk klik-nya
		humorA = -1, -- TERBUKA: a −1 dari yang paling dekat dengan korban
		traitShiftP = 0.5, -- TERBUKA: §1.2 ikatan intim mati → E +3, X −2 pada 50 % hero
	},

	-- §6.11 event lain.
	events = {
		cookingMaxFood = 40, -- TERBUKA: komplain masakan food ≤ 40 & pref tidak cocok …
		cookingP = 0.3, -- TERBUKA: … p 0,3 [K] ch.16
		cookingTipsShare = 0.3, -- TERBUKA: ≥30 % → Tips
		researchMaxHours = 3, -- TERBUKA: jam riset > 3 → komplain [K] ch.53
		stagnationMinFloor = 3, -- TERBUKA: lantai ≥3 …
		stagnationMinNeed = 90, -- TERBUKA: … semua need ≥ 90 …
		stagnationDays = 30, -- TERBUKA: … selama 30 hari & goal ≠ strongest [N] ch.156
		boredomDays = 5, -- TERBUKA: tugas sama ≥5 hari (lihat needs.cmp.monotone*)
		judgeMasterMaxLike = 30, -- TERBUKA: like ≤ 30 …
		judgeMasterDays = 30, -- TERBUKA: … selama 30 hari …
		judgeMasterRequestMult = 0.5, -- TERBUKA: … request berkurang 50 %
		contagionMinA = 3, -- TERBUKA: rekan a ≥ 3 …
		contagionSourceSt = 70, -- TERBUKA: … dari hero st ≥ 70 …
		contagionStPerDay = 2, -- TERBUKA: … st +2/hari
		denialDays = { min = 1, max = 3 }, -- TERBUKA: penyangkalan pra-sintesis/hukuman (manhwa ch.5 [T-gambar])
		denialShoutMinE = 60, -- TERBUKA: E ≥ 60 berteriak
		denialSilentMaxE = 40, -- TERBUKA: E ≤ 40 diam
		denialCancelLike = 10, -- TERBUKA: master membatalkan → like +10
	},

	-- §8.2 HeroInput.hidden untuk combat engine (hanya server → engine).
	hidden = {
		fearResistance = { k = 0.45, couEff = 0.0055, E = -0.0015, vul = -0.0015, st = -0.002 }, -- TERBUKA: 0,15 + 0,55·cou_eff/100 + 0,15·(100−E)/100 + 0,15·(100−vul)/100 − 0,2·st/100, clamp 0..1
		stressBandAt = { 40, 70 }, -- TERBUKA: 0: st<40 · 1: 40–69 · 2: 70–ambang · 3: ≥ambang patah
		compatibility = { k = -4 / 11, a = 1 / 7, t = 1 / 11 }, -- TERBUKA: a/7 + (t−4)/11 …
		compatibilityMaliciousPenalty = 0.5, -- TERBUKA: … − 0,5 bila env = 2
		compatibilityRange = { min = -1.5, max = 2 }, -- TERBUKA
		hesitation = { k = -0.3, A = 0.006 }, -- TERBUKA/USUL §10.2 #6: clamp(0,3·(A−50)/50, 0, 1) …
		hesitationMinA = 65, -- TERBUKA/USUL: … hanya bila A ≥ 65, target EnemyData.isHumanoid
	},

	-- §8.2 efek MissionResult yang tidak tercakup tabel lain.
	mission = {
		awakeningCmp = 5, -- TERBUKA: awakeningEvents → cmp +5
		lowContributionMissions = 3, -- TERBUKA: contribution rendah ≥3 misi …
		lowContributionCmp = -5, -- TERBUKA: … cmp −5 …
		lowContributionGuilt = 5, -- TERBUKA: … guilt (jadi beban) +5
	},

	-- §8.1 catch-up saat login (CLAUDE.md keputusan final; RENCANA §3.2).
	catchUp = {
		maxDays = 21, -- [FINAL] maks 7 hari Bumi = 21 hari in-game
		daysPerEarthDay = 3, -- [FINAL] 1 hari Bumi = 3 hari in-game
		restNeedTarget = 80, -- TERBUKA: sisa Δt = istirahat, need → 80
		restStPerDay = -3, -- TERBUKA: … st −3/hari
		onlineTickHours = 8, -- TERBUKA: online, tick 1 hari in-game tiap 8 jam Bumi
		yieldEveryHeroes = 200, -- TERBUKA: task.wait() tiap 200 hero
	},
}

return NpcData
