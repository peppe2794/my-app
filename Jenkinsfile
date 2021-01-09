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
          ansiblePlaybook credentialsId: 'node', disableHostKeyChecking: true, extras: "-e FRONT_END=${env.FRONT_END} EDGE_ROUTER=${env.EDGE_ROUTER} CATALOGUE_DB=${env.CATALOGUE_DB} CATALOGUE=${env.CATALOGUE} CARTS=${env.CARTS} CARTS_DB=${env.CARTS_DB} ORDERS=${env.ORDERS} ORDERS_DB=${env.ORDERS_DB} SHIPPING=${env.SHIPPING} QUEUE_MASTER=${env.QUEUE_MASTER}  RABBIT_MQ =${env.RABBIT_MQ} PAYMENT=${env.PAYMENT} USER=${env.USER} USER_DB=${env.USER_DB} ", installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'deploy_app.yml'         
        }     
      }
    }
  }
}
