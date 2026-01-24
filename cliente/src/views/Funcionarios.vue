<template>
  <div class="dashboard">
    <!-- HEADER -->
    <header class="dashboard-header">
      <div class="header-content">
        <h1 class="dashboard-title">Dashboard de Gestão de Funcionários</h1>
        <div class="manager-info">
          <span class="manager-label">Gerente:</span>
          <span class="manager-name">{{ manager.name }}</span>
          <span class="manager-sector">{{ manager.sector }}</span>
        </div>
      </div>
    </header>

    <!-- CONTEÚDO PRINCIPAL -->
    <main class="dashboard-content">
      <div class="employee-list-container">
        <h2 class="section-title">Minha Equipe</h2>
        
        <!-- Filtros -->
        <div class="filters">
          <input
            v-model="searchTerm"
            type="text"
            placeholder="Buscar por nome..."
            class="filter-input"
          />
          <select v-model="filterPosition" class="filter-select">
            <option value="">Todos os cargos</option>
            <option v-for="pos in positions" :key="pos" :value="pos">{{ pos }}</option>
          </select>
          <select v-model="filterSector" class="filter-select">
            <option value="">Todos os setores</option>
            <option v-for="sec in sectors" :key="sec" :value="sec">{{ sec }}</option>
          </select>
        </div>

        <!-- Grid de Funcionários -->
        <div v-if="!loading" class="employee-grid">
          <div
            v-for="employee in filteredEmployees"
            :key="employee.funcionário_id"
            class="employee-card"
          >
            <div class="employee-header">
              <div class="employee-avatar">
                {{ employee.nome_completo.split(' ').map(n => n[0]).join('') }}
              </div>
              <div class="employee-info">
                <h3 class="employee-name">{{ employee.nome_completo }}</h3>
                <p class="employee-position">{{ employee.cargo }}</p>
                <span class="employee-badge">{{ employee.numero_cracha }}</span>
              </div>
            </div>
            
            <div class="employee-details">
              <div class="detail-row">
                <span class="detail-label">Setor:</span>
                <span class="detail-value">{{ employee.setor }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Entrada:</span>
                <span class="detail-value">{{ formatDate(employee.data_entrada) }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Tempo na empresa:</span>
                <span class="detail-value">{{ calculateTenure(employee.data_entrada) }}</span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Observações:</span>
                <span class="detail-value">{{ employee.observacoes }}</span>
              </div>
            </div>

          </div>
        </div>
        
        <div v-if="filteredEmployees.length === 0 && loading || filteredEmployees.length === 0" class="no-results">
          Nenhum funcionário encontrado com os filtros aplicados.
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue';
import axios from 'axios';

// ============================================
// CONFIGURAÇÃO DA API
// ============================================
// Criar instância do axios com configuração padrão

// ============================================
// ESTADO REATIVO
// ============================================
const loading = ref(false); // Estado de carregamento
const error = ref(null); // Mensagem de erro
const manager = reactive({
  id: 1,
  name: 'Ana Silva',
  sector: 'Tecnologia'
})

const employees = ref([])

const fetchEmployees = async () => {
  loading.value = true;
  try {
    const response = await axios.get('/api/funcionarios');
    employees.value = response.data; // ← Salva na lista
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};

// Filtros
const searchTerm = ref('');
const filterPosition = ref('');
const filterSector = ref('');

// ============================================
// COMPUTED PROPERTIES
// ============================================
const filteredEmployees = computed(() => {
  return employees.value.filter(emp => {
    const matchesSearch = emp.nome_completo.toLowerCase().includes(searchTerm.value.toLowerCase());
    const matchesPosition = !filterPosition.value || emp.cargo === filterPosition.value;
    const matchesSector = !filterSector.value || emp.setor === filterSector.value;
    return matchesSearch && matchesPosition && matchesSector;
  });
});
const positions = computed(() => {
  return [...new Set(employees.value.map(e => e.cargo))];
});

const sectors = computed(() => {
  return [...new Set(employees.value.map(e => e.setor))];
});

// ============================================
// MÉTODOS
// ============================================
const formatDate = (dateStr) => {
  const date = new Date(dateStr);
  return date.toLocaleDateString('pt-BR');
};

const calculateTenure = (entryDate) => {
  const start = new Date(entryDate);
  const now = new Date();
  const months = (now.getFullYear() - start.getFullYear()) * 12 + 
                 (now.getMonth() - start.getMonth());
  const years = Math.floor(months / 12);
  const remainingMonths = months % 12;
  
  if (years > 0) {
    return `${years} ano${years > 1 ? 's' : ''} e ${remainingMonths} mês${remainingMonths !== 1 ? 'es' : ''}`;
  }
  return `${remainingMonths} mês${remainingMonths !== 1 ? 'es' : ''}`;
};
onMounted(fetchEmployees);

</script>

<style scoped>
/* ============================================
   HEADER
   ============================================ */
.dashboard-header {
  background: var(--card-bg);
  border-bottom: 2px solid var(--gray-light);
  padding: 1.5rem 2rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.dashboard-title {
  font-size: 1.8rem;
  font-weight: 700;
  color: var(--blue-primary);
}

.manager-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  font-size: 0.95rem;
}

.manager-label {
  color: #6b7280;
}

.manager-name {
  font-weight: 600;
  color: var(--text-light);
}

.manager-sector {
  background: var(--blue-primary);
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.85rem;
}

/* ============================================
   CONTEÚDO
   ============================================ */
.dashboard-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem;
}

.employee-list-container {
  width: 100%;
}

.section-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--text-light);
  margin-bottom: 1.5rem;
}

