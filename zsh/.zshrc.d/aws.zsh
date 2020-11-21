docker-ecr-login-talpa () {
    region=eu-west-1
    endpoint=707791534769.dkr.ecr.eu-west-1.amazonaws.com
    passwd=$(aws ecr get-authorization-token --region $region --output text --query 'authorizationData[].authorizationToken' | base64 --decode | cut -d: -f2)
    docker login -u AWS -p $passwd $endpoint
  }

alias awsenv='env | grep AWS_'
awsp() {
	export AWS_PROFILE="$(grep -E '\[(.*)\]' ~/.aws/credentials | sed 's/[][]//g' | fzf)"
}