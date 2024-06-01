LCC = $(GBDK_HOME)/bin/lcc

CFLAGS = -v
CFLAGS_GB = -msm83:gb
CFLAGS_POCKET = -msm83:ap
CFLAGS_NES = -mmos6502:nes
CFLAGS_GG = -mz80:gg
CFLAGS_SMS = -mz80:sms
CFLAGS += $(CFLAGS_$(PLAT))

LFLAGS = -Wl-j -Wm-yS -Wm-yoA -Wm-ya4 -autobank -Wb-ext=.rel -Wb-v
LFLAGS_GB = -Wl-yt0x1B
LFLAGS_POCKET = -Wl-yt0x1B
LFLAGS_NES = 
LFLAGS_GG = 
LFLAGS_SMS = 
LFLAGS += $(LFLAGS_$(PLAT))

SRCDIR = src
CSRC = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c)))

OUTDIR = bin/$(PLAT)
OBJDIR = obj/$(PLAT)
OBJS = $(CSRC:%.c=$(OBJDIR)/%.o)

OUTPUT = $(PROJ).${PLAT} 

all: $(OUTPUT)

$(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(LCC) $(CFLAGS) -c -o $@ $<

$(OUTPUT) : $(OBJS)
	$(LCC) $(LFLAGS) $(CFLAGS) -o $(OUTDIR)/$@ $^
# TODO should $^ be $< 

clean:
	rm $(OBJDIR)
	rm $(OUTDIR)
# TODO rm needs extra work