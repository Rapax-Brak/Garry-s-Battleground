GM.GBConfig = {}

/*
	General Settings
*/

GM.GBConfig.PlayerModelList = {
	"models/player/zelpa/female_01_extended.mdl",
	"models/player/zelpa/female_02_extended.mdl",
	"models/player/zelpa/female_03_extended.mdl",
	"models/player/zelpa/female_04_extended.mdl",
	"models/player/zelpa/female_06_extended.mdl",
	"models/player/zelpa/female_07_extended.mdl",
	"models/player/zelpa/male_01_extended.mdl",
	"models/player/zelpa/male_02_extended.mdl",
	"models/player/zelpa/male_03_extended.mdl",
	"models/player/zelpa/male_04_extended.mdl",
	"models/player/zelpa/male_05_extended.mdl",
	"models/player/zelpa/male_06_extended.mdl",
	"models/player/zelpa/male_07_extended.mdl",
	"models/player/zelpa/male_08_extended.mdl",
	"models/player/zelpa/male_09_extended.mdl",
	"models/player/zelpa/male_10_extended.mdl",
	"models/player/zelpa/male_11_extended.mdl"
}

/*
	Round Settings
*/

GM.GBConfig.PrepTime = 60	// How long (in seconds) the preperation round will last

/*
	Death Sphere Settings
*/

GM.GBConfig.CircleStartingRadius = 50000
GM.GBConfig.CircleDecreaseDelay = 0.05 * 60
GM.GBConfig.OriginPoints = {
	Vector(-5806.666992, 13407.083984, -10111.968750), // Docks
	Vector(-4514.369141, 8779.089844, -9727.968750), // Church
	Vector(-12070.693359, 305.594940, -10175.968750), // MTL
	Vector(-460.078033, -5752.717773, -8987.987305), // Radio Tower
	Vector(9216.235352, -3785.797607, -7615.968750), // Helicopter Pad
	Vector(13950.807617, 11447.455078, -7091.968750) // Fort
}