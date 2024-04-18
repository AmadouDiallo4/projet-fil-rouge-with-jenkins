#!/usr/bin/env groovy
/* groovylint-disable MethodParameterTypeRequired, MethodReturnTypeRequired, NoDef, UnusedMethodParameter */

def init(name) {
    /* groovylint-disable-next-line GStringExpressionWithinString */
    sh '''
        cd src/terraform/${name}
        terraform init -input=false
    '''
}

def plan(name) {
    /* groovylint-disable-next-line GStringExpressionWithinString */
    sh '''
        cd src/terraform/${name}
        terraform plan - out ${name}.plan
    '''
}

/* groovylint-disable-next-line GStringExpressionWithinString, MethodParameterTypeRequired */
def apply(name) {
    /* groovylint-disable-next-line GStringExpressionWithinString */
    sh '''
        cd src/terraform/${name}
        terraform apply ${name}.plan
    '''
}