/* ============================================
   FILTROS
   ============================================ */
.filters {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.filter-input,
.filter-select {
  padding: 0.75rem 1rem;
  border: 2px solid var(--gray-light);
  border-radius: 8px;
  font-size: 0.95rem;
  background: var(--card-bg);
  color: var(--text-light);
  transition: border-color 0.3s ease;
}

.filter-input {
  flex: 1;
  min-width: 250px;
}

.filter-select {
  min-width: 200px;
}

.filter-input:focus,
.filter-select:focus {
  outline: none;
  border-color: var(--blue-primary);
}

/* ============================================
   GRID DE FUNCIONÁRIOS
   ============================================ */
.employee-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 1.5rem;
}

.employee-card {
  background: var(--card-bg);
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.employee-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
}

.employee-header {
  display: flex;
  gap: 1rem;
  margin-bottom: 1.25rem;
  align-items: center;
}

.employee-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--blue-primary), #3b82f6);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.2rem;
  flex-shrink: 0;
}

.employee-info {
  flex: 1;
}

.employee-name {
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--text-light);
  margin-bottom: 0.25rem;
}

.employee-position {
  color: #6b7280;
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
}

.employee-badge {
  background: var(--gray-light);
  padding: 0.25rem 0.5rem;
  border-radius: 6px;
  font-size: 0.8rem;
  font-weight: 600;
  color: var(--text-light);
}

.employee-details {
  border-top: 1px solid var(--gray-light);
  padding-top: 1rem;
  margin-bottom: 1rem;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 0.75rem;
  font-size: 0.9rem;
}

.detail-label {
  color: #6b7280;
  font-weight: 500;
}

.detail-value {
  color: var(--text-light);
  font-weight: 600;
  text-align: right;
  max-width: 60%;
}

.employee-stats {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0.75rem;
  padding-top: 1rem;
  border-top: 1px solid var(--gray-light);
}

.stat-item {
  text-align: center;
  padding: 0.75rem 0.5rem;
  background: var(--bg-dark);
  border-radius: 8px;
}

.stat-item.overtime {
  background: #fef3c7;
}

.stat-item.warning {
  background: #fee2e2;
}

.stat-value {
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--text-light);
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.7rem;
  color: #6b7280;
  text-transform: uppercase;
  font-weight: 600;
}

.no-results {
  text-align: center;
  padding: 3rem;
  color: #6b7280;
  font-size: 1.1rem;
  background: var(--card-bg);
  border-radius: 12px;
  margin-top: 2rem;
}

/* ============================================
   RESPONSIVIDADE
   ============================================ */
@media (max-width: 1024px) {
  .employee-grid {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 1rem;
    text-align: center;
  }
  
  .employee-grid {
    grid-template-columns: 1fr;
  }
  
  .filters {
    flex-direction: column;
  }
  
  .filter-input,
  .filter-select {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .dashboard-content {
    padding: 1rem;
  }
  
  .employee-card {
    padding: 1rem;
  }
  
  .employee-stats {
    grid-template-columns: repeat(2, 1fr);
    gap: 0.5rem;
  }
  
  .stat-value {
    font-size: 1rem;
  }
}
</style>
