#
# File listings
#

TARGET = TestPlugin
SRCS = Test.cpp
OUT_DIR = ../Assets/$(PLATFORM)

#
# Intermediate/output files
#

OBJS = $(SRCS:.cpp=.o)

ifeq ($(OUTPUT_TYPE), so)
  OUTPUT = lib$(TARGET).so
else ifeq ($(OUTPUT_TYPE), a)
  OUTPUT = lib$(TARGET).a
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

ifndef AR
  AR = ar
endif

ifndef CXX
  CXX = c++
endif

ifndef STRIP
  STRIP = strip
endif

#
# Building rules
#

all: $(OUTPUT)

copy: $(OUTPUT)
	cp -f $(OUTPUT) $(OUT_DIR)/$(OUTPUT)

clean:
	rm -f $(OUTPUT) $(OBJS)

$(TARGET).dll: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^
	$(STRIP) $@

$(TARGET).bundle: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^

lib$(TARGET).so: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^
	$(STRIP) $@

lib$(TARGET).a : $(OBJS)
	$(AR) -crv $@ $^

.cpp.o:
	$(CXX) $(CXXFLAGS) -c -o $@ $<
