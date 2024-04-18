#!/usr/bin/env groovy
//
/* groovylint-disable MethodParameterTypeRequired, MethodReturnTypeRequired, NoDef, UnusedMethodParameter */ 

def init(name) {
    /* groovylint-disable-next-line GStringExpressionWithinString */
    sh "terraform -chdir=src/terraform/${name} init -input=false"
    
}

def plan(name) {
    /* groovylint-disable-next-line GStringExpressionWithinString */
    sh "terraform -chdir=src/terraform/${name} plan -out ${name}.plan"
}

/* groovylint-disable-next-line GStringExpressionWithinString, MethodParameterTypeRequired */
def apply(name) {
    /* groovylint-disable-next-line GStringExpressionWithinString */
    sh "terraform -chdir=src/terraform/${name} apply ${name}.plan"
}

