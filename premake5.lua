workspace "Xplat"
	configurations { "GB", "NES", "SG", "PDX" }
	architecture "x86_64"
	inheritdependencies "off"

project "ProjectName"
	files { "src/**.c" }

	filter "configurations:GB"
		kind "Makefile"
		defines { "NINTENDO", "__TARGET_gb" }

		includedirs { "$(GBDK_HOME)/include" }

		debugcommand ( "$(GBDK_EMU)" )
		debugargs { "%{prj.location}bin/%{cfg.buildcfg}/%{prj.name}.gb" }

		buildcommands {
			"$(MAKE_PATH)/make -f %{prj.location}gbdk.mk PLAT=%{cfg.buildcfg} PROJ=%{prj.name}"
		}

		rebuildcommands {
		}

		cleancommands {
			"$(MAKE_PATH)/make -f %{prj.location}gbdk.mk clean PLAT=%{cfg.buildcfg}"
		}

	filter "configurations:NES"
		kind "Makefile"
		defines { "NINTENDO_NES", "__TARGET_nes" }

		includedirs { "$(GBDK_HOME)/include" }
		
		debugcommand ( "$(GBDK_EMU)" )
		debugargs { "%{prj.location}bin/%{cfg.buildcfg}/%{prj.name}.nes" }

		buildcommands {
			"$(MAKE_PATH)/make -f %{prj.location}gbdk.mk PLAT=%{cfg.buildcfg} PROJ=%{prj.name}"
		}

		rebuildcommands {
		}

		cleancommands {
			"$(MAKE_PATH)/make -f %{prj.location}gbdk.mk clean PLAT=%{cfg.buildcfg}"
		}

	filter "configurations:SG"
		kind "Makefile"
		defines { "SGDK_GCC" }

		includedirs { "$(SGDK_PATH)/inc" }

		debugcommand ( "$(SGDK_EMU)" )
		debugargs { "%{prj.location}out/rom.bin" }

		buildcommands {
			"$(MAKE_PATH)/make -f $(SGDK_PATH)/makefile.gen"
		}

		rebuildcommands {
		}

		cleancommands {
		}

	filter "configurations:PDX"
		architecture "x86_64"
		kind "SharedLib"
		cdialect "C11"
		defines { "PLAYDATE","TARGET_EXTENSION=1", "_WINDLL=1", "WIN32;_WINDOWS;" }

		includedirs { "$(PLAYDATE_SDK_PATH)/C_API" }
		removefiles { "src/boot/*.c" }

		debugcommand ( "$(PLAYDATE_SDK_PATH)/bin/PlaydateSimulator.exe" )
		debugargs { "%{prj.location}bin/PDX/%{prj.name}.pdx" }

		postbuildmessage("Copying DLL and Compiling PDX")
		postbuildcommands {
			"{MKDIR} %{prj.location}bin/PDX/Source",
			"{COPYFILE} %{prj.location}bin/PDX/%{prj.name}.dll %{prj.location}bin/PDX/Source/pdex.dll",
			"$(PLAYDATE_SDK_PATH)/bin/pdc -sdkpath $(PLAYDATE_SDK_PATH) %{prj.location}bin/PDX/Source %{prj.location}bin/PDX/%{prj.name}.pdx"
		}
