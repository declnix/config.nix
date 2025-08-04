.PHONY: build switch clean format

define print_banner
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "> $(1)"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
endef

################################################################################
# 🚀 System Deployment Commands
################################################################################

build:
	$(call print_banner,🔨 Building system configuration...)
	@nh os build $(if $(HOSTNAME),-H $(HOSTNAME)) .

switch:
	$(call print_banner,⚡ Applying system configuration...)
	@nh os switch $(if $(HOSTNAME),-H $(HOSTNAME)) .

clean:
	$(call print_banner,🧹 Cleaning up old generations...)
	@nh clean all --keep 3 --keep-since 120h

################################################################################
# 🎨 Code Formatting Commands
################################################################################

format:
	@FILES="${FILES:-$$(find . -name '*.nix')}" && \
	nixfmt $$FILES
