# Question SideCar

# Task
# Update the existing wordpress deployment adding a sidecar container named sidecar using the busybox:stable
# image to the existing pod
# The new sidecar container has to run the following command
"/bin/sh -c tail -n+1 -f /var/log/synergy-leverager.log"
# Use a volume mounted at /var/log to make the log file synergy-leverager.log available to the co-located container

#Video link - https://youtu.be/3xraEGGQJDY
