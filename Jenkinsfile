pipeline {
  tools{
    terraform 'terraform'
  }
  agent any
  stages{
    stage('Provisioning'){
      steps{
         echo "PROVISIONING"
      }
    }
    stage('Deploy'){
      steps{
        withEnv(readFile('version.txt').split('\n') as List){
          script{
            if(${NOME}){
              env.FRONT_END=${NOME}
            }
          }
          ansiblePlaybook credentialsId: 'node', disableHostKeyChecking: true, extras: "-e FRONT_END=${env.FRONT_END} -e EDGE_ROUTER=${env.EDGE_ROUTER} -e CATALOGUE_DB=${env.CATALOGUE_DB} -e CATALOGUE=${env.CATALOGUE} -e CARTS=${env.CARTS} -e CARTS_DB=${env.CARTS_DB} -e ORDERS=${env.ORDERS} -e ORDERS_DB=${env.ORDERS_DB} -e SHIPPING=${env.SHIPPING} -e QUEUE_MASTER=${env.QUEUE_MASTER}  -e RABBIT_MQ=${env.RABBIT_MQ} -e PAYMENT=${env.PAYMENT} -e USER=${env.USER} -e USER_DB=${env.USER_DB} ", installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'deploy_app.yml'         
        }     
      }
    }
  }
}
