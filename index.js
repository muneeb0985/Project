async function getWeather(city) {
    const apiKey = "fa480253e9d92fb2c993fc48528175b0";
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;
  
    try {
      const response = await fetch(url);
      const data = await response.json();
  
      if (data.cod !== 200) {
        document.querySelector(".weather").style.display = "none";
        document.querySelector(".error").style.display = "block";
        return;
      }
  
      const weatherDiv = document.querySelector(".weather");
      const emoji = document.querySelector(".emoji");
  
      const mainWeather = data.weather[0].main.toLowerCase();
      if (mainWeather.includes("cloud")) emoji.textContent = "☁️";
      else if (mainWeather.includes("rain")) emoji.textContent = "🌧️";
      else if (mainWeather.includes("snow")) emoji.textContent = "❄️";
      else if (mainWeather.includes("clear")) emoji.textContent = "☀️";
      else emoji.textContent = "🌤️";
  
      document.querySelector(".weather").style.display = "block";
      document.querySelector(".error").style.display = "none";
  
      document.getElementById("cityName").textContent = city.toUpperCase();
      document.querySelector(".temp").textContent = `${data.main.temp}°C`;
      document.querySelector(".desc").textContent = data.weather[0].description;
      document.querySelector(".humid").textContent = `Humidity: ${data.main.humidity}%`;
      document.querySelector(".wind").textContent = `Wind: ${data.wind.speed} km/h`;
  
      let precipitation = "0%";
      if (data.rain && data.rain["1h"]) {
        precipitation = `${data.rain["1h"]} mm (rain)`;
      } else if (data.snow && data.snow["1h"]) {
        precipitation = `${data.snow["1h"]} mm (snow)`;
      } else if (mainWeather.includes("rain")) {
        precipitation = "100%";
      }
  
      document.querySelector(".precip").textContent = `Precipitation: ${precipitation}`;
    } catch (error) {
      console.error("Fetch error:", error);
      document.querySelector(".weather").style.display = "none";
      document.querySelector(".error").style.display = "block";
    }
  }
  
  window.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("weatherForm");
    const input = document.getElementById("cityInput");
  
    form.addEventListener("submit", (event) => {
      event.preventDefault();
      const city = input.value.trim();
      if (city) {
        getWeather(city);
      }
    });
  });
  