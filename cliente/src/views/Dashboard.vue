<!-- App.vue -->

<template>
    <div class="dashboard">
      <!-- Header -->
      <div class="header">
        <h1>Dashboard de Produção</h1>
        <div class="header-controls">
          <div class="date-info">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="small-icon">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>
            <span>20 de Janeiro, 2026</span>
          </div>
          <select v-model="selectedPeriod" class="period-select">
            <option value="hoje">Hoje</option>
            <option value="semana">Esta Semana</option>
            <option value="mes">Este Mês</option>
          </select>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-header">
            <div class="stat-icon blue">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
            </div>
            <span class="stat-trend positive">+{{ stats.producao.variacao }}%</span>
          </div>
          <div class="stat-title">Produção Total</div>
          <div class="stat-value">{{ stats.producao.total }}</div>
          <div class="stat-subtitle">Meta: {{ stats.producao.meta }} unidades</div>
        </div>
        <router-link :to="'funcionario'">
                <div class="stat-card">
                  <div class="stat-header">
                    <div class="stat-icon green">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                      </svg>
                    </div>
                  </div>
                  <div class="stat-title">Equipe Ativa</div>
                  <div class="stat-value">{{ stats.equipe.ativos }}/{{ stats.equipe.total }}</div>
                  <div class="stat-subtitle">{{ stats.equipe.ausentes }} ausentes</div>
                </div>
        </router-link>
        <div class="stat-card">
          <div class="stat-header">
            <div class="stat-icon purple">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
              </svg>
            </div>
            <span class="stat-trend positive">+{{ stats.eficiencia.variacao }}%</span>
          </div>
          <div class="stat-title">Eficiência</div>
          <div class="stat-value">{{ stats.eficiencia.valor }}%</div>
          <div class="stat-subtitle">Média geral</div>
        </div>

        <div class="stat-card">
          <div class="stat-header">
            <div class="stat-icon orange">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z" />
              </svg>
            </div>
          </div>
          <div class="stat-title">Qualidade</div>
          <div class="stat-value">{{ stats.qualidade.valor }}%</div>
          <div class="stat-subtitle">{{ stats.qualidade.defeitos }}% defeitos</div>
        </div>
      </div>

      <div class="content-grid">
        <!-- Linhas de Produção -->
        <div class="section-card">
          <div class="section-header">
            <h2>Linhas de Produção</h2>
          </div>
          <div class="section-content">
            <div class="team-list">
              <div v-for="equipe in equipes" :key="equipe.id" class="team-item">
                <div class="team-header">
                  <div class="team-title">
                    <div class="team-name">{{ equipe.nome }}</div>
                    <span :class="['status-badge', equipe.status]">
                      {{ equipe.status === 'ativo' ? 'Ativo' : equipe.status === 'alerta' ? 'Atenção' : 'Parado' }}
                    </span>
                  </div>
                  <div class="team-production">
                    <div class="team-production-value">{{ equipe.producao }}</div>
                    <div class="team-production-label">unidades</div>
                  </div>
                </div>

                <div class="team-info">
                  <div class="team-info-item">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="small-icon">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                    <span>{{ equipe.membros }} colaboradores</span>
                  </div>
                  <div class="team-info-item">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="small-icon">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                    </svg>
                    <span>{{ equipe.eficiencia }}% eficiência</span>
                  </div>
                </div>

                <div class="progress-bar">
                  <div 
                    :class="['progress-fill', getProgressClass(equipe.eficiencia)]"
                    :style="{ width: equipe.eficiencia + '%' }"
                  ></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Alertas -->
        <div class="section-card">
          <div class="section-header">
            <h2>Alertas</h2>
          </div>
          <div class="section-content">
            <div class="alerts-list">
              <div v-for="(alerta, index) in alertas" :key="index" :class="['alert-item', alerta.prioridade]">
                <div class="alert-content">
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" :class="['alert-icon', alerta.prioridade]">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  <div style="flex: 1;">
                    <div class="alert-message">{{ alerta.mensagem }}</div>
                    <div class="alert-time">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" style="width: 12px; height: 12px;">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                      <span>há 15 minutos</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="summary">
              <h3>Resumo do Turno</h3>
              <div class="summary-list">
                <div class="summary-item">
                  <span class="summary-label">Horas trabalhadas</span>
                  <span class="summary-value">304h</span>
                </div>
                <div class="summary-item">
                  <span class="summary-label">Produtividade média</span>
                  <span class="summary-value">41 un/h</span>
                </div>
                <div class="summary-item">
                  <span class="summary-label">Meta do dia</span>
                  <span class="summary-value success">83.1%</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

    const selectedPeriod = ref('hoje');
    
    const stats = ref({
      producao: {
        total: 1247,
        meta: 1500,
        variacao: 12.5
      },
      equipe: {
        total: 42,
        ativos: 38,
        ausentes: 4
      },
      eficiencia: {
        valor: 83.1,
        variacao: 5.2
      },
      qualidade: {
        valor: 96.5,
        defeitos: 3.5
      }
    });

    const equipes = ref([
      { id: 1, nome: 'Linha A', membros: 12, producao: 450, status: 'ativo', eficiencia: 88 },
      { id: 2, nome: 'Linha B', membros: 10, producao: 380, status: 'ativo', eficiencia: 85 },
      { id: 3, nome: 'Linha C', membros: 8, producao: 280, status: 'alerta', eficiencia: 72 },
      { id: 4, nome: 'Linha D', membros: 12, producao: 137, status: 'parado', eficiencia: 45 }
    ]);

    const alertas = ref([
      { tipo: 'producao', mensagem: 'Linha D abaixo da meta (91%)', prioridade: 'alta' },
      { tipo: 'pessoal', mensagem: '4 colaboradores ausentes', prioridade: 'media' },
      { tipo: 'manutencao', mensagem: 'Equipamento #7 requer manutenção', prioridade: 'baixa' }
    ]);

    const getProgressClass = (eficiencia: number) => {
      if (eficiencia >= 80) return 'high';
      if (eficiencia >= 60) return 'medium';
      return 'low';
    };
