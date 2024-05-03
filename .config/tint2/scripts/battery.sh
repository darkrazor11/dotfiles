# #!/bin/sh

# # A dwm_bar function to read the battery level and status
# # Joe Standring <git@joestandring.com>
# # GNU GPLv3

#     # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
#     CHARGE=$(cat /sys/class/power_supply/BAT1/capacity)
#     STATUS=$(cat /sys/class/power_supply/BAT1/status)

#     printf "%s" "$SEP1"
#     if [ "$STATUS" = "Full"]; then
#         printf "󱟢 "
#     elif [ "$STATUS" = "Charging" ] && [ $CHARGE -gt 75]; then
#         printf "󱊦[$CHARGE%%]" #"$CHARGE" "+" #🔌
#     elif [ $CHARGE -gt 75]; then
#         printf "󱊦[$CHARGE%%]" #"$CHARGE" "+" #🔌
#     elif [ $CHARGE -le 75 ] && [ $CHARGE -gt 50  ]; then
# 	    printf "󱊥[$CHARGE%%]" #"$CHARGE"
# 	elif [ $CHARGE -le 50 ] && [ $CHARGE -gt 25  ]; then
# 	    printf "󱊤[$CHARGE%%]" #"$CHARGE"
# 	elif [ $CHARGE -le 25 ] && [ $CHARGE -gt 10  ]; then
# 	    printf "󰢟[$CHARGE%%]" #"$CHARGE"
# 	elif [ $CHARGE -le 10 ]; then
# 	    printf "󱃍[$CHARGE%%]" 
#     elif [ "$STATUS" == "Discharging"]; then
#         printf "dis"
#     else
#             printf "󱟢[$CHARGE%%]" #🔋
#     fi
#     printf "%s" #"$SEP2"


#!/bin/sh

# Change BAT1 to match your battery identifier (e.g., BAT0, BAT1, etc.)
CHARGE=$(cat /sys/class/power_supply/BAT1/capacity)
STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Define Unicode symbols for battery status
FULL="󱟢"
CHARGING="󱊦"
C_HIGH="󱊦"
C_MEDIUM="󱊥"
C_LOW="󱊤"
C_CRITICAL="󰢟"
D_HIGH="󱊣"
D_MEDIUM="󱊢"
D_LOW="󱊡"
D_CRITICAL="󰢟"

EMPTY="󱃍"

# Check battery status and charge level
if [ "$STATUS" = "Full" ]; then
    printf "%s" "$FULL"
elif [ "$STATUS" = "Charging" ] && [ "$CHARGE" -gt 75 ]; then
    printf "%s[$CHARGE%%]" "$C_HIGH"
elif [ "$STATUS" = "Charging" ] && [ "$CHARGE" -le 75 ] && [ "$CHARGE" -gt 50 ]; then
    printf "%s[$CHARGE%%]" "$C_MEDIUM"
elif [ "$STATUS" = "Charging" ] && [ "$CHARGE" -le 50 ] && [ "$CHARGE" -gt 25 ]; then
    printf "%s[$CHARGE%%]" "$C_LOW"
elif [ "$STATUS" = "Charging" ] && [ "$CHARGE" -le 25 ] && [ "$CHARGE" -gt 10 ]; then
    printf "%s[$CHARGE%%]" "$C_CRITICAL"
elif [ "$STATUS" = "Discharging" ] && [ "$CHARGE" -gt 75 ]; then
    printf "%s[$CHARGE%%]" "$D_HIGH"
elif [ "$STATUS" = "Discharging" ] && [ "$CHARGE" -le 75 ] && [ "$CHARGE" -gt 50 ]; then
    printf "%s[$CHARGE%%]" "$D_MEDIUM"
elif [ "$STATUS" = "Discharging" ] && [ "$CHARGE" -le 50 ] && [ "$CHARGE" -gt 25 ]; then
    printf "%s[$CHARGE%%]" "$D_LOW"
elif [ "$STATUS" = "Discharging" ] && [ "$CHARGE" -le 25 ] && [ "$CHARGE" -gt 10 ]; then
    printf "%s[$CHARGE%%]" "$D_CRITICAL"
elif [ "$CHARGE" -le 10 ]; then
    printf "%s[$CHARGE%%]" "$EMPTY"
else
    printf "%s[$CHARGE%%]" "󱉞"
fi
