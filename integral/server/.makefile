TARGET := $(BUILDDIR)/server
INCDIRS := $(CURDIR) $(EXTINCDIRS)
OBJS := $(addprefix $(BUILDDIR)/,$(patsubst %.c,%.o,$(wildcard *.c)))
CFLAGS := $(EXTCFLAGS)

.PHONY: all 

all: $(TARGET)

$(TARGET): $(OBJS) $(EXTOBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJS): $(BUILDDIR)/%.o: %.c | $(BUILDDIR)
	$(CC) $(CFLAGS) -MMD $(addprefix -I,$(INCDIRS)) -c -o $@ $< 

$(BUILDDIR): 
	mkdir $@

-include $(patsubst %.o,%.d,$(OBJS))