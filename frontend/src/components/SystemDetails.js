import React from 'react';
import { format } from 'date-fns';
import { DetailContainer, DetailItem, BackButton, CalculateButton, GrafanaButton } from '../styles';

const SystemDetails = ({ system, onBack, onCalculate, calculationDone }) => {
  const formattedDate = format(new Date(system.created_at), 'dd MMMM yyyy, HH:mm:ss');
  const grafanaUrl = process.env.REACT_APP_GRAFANA_URL;
  return (
    <DetailContainer>
      <DetailItem><strong>ID:</strong> {system.id}</DetailItem>
      <DetailItem><strong>Created At:</strong> {formattedDate}</DetailItem>
      {!calculationDone &&<CalculateButton onClick={onCalculate}>Рассчитать тех. устойчивость</CalculateButton>}
      {calculationDone && <GrafanaButton href={grafanaUrl} target="_blank">Результаты вычислений в Grafana</GrafanaButton>}
      <BackButton onClick={onBack}>Назад</BackButton>
    </DetailContainer>
  );
}

export default SystemDetails;
