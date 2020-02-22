<template>
  <div>
    <v-app-bar>
      <v-toolbar-title>
        Arca de Noe
      </v-toolbar-title>
      <v-spacer/>

      <v-btn icon @click="getWeb3"> <v-icon color="pruple">mdi-account</v-icon></v-btn>
      {{this.cuenta ? this.cuenta[0] : ""}}
      <v-btn icon ><v-icon color="pruple">mdi-wallet</v-icon></v-btn>
    </v-app-bar>
    <v-container>
    </v-container>  
  </div>
</template>

<script>
  import web3 from 'web3';
  export default {
    name: 'HelloWorld',

    data: () => ({
      cuenta: null,
      balance: null
    }),
    methods: {
      async getWeb3(){
        await window.ethereum.enable(); // Iniciar conexion con metamastk
        const instance = new web3(window.ethereum);
        this.cuenta = await instance.eth.getAccounts(); // obtener la instancia

        //Evento a la escucha
        window.ethereum.on('accountsChanged', function(nuevas_cuentas){
          this.cuentas = nuevas_cuentas;
          console.log(this.cuentas);
        });
      }
    }
  }
</script>
