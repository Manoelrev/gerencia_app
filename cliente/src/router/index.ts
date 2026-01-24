import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../views/Dashboard.vue'
import Funcionarios from '../views/Funcionarios.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/dashboard',
      alias: '/',
      name: 'dashboard',
      component: Dashboard,
    },
    {
      path: '/funcionario',
      name: 'funcionario',
      component: Funcionarios,
    }
  ],
})

export default router
