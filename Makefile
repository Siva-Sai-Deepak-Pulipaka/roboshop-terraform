git:
	#git pull
	rm -rf .terraform
dev-apply: git
	cd aws_parameters; terraform init -backend-config=dev-env/state.tfvars
	cd aws_parameters; terraform apply -auto-approve -var-file=dev-env/main.tfvars
	terraform init -backend-config=dev-env/state.tfvars
	terraform apply -auto-approve -var-file=dev-env/dev.tfvars

dev-destroy:
	terraform init -backend-config=dev-env/state.tfvars
	terraform destroy -auto-approve -var-file=dev-env/dev.tfvars