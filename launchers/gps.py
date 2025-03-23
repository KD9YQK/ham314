import gpsd2
import maidenhead
try:
	# Connect to the local gpsd
	gpsd2.connect()

	# Connect somewhere else
	gpsd2.connect(host="127.0.0.1", port=2947)

	# Get gps position
	packet = gpsd2.get_current()

	# See the inline docs for GpsResponse for the available data
	t = packet.position()
	print(maidenhead.to_maiden(t[0], t[1]))
	print(str(t[0])[:7])
	print(str(t[1])[:8])
except:
	exit()
	print('ERROR')
	print('No Fix')
	print('No Fix')
