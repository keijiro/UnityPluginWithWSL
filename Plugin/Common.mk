#
# File listings
#

TARGET = TestPlugin
SRCS = Test.cpp
OUT_DIR = ../Assets

#
# Intermediate/output files
#

OBJS = $(SRCS:.cpp=.o)

ifeq ($(OUTPUT_TYPE), so)
  OUTPUT = lib$(TARGET).$(OUTPUT_TYPE)
else
  OUTPUT = $(TARGET).$(OUTPUT_TYPE)
endif

#
# Compiler/linker options
#

CXXFLAGS += -O2 -Wall -std=c++11

LDFLAGS += -shared

ifeq ($(OUTPUT_TYPE), dll)
else ifeq ($(OUTPUT_TYPE), a)
else
  CXXFLAGS += -fPIC
  LDFLAGS += -rdynamic -fPIC
endif

#
# Toolchain
#

ifdef TOOLCHAIN
  BIN_PREFIX=$(TOOLCHAIN)-
endif

AR = $(BIN_PREFIX)ar
CXX = $(BIN_PREFIX)c++
STRIP = $(BIN_PREFIX)strip

# Don't try to strip .bundle files.
ifeq ($(OUTPUT_TYPE), bundle)
  STRIP = true
endif

#
# Building rules
#

all: $(OUTPUT)

copy: $(OUTPUT)
	$(STRIP) $(OUTPUT)
	cp -f $(OUTPUT) $(OUT_DIR)/$(OUTPUT)

clean:
	rm -f $(OUTPUT) $(OBJS)

$(TARGET).dll: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $<

$(TARGET).bundle: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $<

lib$(TARGET).so: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $<

$(TARGET).a : $(OBJS)
	$(AR) -crv $@ $<

.cpp.o:
	$(CXX) $(CXXFLAGS) -c -o $@ $<
