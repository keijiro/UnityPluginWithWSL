TARGET = TestPlugin

SRCS = Test.cpp
OBJS = $(SRCS:.cpp=.o)

CXXFLAGS = -O2 -Wall -std=c++11
LDFLAGS = -shared

ifeq ($(PLATFORM), Windows)
    BIN_PREFIX = x86_64-w64-mingw32
    OUTPUT = $(TARGET).dll
else
    BIN_PREFIX =
    CXXFLAGS += -fPIC
    LDFLAGS += -rdynamic -fPIC
    ifeq ($(PLATFORM), MacOS)
        CXXFLAGS += -target x86_64-apple-macos10.12
        LDFLAGS += -target x86_64-apple-macos10.12
        OUTPUT = $(TARGET).bundle
        NOSTRIP = true
    else
        OUTPUT = lib$(TARGET).so
    endif
endif

CXX = $(BIN_PREFIX)-c++
STRIP = $(BIN_PREFIX)-strip

all: $(OUTPUT)

copy: $(OUTPUT)
ifndef NOSTRIP
	$(STRIP) $(OUTPUT)
endif
	cp -f $(OUTPUT) ../Assets/$(OUTPUT)

clean:
	rm -f $(OUTPUT) $(OBJS)

$(OUTPUT): $(OBJS)
	$(CXX) $(LDFLAGS) -o $(OUTPUT) $(OBJS)

.cpp.o:
	$(CXX) $(CXXFLAGS) -c -o $@ $<
