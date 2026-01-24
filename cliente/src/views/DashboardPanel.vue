<template>
  <div class="sidebar">
    <!-- Logo e Título -->
    <div class="sidebar-header">
      <div class="logo">
        <div class="logo-icon">🏢</div>
        <div class="logo-text">
          <h1 class="company-name">GerenciaAI</h1>
          <p class="company-subtitle">Sistema de Gestão</p>
        </div>
      </div>
    </div>

    <!-- Informações do Gerente -->
    <div class="manager-profile">
      <div class="manager-avatar">
        {{ manager.name.split(' ').map(n => n[0]).join('') }}
      </div>
      <div class="manager-details">
        <h3 class="manager-name">{{ manager.name }}</h3>
        <p class="manager-role">{{ manager.role }}</p>
        <span class="manager-sector">{{ manager.sector }}</span>
      </div>
      <div class="manager-status online">
        <span class="status-dot"></span>
        <span class="status-text">Online</span>
      </div>
    </div>

    <!-- Menu de Navegação -->
    <nav class="sidebar-nav">
      <div class="nav-section">
        <ul class="nav-list">
          <router-link tag="li"
            v-for="item in mainMenuItems" 
            :key="item.id"
            :class="['nav-item', { active: activeMenu === item.id }]"
            @click="activeMenu = item.id"
            :to="item.id"
          >
            <span class="nav-icon">{{ item.icon }}</span>
            <span class="nav-label">{{ item.label }}</span>
            <span v-if="item.badge" class="nav-badge">{{ item.badge }}</span>
          </router-link>
        </ul>
      </div>
    </nav>

    <!-- Estatísticas Rápidas -->
    <div class="quick-stats">
      <h4 class="stats-title">Resumo Rápido</h4>
      <div class="stat-row">
        <span class="stat-icon">👥</span>
        <div class="stat-info">
          <p class="stat-value">{{ stats.totalEmployees }}</p>
          <p class="stat-label">Funcionários</p>
        </div>
      </div>
      <div class="stat-row">
        <span class="stat-icon">✅</span>
        <div class="stat-info">
          <p class="stat-value">{{ stats.present }}</p>
          <p class="stat-label">Presentes Hoje</p>
        </div>
      </div>
      <div class="stat-row warning">
        <span class="stat-icon">⚠️</span>
        <div class="stat-info">
          <p class="stat-value">{{ stats.pending }}</p>
          <p class="stat-label">Pendências</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue';

// ============================================
// DADOS DO GERENTE
// ============================================
const manager = reactive({
  name: 'Ana Silva',
  role: 'Gerente de TI',
  sector: 'Tecnologia',
  status: 'online'
});

// ============================================
// MENU ATIVO
// ============================================
const activeMenu = ref('dashboard');

// ============================================
// ITENS DO MENU PRINCIPAL
// ============================================
const mainMenuItems = reactive([
  { id: 'dashboard', icon: '📊', label: 'Dashboard', badge: null },
  { id: 'producao', icon: '🏭', label: 'Produção', badge: null },
  { id: 'funcionario', icon: '👥', label: 'Funcionários', badge: '6' },
  { id: 'eficiencia', icon: '🏢', label: 'Eficiencia', badge: null },
  { id: 'qualidade', icon: '📋', label: 'Qualidade', badge: '3' }
]);

// ============================================
// ESTATÍSTICAS RÁPIDAS
// ============================================
const stats = reactive({
  totalEmployees: 6,
  present: 5,
  pending: 3
});
</script>

<style scoped>
/* ============================================
   VARIÁVEIS
   ============================================ */

/* ============================================
   SIDEBAR PRINCIPAL
   ============================================ */
.sidebar {
  width: 280px;
  height: 100vh;
  background: #1e293b;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  box-shadow: 4px 0 12px rgba(0, 0, 0, 0.15);
  position: fixed;
  left: 0;
  top: 0;
}

.sidebar::-webkit-scrollbar {
  width: 6px;
}

