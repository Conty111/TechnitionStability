import styled from 'styled-components';

export const AppContainer = styled.div`
  font-family: Arial, Helvetica, sans-serif;
  margin: 20px auto;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  max-width: 800px; /* Добавляем максимальную ширину */
`;

export const Title = styled.h1`
  font-size: 2em;
  text-align: center;
  color: #333;
`;

export const DetailContainer = styled.div`
  font-size: 1.5em;
  background-color: #f9f9f9;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  margin-top: 20px;
  text-align: center; /* Центрируем содержимое */
`;

export const LoadingContainer = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  font-size: 24px;
`;

export const DetailItem = styled.div`
  margin: 10px auto; /* Центрируем элементы */
`;

export const Button = styled.button`
  background-color: #007bff;
  color: white;
  padding: 10px 20px;
  margin: 10px auto; /* Центрируем кнопки */
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1em;
  display: block; /* Превращаем кнопку в блочный элемент */
`;

export const BackButton = styled(Button)`
  background-color: #6c757d;
`;

export const CalculateButton = styled(Button)`
  background-color: #28a745;
`;


export const GrafanaButton = styled.a`
  display: inline-block;
  background-color: #17a2b8;
  color: white;
  padding: 10px 20px;
  margin: 10px auto; /* Центрируем кнопку */
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1em;
  text-decoration: none;
`;

export const HeaderContainer = styled.div`
  width: 100%;
  padding: 10px 0;
  background-color: #282c34;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  margin-bottom: 20px;
`;

export const Logo = styled.img`
  max-width: 80%; /* Увеличиваем максимальную ширину логотипа */
  height: auto;
  margin: 0 auto 20px; /* Центрируем логотип */
`;

export const RandomValueContainer = styled.div`
  margin: 20px auto;
`;

export const RandomValueLabel = styled.div`
  font-size: 1.5em;
  margin-bottom: 10px;
`;

export const RandomValue = styled.div`
  font-size: 2em;
  font-weight: bold;
  color: ${props => props.value < 0.7 ? 'orange' : 'green'};
`;