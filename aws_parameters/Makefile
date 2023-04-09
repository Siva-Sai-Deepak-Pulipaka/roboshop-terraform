git:
	git pull
dev-apply:git
	terraform init -backend-config=dev-env/state.tfvars
	terraform apply -auto-approve -var-file=dev-env/main.tfvars
prod-apply:git
	terraform init -backend-config=prod-env/state.tfvars
	terraform apply -auto-approve -var-file=prod-env/main.tfvars