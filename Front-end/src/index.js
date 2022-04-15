import React from 'react';
import ReactDOM from 'react-dom';
import './assets/styles/main.css';
import HomePageComponent from "./components/homePageComponent";

ReactDOM.render(
  <React.StrictMode>
      <HomePageComponent/>
  </React.StrictMode>,
  document.getElementById('root')
);
