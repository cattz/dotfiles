function saml() {
	saml2aws login -a ${1} --skip-prompt
}

alias waws="env | grep -e 'AWS\|KUBE\|TF_'"
alias noaws="for i in \$(waws | cut -d= -f1,1 | paste -); do unset \$i; done"

alias fs-np='source ~/Repos/aws-accounts/fs-np'
alias fs-np-test='source ~/Repos/aws-accounts/fs-np-test'
alias fs-np-ADMIN='source ~/Repos/aws-accounts/fs-np-ADMIN'
alias fs-PROD='source ~/Repos/aws-accounts/fs-PROD'
alias fs-PROD-ADMIN='source ~/Repos/aws-accounts/fs-PROD-ADMIN'
alias esc='source ~/Repos/aws-accounts/esc'