</script>

<style scoped>

    .dashboard {
      min-height: 100vh;
      padding: 24px;
    }

    .header {
      margin-bottom: 32px;
    }

    .header h1 {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .header-controls {
      display: flex;
      align-items: center;
      gap: 16px;
      flex-wrap: wrap;
    }

    .date-info {
      display: flex;
      align-items: center;
      gap: 8px;
      color: #6b7280;
      font-size: 14px;
    }

    .period-select {
      padding: 8px 16px;
      border: 1px solid var(--gray-light);
      border-radius: 8px;
      font-size: 14px;
      background-color: var(--card-bg);
      color: var(--text-light);
      cursor: pointer;
      outline: none;
    }

    .period-select:focus {
      border-color: var(--blue-primary);
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 24px;
      margin-bottom: 32px;
    }

    .stat-card {
      background: var(--card-bg);
      border-radius: 12px;
      padding: 24px;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .stat-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 16px;
    }

    .stat-icon {
      width: 48px;
      height: 48px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
    }

    .stat-icon.blue { background-color: var(--blue-primary); }
    .stat-icon.green { background-color: #10b981; }
    .stat-icon.purple { background-color: #8b5cf6; }
    .stat-icon.orange { background-color: var(--yellow-highlight); }

    .stat-trend {
      font-size: 14px;
      font-weight: 600;
    }

    .stat-trend.positive { color: #10b981; }
    .stat-trend.negative { color: var(--red-error); }

    .stat-title {
      color: #6b7280;
      font-size: 14px;
      font-weight: 500;
      margin-bottom: 4px;
    }

    .stat-value {
      font-size: 32px;
      font-weight: 700;
      color: var(--text-light);
    }

    .stat-subtitle {
      font-size: 14px;
      color: #6b7280;
      margin-top: 4px;
    }

    .content-grid {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 24px;
    }

    @media (max-width: 1024px) {
      .content-grid {
        grid-template-columns: 1fr;
      }
    }

    .section-card {
      background: var(--card-bg);
      border-radius: 12px;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .section-header {
      padding: 24px;
      border-bottom: 1px solid var(--gray-light);
    }

    .section-header h2 {
      font-size: 20px;
      font-weight: 700;
    }

    .section-content {
      padding: 24px;
    }

    .team-list {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    .team-item {
      border: 1px solid var(--gray-light);
      border-radius: 8px;
      padding: 16px;
      transition: box-shadow 0.2s;
    }

    .team-item:hover {
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .team-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;
    }

    .team-title {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .team-name {
      font-weight: 600;
    }

    .status-badge {
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 500;
    }

    .status-badge.ativo {
      background-color: #d1fae5;
      color: #065f46;
    }

    .status-badge.alerta {
      background-color: #fef3c7;
      color: #92400e;
    }

    .status-badge.parado {
      background-color: #fee2e2;
      color: #991b1b;
    }

    .team-production {
      text-align: right;
    }

    .team-production-value {
      font-size: 24px;
      font-weight: 700;
    }

    .team-production-label {
      font-size: 12px;
      color: #6b7280;
    }

    .team-info {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
      margin-bottom: 12px;
    }

    .team-info-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 14px;
      color: #6b7280;
    }

    .progress-bar {
      width: 100%;
      height: 8px;
      background-color: var(--gray-light);
      border-radius: 4px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      border-radius: 4px;
      transition: width 0.3s;
    }

    .progress-fill.high { background-color: #10b981; }
    .progress-fill.medium { background-color: var(--yellow-highlight); }
    .progress-fill.low { background-color: var(--red-error); }

    .alerts-list {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    .alert-item {
      padding: 16px;
      border-radius: 8px;
      border-left: 4px solid;
    }

    .alert-item.alta {
      background-color: #fee2e2;
      border-color: var(--red-error);
    }

    .alert-item.media {
      background-color: #fef3c7;
      border-color: var(--yellow-highlight);
    }

    .alert-item.baixa {
      background-color: #dbeafe;
      border-color: var(--blue-primary);
    }

    .alert-content {
      display: flex;
      align-items: flex-start;
      gap: 12px;
    }

    .alert-icon {
      width: 20px;
      height: 20px;
      flex-shrink: 0;
    }

    .alert-icon.alta { color: var(--red-error); }
    .alert-icon.media { color: var(--yellow-highlight); }
    .alert-icon.baixa { color: var(--blue-primary); }

    .alert-message {
      flex: 1;
      font-size: 14px;
      font-weight: 500;
    }

    .alert-time {
      display: flex;
      align-items: center;
      gap: 4px;
      margin-top: 8px;
      font-size: 12px;
      color: #6b7280;
    }

    .summary {
      margin-top: 24px;
      padding-top: 24px;
      border-top: 1px solid var(--gray-light);
    }

    .summary h3 {
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 16px;
    }

    .summary-list {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .summary-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .summary-label {
      font-size: 14px;
      color: #6b7280;
    }

    .summary-value {
      font-weight: 600;
    }

    .summary-value.success {
      color: #10b981;
    }

    svg {
      width: 24px;
      height: 24px;
    }

    .small-icon {
      width: 16px;
      height: 16px;
    }
</style>
