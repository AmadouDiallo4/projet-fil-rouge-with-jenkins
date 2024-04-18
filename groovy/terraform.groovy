#!/usr/bin/env groovy
/* groovylint-disable MethodParameterTypeRequired, MethodReturnTypeRequired, NoDef, UnusedMethodParameter */

def init(dirname) {
    sh '''
        cd src/terraform/dirname
        terraform init -input=false
    '''
}

def plan(dirname) {
    sh '''
        cd src/terraform/dirname
        terraform plan - out dirname.plan
    '''
}

/* groovylint-disable-next-line MethodParameterTypeRequired */
def apply(dirname) {
    sh '''
        cd src/terraform/dirname
        terraform apply dirname.plan
    '''
}

