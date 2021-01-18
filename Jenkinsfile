pipeline {
  tools{
    terraform 'terraform'
  }
  agent any
  stages{
    stage('Provisioning VM on Proxmox with Terraform'){
      steps{
        withCredentials([usernamePassword(credentialsId: 'Proxmox', passwordVariable: 'PASSWORD', usernameVariable: 'USER')]) {
          sh label: '', script: 'terraform init'
          sh label: '', script: 'export PM_USER=${USER}; export PM_PASS=${PASSWORD}; terraform apply --auto-approve'
          sh 'sleep 60'
        }
      }
    }
    stage('Static Assessment Provisioned Environment'){
      steps{
        ansiblePlaybook become: true, credentialsId: 'node', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'oscap_assessment.yml'
        ansiblePlaybook become: true, credentialsId: 'node', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'inspec_assessment.yml'
      }
    }
    stage('Deploy'){
      steps{
        script{
          load "version.txt"
          if(params.FRONT_END){
            env.FRONT_END=params.FRONT_END
          }
          ansiblePlaybook credentialsId: 'node', disableHostKeyChecking: true, extras: "-e FRONT_END=${env.FRONT_END} -e EDGE_ROUTER=${env.EDGE_ROUTER} -e CATALOGUE_DB=${env.CATALOGUE_DB} -e CATALOGUE=${env.CATALOGUE} -e CARTS=${env.CARTS} -e CARTS_DB=${env.CARTS_DB} -e ORDERS=${env.ORDERS} -e ORDERS_DB=${env.ORDERS_DB} -e SHIPPING=${env.SHIPPING} -e QUEUE_MASTER=${env.QUEUE_MASTER}  -e RABBIT_MQ=${env.RABBIT_MQ} -e PAYMENT=${env.PAYMENT} -e USER=${env.USER} -e USER_DB=${env.USER_DB} ", installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'deploy_app.yml'         
        }
      }    
    }
  }
}
