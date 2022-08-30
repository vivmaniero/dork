all: publish

# Recipe which publishes the site
publish: site/publish.el
	@echo "Publishing..."
	emacs --quick --batch --load site/publish.el --funcall org-publish-all

# Recipe to clean any artifacts produced by the previous recipe
clean:
	@echo "Cleaning up..."
	@rm -rvf .timestamps/
	@rm -rvf public/
