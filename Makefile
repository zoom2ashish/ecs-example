.PHONE: flux-create-git

flux-create-git:
	flux create source git flux-system \
		--namespace=flux-system \
		--url=https://gitlab.eng.vmware.com/ashishp/deploy-go-i18n-example.git \
		--branch=main \
		--interval=30s \
		--username=ashishp@vmware.com \
		--password=$(GITLAB_TOKEN)

flux-deploy-%:
	flux create kustomization go-i18n-example-$* \
		--interval=1m \
		--path="./deploy/$*/" \
		--prune=true \
		--source=GitRepository/flux-system \
		--namespace=flux-system \
		--verbose

flux-delete-%:
	flux delete kustomization go-i18n-example-$* --namespace=flux-system


test-app-%:
	minikube service go-i18n-app -n go-i18n-$*