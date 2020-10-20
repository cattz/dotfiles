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


kube-forward() {
  if [ -n "$ZSH_VERSION" ]; then
    setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  fi
  IFS=$'\n'
  SERVICES=( $(kubectl get service --no-headers -o=custom-columns="NAME:.metadata.name,PORT:.spec.ports[*].port") )
  unset IFS
 
  TO_KILL=()
 
  cleanup() {
    echo "\nClosing connections..."
    for pid in "${TO_KILL[@]}"
    do
      (kill -2 $pid) &> /dev/null
    done
  }
  trap 'cleanup' INT TERM
 
  HOST_PORT=9001
 
  echo "Forwarding..."
 
  for s in "${SERVICES[@]}"
  do
    SERVICE=( $(echo $s) )
    if [ -n "$ZSH_VERSION" ]; then
      NAME=${SERVICE[1]}
      PORT=${SERVICE[2]}
    else
      NAME=${SERVICE[0]}
      PORT=${SERVICE[1]}
    fi
    PORTS=(${PORT//,/ })
    for PORT in "${PORTS[@]}"
    do
      (kubectl port-forward svc/$NAME $HOST_PORT:$PORT > /dev/null) &
      TO_KILL+=($!)
 
      echo "\e[1m$NAME:$PORT\e[0m ➡ \e[34mhttp://localhost:$HOST_PORT\e[0m"
      ((HOST_PORT=HOST_PORT+1))
    done
  done
 
  echo "\n\e[2m(Use [Ctl + C] to exit)"
  cat
  if [ -n "$BASH_VERSION" ]; then
    cleanup
  fi
}
