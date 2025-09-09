# Create this file with:
# nano /home/pi/Autostartup.sh

#!/bin/bash
# Startup script to activate Python venv and run project

# Go to project directory
cd /home/pi/powertrain-daq-private || exit 1

# Activate virtual environment
source venv/bin/activate

# Run Python script
python3 main.py

#CTRL+O, Enter, CTRL+X to save file, confirm name and exit nano
#After saving the file, make it executable by "chmod +x /home/pi/Autostartup.sh"
