# Create this file with:
# nano /home/pi/Autostartup.sh

#!/bin/bash
# Startup script to activate Python venv and run project with logging & checks

# -------------------------------
# Configurable variables
# -------------------------------
PROJECT_DIR="/home/pi/powertrain-daq-private"   # project root folder
VENV_DIR="$PROJECT_DIR/venv"                    # virtual environment path
MAIN_SCRIPT="$PROJECT_DIR/main.py"              # main Python script
LOG_FILE="/home/pi/daq_log.txt"                 # log file for all messages

# -------------------------------
# Start logging
# -------------------------------
# Append a timestamped "script started" message to the log file
echo "[$(date)] Starting Autostartup.sh..." >> "$LOG_FILE"

# -------------------------------
# Step 1: Go to project directory
# -------------------------------
if cd "$PROJECT_DIR"; then
    # Success: we are in the project directory
    echo "[$(date)] Changed directory to $PROJECT_DIR" >> "$LOG_FILE"
else
    # Failure: directory not found, log error and exit
    echo "[$(date)] ERROR: Project directory $PROJECT_DIR not found." >> "$LOG_FILE"
    exit 1
fi

# -------------------------------
# Step 2: Activate Python venv
# -------------------------------
if [ -d "$VENV_DIR" ]; then
    # venv folder exists → activate it
    source "$VENV_DIR/bin/activate"
    echo "[$(date)] Activated venv at $VENV_DIR" >> "$LOG_FILE"
else
    # Failure: no venv folder → log and exit
    echo "[$(date)] ERROR: Virtual environment not found at $VENV_DIR" >> "$LOG_FILE"
    exit 1
fi

# -------------------------------
# Step 3: Check for main.py
# -------------------------------
if [ -f "$MAIN_SCRIPT" ]; then
    # File exists → run the script
    echo "[$(date)] Running main.py..." >> "$LOG_FILE"
    
    # Run Python and redirect both stdout (1) and stderr (2) into the log file
    python3 "$MAIN_SCRIPT" >> "$LOG_FILE" 2>&1
    
    # Save Python’s exit status ($? holds the last command's return code)
    STATUS=$?
    echo "[$(date)] main.py exited with status $STATUS" >> "$LOG_FILE"
else
    # Failure: main.py missing → log and exit
    echo "[$(date)] ERROR: main.py not found at $MAIN_SCRIPT" >> "$LOG_FILE"
    exit 1
fi

