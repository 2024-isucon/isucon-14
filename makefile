.PHONY: help build
.DEFAULT_GOAL := help

DB_SLOW_LOG:=/var/log/mysql/mysql-slow.log

help: ## Check available make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Run the deployment script
	branch=${branch} ./scripts/deploy.sh

setting-nginx: ## Setting up nginx
	sudo bash -c "source ./scripts/setting-nginx.sh"

setting-mysql: ## Setting up mysql
	sudo bash -c "source ./scripts/setting-mysql.sh"

.PHONY: restart-go
restart-go: ## go server を build/リスタートさせる
	cd webapp/go && go build -o isuride
	sudo systemctl restart isuride-go.service

.PHONY: slow-query
slow-query:	## slow query を確認する
	sudo pt-query-digest $(DB_SLOW_LOG)

.PHONY: mv-logs
mv-logs:	## ベンチマーク実行後のログを移動する
	$(eval when := $(shell date "+%s"))
	@mkdir -p ~/logs/$(when)
	# todo
	# sudo test -f $(NGINX_LOG) && \
	# 	sudo mv -f $(NGINX_LOG) ~/logs/$(when)/ || echo ""
	@sudo test -f $(DB_SLOW_LOG) && \
		sudo pt-query-digest $(DB_SLOW_LOG) > ~/logs/$(when)/pt-query-digest.txt || true
	@sudo test -f $(DB_SLOW_LOG) && \
		sudo mv -f $(DB_SLOW_LOG) ~/logs/$(when)/ || echo ""
	@echo "~/logs/$(when)"

.PHONY: init
init:
	MYSQL_PWD='isucon' mysql -u isucon -e "SET GLOBAL slow_query_log = 1;" isuride
	MYSQL_PWD='isucon' mysql -u isucon -e "SET GLOBAL slow_query_log_file = '$(DB_SLOW_LOG)'";
	MYSQL_PWD='isucon' mysql -u isucon -e "SET GLOBAL long_query_time = 0;" isuride

.PHONY: stop-slow-query
stop-slow-query:
	MYSQL_PWD='isucon' mysql -u isucon -e "SET GLOBAL slow_query_log = 0;" isuride

.PHOHY: db
db:	## mysql に root user として入る
	sudo mysql isuride
