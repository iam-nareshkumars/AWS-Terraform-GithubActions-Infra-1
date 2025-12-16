pipeline {
 agent any 
 options {
        ansiColor('xterm')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: "3"))
}

 parameters {
       
         
         choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'select terraform options')
         choice(name: 'TOOL', choices: ['vault', 'tomcat'], description: 'select terraform options')
        

        }   
 stages {
    stage ('initiating terraform'){
          steps {
             sh "terraform --version"
             sh "rm -rf .terraform*"
             
             sh "terraform init"
}
            }
   

    // stage('Sanity check before terraform apply') {
    //         steps {
    //             input "Click on Yes to approve terraform apply"
    //         }
    //     }

    stage('Terraform plan') {
    
        steps {
            sh "terraform plan "
            
              }
            }
    stage('Terraform apply/destroy') {
    
        steps {
            sh "terraform  ${params.ACTION} -target=${params.TOOL}  -auto-approve" 
            
              
              }
    }
        

        }
}
    
