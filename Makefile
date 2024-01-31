APPLICATION_DIR := application
INVENTORY := inventory/hosts

.PHONY: check deploy preview stop-preview

check:
	ansible-playbook -i $(INVENTORY) rookery.yml --syntax-check

preview:
	cd $(APPLICATION_DIR) && docker compose up -d

stop-preview:
	cd $(APPLICATION_DIR) && docker compose down

deploy:
	ansible-playbook -i $(INVENTORY) rookery.yml

