# kubernetes.zsh
alias k=kubectl
alias ktx=kubectx
alias kns=kubens

source <(kubectl completion zsh)

ktoken () {
	kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}') | grep token | awk '{print $2}'
}

kl () {
  local pod=($(kubectl get pods --all-namespaces -owide | fzf | awk '{print $1, $2}'))
  local attr=${@:-""}
  
  echo kubectl logs -f $attr --namespace $pod[1] $pod[2]
  kubectl logs -f $attr --namespace $pod[1] $pod[2]
}

kx () {
  local pod=($(kubectl get pods --all-namespaces -owide | fzf | awk '{print $1, $2}'))
  local cmd=${@:-"bash"}
  
  echo kubectl exec -it --namespace $pod[1] $pod[2] $cmd
  kubectl exec -it --namespace $pod[1] $pod[2] $cmd
}

kall () {
  kubectl get all --all-namespaces
}

alias kshell='kubectl run -it shell --image busybox --restart Never --rm -- sh'
