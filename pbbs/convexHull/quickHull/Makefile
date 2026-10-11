include parallelDefs

# serialQuickHull picks its pivot with one triArea() evaluation and splits with
# others. With FMA contraction (clang's default since 14, plus -march=native)
# these round differently, which is fatal on near-cocircular input such as
# 2DonSphere_100000000: points land on both sides of a split, the recursion
# stops shrinking and overflows the stack (SIGSEGV).
PCFLAGS += -ffp-contract=off

# required files
GLOBAL_REQUIRE = parallel.h sequence.h geometry.h
LOCAL_REQUIRE = 
OBJS = hull.o

include ../common/timeRequiredFiles
include MakeBench
