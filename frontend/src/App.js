import React, { useState, useEffect } from 'react';
import SystemSelector from './components/SystemSelector';
import SystemDetails from './components/SystemDetails';
import LoadingScreen from './components/LoadingScreen';
import Header from './components/Header';
import { AppContainer, Title } from './styles';

const backendUrl = process.env.REACT_APP_BACKEND_URL;

function App() {
  const [systems, setSystems] = useState([]);
  const [selectedSystem, setSelectedSystem] = useState(null);
  const [loading, setLoading] = useState(false);
  const [calculationDone, setCalculationDone] = useState(false);

  useEffect(() => {
    if (!backendUrl) {
      console.error('Backend URL is not set');
      return;
    }

    console.log(`Fetching systems from ${backendUrl}/infosystems/`);
    fetch(`${backendUrl}/infosystems/`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log('Fetched systems:', data);
        setSystems(data);
      })
      .catch(error => console.error('Error fetching systems:', error));
  }, []);

  const handleSystemSelect = (system) => {
    setSelectedSystem(system);
    setCalculationDone(false);
  };

  const handleBack = () => {
    setSelectedSystem(null);
    setCalculationDone(false);
  };

  const handleCalculate = () => {
    if (!selectedSystem) return;
  
    setLoading(true);
    console.log(`Calculating for system ${selectedSystem.id}`);
    fetch(`${backendUrl}/infosystems/${selectedSystem.id}/calculate`, {method: 'POST'})
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        setLoading(false);
        setCalculationDone(true);
      })
      .catch(error => {
        setLoading(false);
        console.error('Error calculating:', error);
      });
  };
  

  return (
    <AppContainer>
      <Header />
      <Title>Выбор информационной системы</Title>
      {loading ? (
        <LoadingScreen />
      ) : selectedSystem ? (
        <SystemDetails
          system={selectedSystem}
          onBack={handleBack}
          onCalculate={handleCalculate}
          calculationDone={calculationDone}
        />
      ) : (
        <SystemSelector systems={systems} onSelect={handleSystemSelect} />
      )}
    </AppContainer>
  );
}

export default App;
