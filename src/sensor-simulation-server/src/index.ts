import express from 'express';
import { Server as WebSocketServer } from 'ws';
import http from 'http';
import { Sensor, SignalStrength } from './domain/sensor';

const app = express();
const port = 8000;

// Initialize a simple HTTP server
const server = http.createServer(app);

// Initialize the WebSocket server instance attached to the same HTTP server
const wss = new WebSocketServer({ server });

const sensors: Sensor[] = [
    new Sensor('1', 10),
];



wss.on('connection', (ws) => {
	console.log('Client connected');
	// Send the sensors data to the newly connected client every second
	const interval = setInterval(() => {
		// Send an event of type 'sensors-update' to the client
		ws.send(JSON.stringify({ type: 'sensors-update', data: sensors }));
	}, 2500);
	// Clear the interval when the connection is closed
	ws.on('close', () => {
		console.log('Client disconnected');
		clearInterval(interval);
	});
    
    ws.on('message', (message) => {
        // Handle incoming messages
			console.log('received: %s', message);
			const data = JSON.parse(message.toString());
			const { type, body } = data;
			switch (type) {
				case 'request-sensors':
					ws.send(JSON.stringify({ type: 'sensors-update', data: sensors }));
					break;
				case 'update-sensor': {
					const { id, signalStrength } = body;
					const sensor = sensors.find((s) => s.id === id);
					if (sensor) {
						// parse signal strength enum
						// const parsedSignalStrength = SignalStrength[signalStrength as keyof typeof SignalStrength];
						sensor.setSignalStrength(signalStrength);
						ws.send(JSON.stringify({ type: 'sensors-update', data: sensors }));
						// Update the sensors data

					}
					break;
				}
				case 'add-sensor': {
					const { id, signalStrength } = body;
					const sensor = new Sensor(id, signalStrength);
					sensors.push(sensor);
					console.log('added sensor', sensor);
					ws.send(JSON.stringify({ type: 'sensors-update', data: sensors }));
					break;
				}
				case 'remove-sensor': {
					const { id } = body;
					const sensorIndex = sensors.findIndex((s) => s.id === id);
					if (sensorIndex !== -1) {
						sensors.splice(sensorIndex, 1);
						ws.send(JSON.stringify({ type: 'sensors-update', data: sensors }));
					}
					break;
				}
			}
    });
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

// Start the server to listen on the specified port
server.listen(port, () => {
    console.log(`Server started on port ${port}`);
});
