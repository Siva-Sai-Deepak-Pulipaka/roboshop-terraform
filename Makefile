git:
	git pull
dev-apply:
	terraform init -backend-config=dev-env/state.tfvars
	terraform apply -auto-approve -var-file=dev-env/dev.tfvars