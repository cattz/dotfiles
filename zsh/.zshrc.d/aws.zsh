alias assumer='source ~/Repos/GitLab/incubator/random-utils/assume-role/_assume_role.sh'

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

awsclean() {
	unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_PROFILE
}


listroles(){
	REGEX=".${1}."
	aws iam list-roles | jq -r ".Roles[] | .Arn"
}

# WIP
awsso() {
	export AWS_PROFILE="$(grep -E '\[(.*)\]' ~/.aws/config | sed 's/[][]//g' | awk '{print $2}' | fzf)"
	aws sso login --profile $AWS_PROFILE
}

export AWS_REGION=eu-west-1
