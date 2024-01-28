.PHONY: deploy

deploy:
	ansible-playbook -i inventory/hosts rookery.yml

