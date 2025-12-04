pipeline {
 agent any 
 options {
        
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: "5"))
}

 parameters {
       
         choice(name: 'TOOLNAME', choices: ['grafana','vault','prometheus'], description: 'select tool name to provision')
         
        

        }   
 stages {
    stage ('running ansible playbbok'){
          steps {
             
             sh "bash setup.sh ${params.TOOLNAME}"
}
            }
   
  

        }
}
    
