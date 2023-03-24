git:
	git pull
dev-apply: git
	terraform init -backend-config=dev-env/state.tfvars
	terraform apply -auto-approve -var-file=dev-env/dev.tfvars

dev-destroy:
	terraform destroy -auto-approve -var-file=dev-env/dev.tfvars