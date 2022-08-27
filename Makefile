all: publish

# Recipe which publishes the site
publish: publish.el
	@echo "Publishing..."
	emacs --quick --batch --load publish.el --funcall org-publish-all

# Recipe to clean any artifacts produced by the previous recipe
clean:
	@echo "Cleaning up..."
	@rm -rvf public/