.sidebar::-webkit-scrollbar-track {
  background: #0f172a;
}

.sidebar::-webkit-scrollbar-thumb {
  background: #334155;
  border-radius: 3px;
}

/* ============================================
   HEADER DA SIDEBAR
   ============================================ */
.sidebar-header {
  padding: 1.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.logo-icon {
  font-size: 2.5rem;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
}

.logo-text {
  flex: 1;
}

.company-name {
  font-size: 1.4rem;
  font-weight: 700;
  margin: 0;
  background: linear-gradient(135deg, #2563eb, #3b82f6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.company-subtitle {
  font-size: 0.75rem;
  color: #94a3b8;
  margin: 0.25rem 0 0 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* ============================================
   PERFIL DO GERENTE
   ============================================ */
.manager-profile {
  padding: 1.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.manager-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: linear-gradient(135deg, #2563eb), #3b82f6;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.3rem;
  margin-bottom: 1rem;
  box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
}

.manager-details {
  margin-bottom: 0.75rem;
}

.manager-name {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0 0 0.25rem 0;
}

.manager-role {
  font-size: 0.85rem;
  color: #94a3b8;
  margin: 0 0 0.5rem 0;
}

.manager-sector {
  display: inline-block;
  background: rgba(37, 99, 235, 0.2);
  color: #60a5fa;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
  border: 1px solid rgba(37, 99, 235, 0.3);
}

.manager-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.8rem;
  margin-top: 0.75rem;
}

.manager-status.online {
  color: #10b981;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #10b981;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

/* ============================================
   NAVEGAÇÃO
   ============================================ */
.sidebar-nav {
  flex: 1;
  padding: 1rem 0;
  overflow-y: auto;
}

.nav-section {
  margin-bottom: 1.5rem;
}

.nav-section-title {
  font-size: 0.7rem;
  font-weight: 700;
  color: #94a3b8;
  padding: 0 1.5rem;
  margin-bottom: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.nav-list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.875rem 1.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

.nav-item::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 4px;
  background: #2563eb;
  transform: scaleY(0);
  transition: transform 0.3s ease;
}

.nav-item:hover {
  background: #334155;
}

.nav-item.active {
  background: rgba(37, 99, 235, 0.15);
  color: #ffffff;
}

.nav-item.active::before {
  transform: scaleY(1);
}

.nav-icon {
  font-size: 1.3rem;
  width: 28px;
  text-align: center;
}

.nav-label {
  flex: 1;
  font-size: 0.9rem;
  font-weight: 500;
}

.nav-badge {
  background: #2563eb;
  color: white;
  padding: 0.15rem 0.5rem;
  border-radius: 10px;
  font-size: 0.7rem;
  font-weight: 600;
  min-width: 20px;
  text-align: center;
}

/* ============================================
   ESTATÍSTICAS RÁPIDAS
   ============================================ */
.quick-stats {
  padding: 1rem 1.5rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.stats-title {
  font-size: 0.8rem;
  font-weight: 700;
  color: #94a3b8;
  margin: 0 0 1rem 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.stat-row {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem;
  margin-bottom: 0.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  transition: all 0.3s ease;
}

.stat-row:hover {
  background: rgba(255, 255, 255, 0.08);
  transform: translateX(4px);
}

.stat-row.warning {
  background: rgba(245, 158, 11, 0.1);
  border-left: 3px solid #f59e0b;
}

.stat-icon {
  font-size: 1.5rem;
}

.stat-info {
  flex: 1;
}

.stat-value {
  font-size: 1.3rem;
  font-weight: 700;
  margin: 0;
  line-height: 1;
}

.stat-label {
  font-size: 0.75rem;
  color: #94a3b8;
  margin: 0.25rem 0 0 0;
}

/* ============================================
   RESPONSIVIDADE
   ============================================ */
@media (max-width: 768px) {
  .sidebar {
    width: 240px;
  }
}
</style>