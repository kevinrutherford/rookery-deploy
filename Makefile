.PHONY: deploy

deploy:
	ansible-playbook -i inventory/hosts lemmy.yml

