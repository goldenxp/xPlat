# xPlat
SDK adventures with GDBK, SGDK, Playdate (and perhaps more!)

## Instructions
Disclaimer: Consider this alpha software (or worse), so use at your own risk. 
* You'll need [Premake5](https://premake.github.io/)
* You'll need [GBDK](https://github.com/gbdk-2020/gbdk-2020/releases), [SGDK](https://github.com/Stephane-D/SGDK) and [Playdate C](https://play.date/dev/)
* You'll need a slew of environment variables setup including
	* $(GBDK_HOME) -> location of GBDK, parent folder of bin, lib, etc.
	* $(GBDK_EMU) -> executable of your favorite GBDK output runner
	* $(SGDK_PATH) -> location of SGDK, parent folder of bin, inc, etc.
	* $(SGDK_EMU) -> executable of your favorite SGDK output runner
	* $(JAVA_HOME) -> parent of bin folder that contains java.exe, needed for SGDK
	* $(MAKE_PATH) -> location of GNU Make, required for Makefiles
	* $(PLAYDATE_SDK_PATH) -> location of Playdate SDK

Once you have these, run Premake5 where premake5.lua with `vs2022` as your argument and a Visual Studio solution will be generated. 

## Known Issues
There are a few but the most prominent include: 
* All VC++ dirs for GBDK and SGDK configurations need to be cleared out to avoid looking up the wrong C standard libraries. It is unclear to me right now how to make Premake clear those values.
* Debug command values may not get set; in this case, the known fix is to delete the .vs folder and re-open the solution.
* SGDK output goes into an `out` folder instead of `bin` like the others. This is because of the behavior of SGDK's Makefile.