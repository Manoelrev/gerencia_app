<script setup lang="ts">
</script>

<template>
  <header>
    <div>
      <img alt="lock-logo" class="lock-logo" src="@/assets/lock-logo.svg" width="125" height="125" />
    </div>
    <h1 class="h1">Bem-vindo de volta</h1>
    <p class="p">Entre com suas credenciais para continuar</p>
  </header>
  <main>
    <section class="card">
      <form class="input-group">
      <label for="fname">Email</label>
      <input type="email" id="fname" name="fname" placeholder="seu@email.com" >
      <label for="lname">Senha</label>
      <input type="password" id="lname" name="lname" placeholder="********" >
      <div class="login-panel">
      <div class="chekbox-panel">
        <input style="width: auto;" type="checkbox" id="remember" name="remember"><label for="remember"> Lembrar-me</label>
      </div>
      <label><a class="a">Esqueceu a senha?</a></label>
      </div>
      <input style="background-color: #3772FF; color: white;" class="submit-button" type="submit" value="Entrar">
    </form> 

    </section>
  </main>
  <footer>
    <h2>© 2026 Todos os direitos reservados</h2>
  </footer>
</template>

<style scoped>
header, main, footer{
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
}
header{
  margin-bottom: 50px;
}

.lock-logo {
  background-color: #FDCA40;
  margin-bottom: 5px;
  padding: 20px;
  border-radius: 15px;
  width:  60px;
  height: auto;
}

.h1{
  margin-bottom: 10px;
  color: #ffffff;
}

.p{
  color: #e6e8e6;
}

.login-panel{
  display: flex;
  justify-content: space-between;
}

input[type=email] {
  background-image: url('@/assets/mail.svg');
  background-position: 10px 10px; 
  background-repeat: no-repeat;
  padding: 12px 20px 12px 40px;
}
input[type=password] {
  background-image: url('@/assets/lock.svg');
  background-position: 10px 10px; 
  background-repeat: no-repeat;
  padding: 12px 20px 12px 40px;
}

.chekbox-panel{
  display: flex;
  gap: 5px;
}

.a{
  color: #3772FF;
}

footer h2{
  color: #e6e8e6;
  font-size: small;
}

</style>
