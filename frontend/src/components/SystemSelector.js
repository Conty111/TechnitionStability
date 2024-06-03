import React, { useState } from 'react';
import { SelectorContainer, Select, Option } from '../styles';

const systems = ['Система A', 'Система B', 'Система C', 'Система D'];

function SystemSelector() {
  const [selectedSystem, setSelectedSystem] = useState('');

  const handleSelectChange = (event) => {
    setSelectedSystem(event.target.value);
  };

  return (
    <SelectorContainer>
      <Select value={selectedSystem} onChange={handleSelectChange}>
        <Option value="">Выберите систему</Option>
        {systems.map((system, index) => (
          <Option key={index} value={system}>
            {system}
          </Option>
        ))}
      </Select>
      {selectedSystem && <p>Вы выбрали: {selectedSystem}</p>}
    </SelectorContainer>
  );
}

export default SystemSelector;
