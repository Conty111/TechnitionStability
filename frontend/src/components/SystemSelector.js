import React from 'react';
import { DetailContainer, DetailItem, CalculateButton } from '../styles';

const SystemSelector = ({ systems, onSelect }) => {
  return (
    <DetailContainer>
      {systems.map(system => (
        <DetailItem key={system.id} onClick={() => onSelect(system)}>
          <CalculateButton>{system.name}</CalculateButton>
        </DetailItem>
      ))}
    </DetailContainer>
  );
}

export default SystemSelector;
