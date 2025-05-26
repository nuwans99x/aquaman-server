# Aquaman Server

This project is a C# .NET 6 Web API, scaffolded for Visual Studio 2022. It includes a sample REST API controller (`WeatherForecastController`) that can be consumed by a React app.

## Getting Started

1. Open the solution in Visual Studio 2022.
2. Build the project (Ctrl+Shift+B).
3. Run the project (F5 or Ctrl+F5).
4. The API will be available at `http://localhost:5000` (or another port if configured).

## Sample Endpoint

- `GET /weatherforecast` — Returns a sample weather forecast array.

## Consuming from React

You can call the API from your React app using `fetch` or `axios`:

```js
fetch('http://localhost:5000/weatherforecast')
  .then(res => res.json())
  .then(data => console.log(data));
```

## Notes
- Make sure CORS is configured as needed for your React app.
- Update the API endpoints as required for your application.
