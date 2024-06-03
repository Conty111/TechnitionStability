import styled from 'styled-components';

export const AppContainer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #f0f0f0;
`;

export const Title = styled.h1`
  color: #333;
  margin-bottom: 20px;
`;

export const SelectorContainer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
`;

export const Select = styled.select`
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-bottom: 10px;
`;

export const Option = styled.option`
  font-size: 16px;
`;
