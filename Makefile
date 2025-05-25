PBMGMT_HOSTS  = "playbooks/playbook_manage_hosts.yaml"
PBMGMT_PODMAN = "playbooks/playbook_podman.yaml"
PBMGMT_CLD = "playbooks/playbook_cloudhosts.yaml"
PBMGMT_HOMELAB = "playbooks/playbook_homelab.yaml"

# role based:
PBMGMT_DOCKER = "playbooks/playbook_docker.yaml"
PBMGMT_DOCKER_ROOTLESS = "playbooks/playbook_docker_rootless.yaml"
PBMGMT_ARCH_BASE = "playbooks/playbook_arch_base.yaml"
PBMGMT_ARCH_PACKAGES = "playbooks/playbook_arch_packages.yaml"

# secrets
VAULT = --vault-password-file vaultpass

# other tasks sets
ARCH_UPDATE_TAGS_STR = "get_facts \
hosts_file \
sudo_conf \
pacman_update \
install_check_missing_pacman_packages \
build_pacman_missing_list \
pacman_install_missing_packages \
build_aur_missing_list \
aur_install_missing_packages \
k400_udev_rules \
cpupower_settings \
systemd_started_cpupower \
install_xdg_terminal_exec \
gsettings_terminal_validate \
gsettings_terminal \
gsettings_terminal_args_validate \
gsettings_terminal_args \
validate_install_go_packages \
install_go_packages \
xterm_kitty_link \
install_sddm_face_icon \
create_sddm_config_dir \
install_sddm_config_file \
install_sddm_eikeno_theme \
install_ssh_agent_unit_file \
qemu_bridge_conf \
libvirt_qemu_conf \
libvirt_qemu_default_network \
systemd_started_libvirtd \
libvirtd_auth_unix_ro \
libvirtd_auth_unix_rw \
install_hatari \
install_udev_usb_controller_rules"

ARCH_UPDATE_TAGS := `echo $(ARCH_UPDATE_TAGS_STR) | sed 's/ /,/g'`
NAS_UPDATE_TAGS := `echo $(ARCH_UPDATE_TAGS_STR) | sed 's/ /,/g' | sed 's/install_hatari,//'`


VIVO_UPDATE_TAGS_STR = "get_facts \
hosts_file \
sudo_conf \
pacman_update \
install_check_missing_pacman_packages \
build_pacman_missing_list \
pacman_install_missing_packages \
build_aur_missing_list \
aur_install_missing_packages \
k400_udev_rules \
cpupower_settings \
systemd_started_cpupower \
install_xdg_terminal_exec \
gsettings_terminal_validate \
gsettings_terminal \
gsettings_terminal_args_validate \
gsettings_terminal_args \
validate_install_go_packages \
xterm_kitty_link \
install_ssh_agent_unit_file \
install_udev_usb_controller_rules"

VIVO_ARCH_UPDATE_TAGS := `echo $(VIVO_UPDATE_TAGS_STR)  | sed 's/ /,/g'`

MAC_ARCH_UPDATE_TAGS_STR = "get_facts \
hosts_file \
sudo_conf \
pacman_update \
install_check_missing_pacman_packages \
build_pacman_missing_list \
pacman_install_missing_packages \
build_aur_missing_list \
aur_install_missing_packages \
k400_udev_rules \
cpupower_settings \
systemd_started_cpupower \
install_xdg_terminal_exec \
gsettings_terminal_validate \
gsettings_terminal \
gsettings_terminal_args_validate \
gsettings_terminal_args \
validate_install_go_packages \
install_go_packages \
xterm_kitty_link \
install_sddm_face_icon \
create_sddm_config_dir \
install_sddm_config_file \
install_sddm_eikeno_theme \
install_ssh_agent_unit_file \
qemu_bridge_conf \
libvirt_qemu_conf \
libvirt_qemu_default_network \
systemd_started_libvirtd \
libvirtd_auth_unix_ro \
libvirtd_auth_unix_rw"

MAC_ARCH_UPDATE_TAGS := `echo $(MAC_ARCH_UPDATE_TAGS_STR) | sed 's/ /,/g'`

generate_packages_lists:
	@( pushd packages; bash ./generate.sh; popd )

update_archl: generate_packages_lists
	ansible-playbook -i inventory $(VAULT)  --ask-become-pass  			-t $(ARCH_UPDATE_TAGS)     --limit archl -v $(PBMGMT_HOSTS)

update_archmac_lan_clg: generate_packages_lists
	ansible-playbook -i inventory $(VAULT) --ask-become-pass 		    -t $(MAC_ARCH_UPDATE_TAGS) --limit archmac_lan_clg -v $(PBMGMT_HOSTS)

update_archnas_lan_clg: generate_packages_lists
	ansible-playbook -i inventory $(VAULT) --ask-become-pass $(VAULT)   -t $(NAS_UPDATE_TAGS)     --limit archnas_lan -v $(PBMGMT_HOSTS)

update_archmsi_lan_spa: generate_packages_lists
	ansible-playbook -i inventory $(VAULT)                    		    -t $(ARCH_UPDATE_TAGS)     --limit archmsi_lan_spa -v $(PBMGMT_HOSTS)

podman_archmsi_lan_spa: generate_packages_lists
	ansible-playbook -i inventory $(VAULT)                                              			--limit archmsi_lan_spa -v $(PBMGMT_PODMAN)

update_vivo_lan_clg: generate_packages_lists
	ansible-playbook -i inventory $(VAULT)                              -t $(VIVO_ARCH_UPDATE_TAGS) --limit archvivo_lan_clg -v $(PBMGMT_HOSTS)

update_siteperso:
	ansible-playbook -i inventory $(VAULT) --ask-become-pass  -v $(PBMGMT_CLD)

apply_role_docker:
	ansible-playbook -i inventory $(VAULT) --ask-become-pass  -v $(PBMGMT_DOCKER)

apply_role_rootless_docker:
	ansible-playbook -i inventory $(VAULT) --ask-become-pass  --limit archnas_lan -e ruser=`whoami` -v $(PBMGMT_DOCKER_ROOTLESS)

apply_role_arch_all_packages:
	ansible-playbook -i inventory $(VAULT) --ask-become-pass  --limit archmsi_lan_spa -e ruser=`whoami` -v $(PBMGMT_ARCH_PACKAGES)

homelab:
	ansible-playbook -i inventory $(VAULT) --ask-become-pass  -v $(PBMGMT_HOMELAB)

arch_base:
	ansible-playbook -i inventory $(VAULT) --ask-become-pass  -v $(PBMGMT_ARCH_BASE)

test:
	@echo $(ARCH_UPDATE_TAGS)
	@echo "----------------"
	@echo $(VIVO_ARCH_UPDATE_TAGS)
