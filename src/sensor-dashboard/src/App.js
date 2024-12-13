import React, { useState, useEffect } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  const [sensors, setSensors] = useState([]);
  const [ws, setWs] = useState(null);
  const [newSensorId, setNewSensorId] = useState('');
	const [newSensorSignalStrength, setNewSensorSignalStrength] = useState(1000);
	


  useEffect(() => {
    const websocket = new WebSocket('ws://localhost:8000');
    websocket.onopen = () => {
      websocket.send(JSON.stringify({ type: 'request-sensors' }));
      requestSensors();
    };
    websocket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      if (message.type === 'sensors-update') {
        setSensors(message.data);
      }
    };
		setWs(websocket);
		

    return () => {
      if (websocket) {
        websocket.close();
      }
    };
  }, []);

  const requestSensors = () => {
    if (ws && ws.readyState === WebSocket.OPEN) {
			ws.send(JSON.stringify({ type: 'request-sensors' }));
		} else {
			console.log('WebSocket is not connected.');
		}
  };

  const addSensor = (e) => {
    e.preventDefault();
    if (!newSensorId || !newSensorSignalStrength ) {
      alert('Please fill in all fields.');
      return;
    }

    ws.send(JSON.stringify({
      type: 'add-sensor',
			body: { id: newSensorId, signalStrength: newSensorSignalStrength, },
    }));

    setNewSensorId('');
		setNewSensorSignalStrength(1000);
	
  };

  const updateSensor = (id, signalStrength) => {
    ws.send(JSON.stringify({
      type: 'update-sensor',
      body: { id, signalStrength },
    }));
  };

  const removeSensor = (id) => {
    ws.send(JSON.stringify({
      type: 'remove-sensor',
      body: { id },
    }));
	};
	
	const autoPlay = () => {
		const firstSensor = sensors[0];
		console.log(firstSensor)
		if (firstSensor.signalStrength === '0') {
			removeSensor(firstSensor.id)
		} else {
			// 1: set the distance to 0 to the first sensor
			updateSensor(firstSensor.id, '0');

		}
		
		
	}

	return (
    <div className="App container mt-5">
      <h1 className="mb-4">Sensor Dashboard</h1>
      <form onSubmit={addSensor} className="mb-3">
        <div className="mb-3">
          <input
            type="text"
            className="form-control"
            placeholder="Sensor ID"
            value={newSensorId}
            onChange={(e) => setNewSensorId(e.target.value)}
          />
        </div>
        <div className="mb-3">
          <select
            className="form-select"
            value={newSensorSignalStrength}
            onChange={(e) => setNewSensorSignalStrength(e.target.value)}
          >
            <option value="">Select Signal Strength</option>
            <option value="0">0</option>
            <option value="2">2</option>
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="10000">10000</option>
          </select>
        </div>
        
				<button type="submit" className="btn btn-primary">Add Sensor</button>
      </form>
			<button onClick={autoPlay} className="btn btn-primary">Auto Play</button>
      <button onClick={requestSensors} className="btn btn-secondary mb-3">Refresh Sensors</button>
      <table className="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Signal Strength</th>
            
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {sensors.map((sensor) => (
            <tr key={sensor.id}>
              <td>{sensor.id}</td>
              <td>
                <select
                  className="form-select"
                  value={sensor.signalStrength}
                  onChange={(e) => updateSensor(sensor.id, e.target.value)}
                >
                  <option value="0">0</option>
                  <option value="5">5</option>
                  <option value="10">10</option>
                  <option value="10000">10000</option>
                </select>
							</td>
							
              <td>
                <button onClick={() => removeSensor(sensor.id)} className="btn btn-danger">Remove</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default App;
