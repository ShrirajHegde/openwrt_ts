#!/bin/sh /etc/rc.common

# Copyright 2020 Google LLC.
# Copyright (C) 2021 CZ.NIC z.s.p.o. (https://www.nic.cz/)
# SPDX-License-Identifier: Apache-2.0

# /etc/init.d/tailscale

USE_PROCD=1
START=80


start_service() {
  local state_file
  local port
  local std_err std_out

  config_load tailscale
  config_get_bool std_out "settings" log_stdout 1
  config_get_bool std_err "settings" log_stderr 1
  config_get port "settings" port 41641
  config_get state_file "settings" state_file /etc/tailscale/tailscaled.state

  /usr/sbin/tailscaled --cleanup

  procd_open_instance
  procd_set_param command /usr/sbin/tailscaled

  # Set the port to listen on for incoming VPN packets.
  # Remote nodes will automatically be informed about the new port number,
  # but you might want to configure this in order to set external firewall
  # settings.
  procd_append_param command --port "$port"
  procd_append_param command --state "$state_file"

  procd_set_param respawn
  procd_set_param stdout "$std_out"
  procd_set_param stderr "$std_err"

  procd_close_instance
}

stop_service() {
  /usr/sbin/tailscaled --cleanup
}
