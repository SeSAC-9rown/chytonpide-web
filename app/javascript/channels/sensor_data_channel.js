import consumer from "./consumer"

consumer.subscriptions.create("SensorDataChannel", {
  connected() {
    console.log("Connected to sensor data channel");
  },

  disconnected() {
    console.log("Disconnected from sensor data channel");
  },

  received(data) {
    console.log("Received data:", data);
    
    // DOM에 데이터 표시
    const temperatureElement = document.getElementById('sensor-temperature');
    const humidityElement = document.getElementById('sensor-humidity');
    const illuminanceElement = document.getElementById('sensor-illuminance');
    const timestampElement = document.getElementById('sensor-timestamp');
    
    if (temperatureElement) {
      temperatureElement.textContent = data.temperature;
    }
    if (humidityElement) {
      humidityElement.textContent = data.humidity;
    }
    if (illuminanceElement) {
      illuminanceElement.textContent = data.illuminance;
    }
    if (timestampElement) {
      timestampElement.textContent = new Date(data.timestamp).toLocaleString('ko-KR');
    }
  }
});
