#if PLAYDATE
#define DRAW_TEXT(str, x, y) pd->graphics->drawText(str, strlen(str), kASCIIEncoding, x, y);
#elif SGDK_GCC
#define DRAW_TEXT(str, x, y) VDP_drawText(str, x, y);
#else
#define DRAW_TEXT(str, x, y) printf(str);
#endif

#if PLAYDATE
#include "pd_api.h"

static int update(void* userdata);

#ifdef _WINDLL
__declspec(dllexport)
#endif
int eventHandler(PlaydateAPI* pd, PDSystemEvent event, uint32_t arg)
{
	if (event == kEventInit)
	{
		pd->system->setUpdateCallback(update, pd);
	}
	return 0;
}

static int update(void* userdata)
{
	PlaydateAPI* pd = userdata;
	pd->graphics->clear(kColorWhite);
	DRAW_TEXT("...", 12, 12);
	return 0;
}
#elif SGDK_GCC
#include "genesis.h"

int main(bool hardReset)
{
	DRAW_TEXT("...", 12, 12);
	while (TRUE)
	{
		SYS_doVBlankProcess();
	}
	return 0;
}
#else
#include <gbdk/platform.h>
#include <stdio.h>

void main(void)
{
	DRAW_TEXT("...");
	while (1)
	{
		vsync();
	}
}
#endif
