Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7085F57EC4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0Izk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 04:55:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:15142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfF0Izj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 04:55:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 01:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="xz'?scan'208";a="361080380"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2019 01:55:25 -0700
Date:   Thu, 27 Jun 2019 16:55:34 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        lkp@01.org
Subject: [nl80211] d8572a564d: assertion_failed
Message-ID: <20190627085534.GF7221@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6FinHCQBQ0zFDOqT"
Content-Disposition: inline
In-Reply-To: <20190619223606.4575-2-denkenz@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--6FinHCQBQ0zFDOqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: d8572a564d8aa17cb726a2aed04d0bbe52403249 ("[PATCH 2/3] nl80211: Limit certain commands to interface owner")
url: https://github.com/0day-ci/linux/commits/Denis-Kenzior/nl80211-Update-uapi-for-CMD_FRAME_WAIT_CANCEL/20190622-213015
base: https://git.kernel.org/cgit/linux/kernel/git/jberg/mac80211-next.git master

in testcase: hwsim
with following parameters:

	group: hwsim-13



on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+---------------------------------------------------------------------------------+------------+------------+
|                                                                                 | 97b91db67a | d8572a564d |
+---------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                  | 2          | 0          |
| boot_failures                                                                   | 18         | 20         |
| BUG:kernel_reboot-without-warning_in_test_stage                                 | 18         | 4          |
| assertion_failed                                                                | 0          | 16         |
| WARNING:at_net/wireless/reg.c:#reset_regdomains[cfg80211]                       | 0          | 16         |
| RIP:reset_regdomains[cfg80211]                                                  | 0          | 16         |
| WARNING:at_net/wireless/reg.c:#update_all_wiphy_regulatory[cfg80211]            | 0          | 16         |
| RIP:update_all_wiphy_regulatory[cfg80211]                                       | 0          | 16         |
| WARNING:at_net/wireless/mlme.c:#cfg80211_process_mlme_unregistrations[cfg80211] | 0          | 16         |
| RIP:cfg80211_process_mlme_unregistrations[cfg80211]                             | 0          | 16         |
| WARNING:at_net/core/dev.c:#call_netdevice_notifiers_info                        | 0          | 11         |
| RIP:call_netdevice_notifiers_info                                               | 0          | 11         |
| WARNING:at_net/wireless/nl80211.c:#__cfg80211_wdev_from_attrs[cfg80211]         | 0          | 16         |
| RIP:__cfg80211_wdev_from_attrs[cfg80211]                                        | 0          | 16         |
| WARNING:at_net/sched/sch_api.c:#qdisc_hash_add                                  | 0          | 10         |
| RIP:qdisc_hash_add                                                              | 0          | 10         |
| WARNING:at_net/core/rtnetlink.c:#rtnl_fill_ifinfo                               | 0          | 12         |
| RIP:rtnl_fill_ifinfo                                                            | 0          | 12         |
| WARNING:at_net/core/devlink.c:#devlink_compat_phys_port_name_get                | 0          | 12         |
| RIP:devlink_compat_phys_port_name_get                                           | 0          | 12         |
| WARNING:at_net/core/devlink.c:#devlink_compat_switch_id_get                     | 0          | 12         |
| RIP:devlink_compat_switch_id_get                                                | 0          | 12         |
| WARNING:at_net/core/rtnetlink.c:#rtnl_xdp_prog_skb                              | 0          | 12         |
| RIP:rtnl_xdp_prog_skb                                                           | 0          | 12         |
| WARNING:at_net/core/fib_rules.c:#fib_rules_event                                | 0          | 11         |
| RIP:fib_rules_event                                                             | 0          | 11         |
| WARNING:at_net/ipv4/devinet.c:#inetdev_event                                    | 0          | 11         |
| RIP:inetdev_event                                                               | 0          | 11         |
| WARNING:at_net/wireless/nl80211.c:#__cfg80211_rdev_from_attrs[cfg80211]         | 0          | 16         |
| RIP:__cfg80211_rdev_from_attrs[cfg80211]                                        | 0          | 16         |
| WARNING:at_net/wireless/core.c:#cfg80211_rdev_by_wiphy_idx[cfg80211]            | 0          | 16         |
| RIP:cfg80211_rdev_by_wiphy_idx[cfg80211]                                        | 0          | 16         |
| WARNING:at_net/wireless/util.c:#cfg80211_change_iface[cfg80211]                 | 0          | 16         |
| RIP:cfg80211_change_iface[cfg80211]                                             | 0          | 16         |
| WARNING:at_net/wireless/util.c:#cfg80211_process_rdev_events[cfg80211]          | 0          | 16         |
| RIP:cfg80211_process_rdev_events[cfg80211]                                      | 0          | 16         |
| WARNING:at_net/mac80211/iface.c:#ieee80211_if_change_type[mac80211]             | 0          | 16         |
| RIP:ieee80211_if_change_type[mac80211]                                          | 0          | 16         |
| WARNING:at_net/wireless/nl80211.c:#nl80211_set_wiphy[cfg80211]                  | 0          | 16         |
| RIP:nl80211_set_wiphy[cfg80211]                                                 | 0          | 16         |
| WARNING:at_net/wireless/chan.c:#cfg80211_reg_can_beacon_relax[cfg80211]         | 0          | 16         |
| RIP:cfg80211_reg_can_beacon_relax[cfg80211]                                     | 0          | 16         |
| WARNING:at_net/wireless/reg.c:#restore_regulatory_settings[cfg80211]            | 0          | 2          |
| RIP:restore_regulatory_settings[cfg80211]                                       | 0          | 2          |
| WARNING:at_net/wireless/core.c:#wiphy_idx_to_wiphy[cfg80211]                    | 0          | 8          |
| RIP:wiphy_idx_to_wiphy[cfg80211]                                                | 0          | 8          |
| WARNING:at_net/wireless/core.c:#__cfg80211_leave[cfg80211]                      | 0          | 3          |
| RIP:__cfg80211_leave[cfg80211]                                                  | 0          | 3          |
| BUG:unable_to_handle_page_fault_for_address                                     | 0          | 1          |
| Oops:#[##]                                                                      | 0          | 1          |
| RIP:netpoll_poll_disable                                                        | 0          | 1          |
| Kernel_panic-not_syncing:Fatal_exception                                        | 0          | 2          |
| WARNING:at_net/ipv4/igmp.c:#ip_mc_up                                            | 0          | 6          |
| RIP:ip_mc_up                                                                    | 0          | 6          |
| WARNING:at_net/ipv4/igmp.c:#____ip_mc_inc_group                                 | 0          | 6          |
| RIP:____ip_mc_inc_group                                                         | 0          | 6          |
| WARNING:at_net/wireless/core.c:#cfg80211_update_iface_num[cfg80211]             | 0          | 7          |
| RIP:cfg80211_update_iface_num[cfg80211]                                         | 0          | 7          |
| WARNING:at_net/wireless/wext-sme.c:#cfg80211_mgd_wext_connect[cfg80211]         | 0          | 6          |
| RIP:cfg80211_mgd_wext_connect[cfg80211]                                         | 0          | 6          |
| WARNING:at_net/ipv6/addrconf.c:#addrconf_dev_config                             | 0          | 4          |
| RIP:addrconf_dev_config                                                         | 0          | 4          |
| WARNING:at_net/ipv6/addrconf.c:#addrconf_add_dev                                | 0          | 4          |
| RIP:addrconf_add_dev                                                            | 0          | 4          |
| WARNING:at_net/ipv6/addrconf.c:#ipv6_find_idev                                  | 0          | 4          |
| RIP:ipv6_find_idev                                                              | 0          | 4          |
| WARNING:at_net/mac80211/iface.c:#ieee80211_check_concurrent_iface[mac80211]     | 0          | 4          |
| RIP:ieee80211_check_concurrent_iface[mac80211]                                  | 0          | 4          |
| WARNING:at_net/wireless/reg.c:#set_regdom[cfg80211]                             | 0          | 7          |
| RIP:set_regdom[cfg80211]                                                        | 0          | 7          |
| general_protection_fault:#[##]                                                  | 0          | 1          |
| RIP:dev_deactivate_many                                                         | 0          | 1          |
| WARNING:at_net/wireless/chan.c:#cfg80211_any_wiphy_oper_chan[cfg80211]          | 0          | 1          |
| RIP:cfg80211_any_wiphy_oper_chan[cfg80211]                                      | 0          | 1          |
| WARNING:at_net/wireless/core.c:#cfg80211_destroy_ifaces[cfg80211]               | 0          | 2          |
| RIP:cfg80211_destroy_ifaces[cfg80211]                                           | 0          | 2          |
| WARNING:at_net/mac80211/iface.c:#ieee80211_if_add[mac80211]                     | 0          | 2          |
| RIP:ieee80211_if_add[mac80211]                                                  | 0          | 2          |
| WARNING:at_net/core/dev.c:#register_netdevice                                   | 0          | 2          |
| RIP:register_netdevice                                                          | 0          | 2          |
| WARNING:at_net/core/dev.c:#__netdev_update_features                             | 0          | 2          |
| RIP:__netdev_update_features                                                    | 0          | 2          |
| WARNING:at_net/core/dev.c:#list_netdevice                                       | 0          | 2          |
| RIP:list_netdevice                                                              | 0          | 2          |
| WARNING:at_net/ipv4/devinet.c:#inetdev_init                                     | 0          | 2          |
| RIP:inetdev_init                                                                | 0          | 2          |
| WARNING:at_net/ipv4/igmp.c:#ip_mc_init_dev                                      | 0          | 2          |
| RIP:ip_mc_init_dev                                                              | 0          | 2          |
| WARNING:at_net/ipv6/addrconf.c:#ipv6_add_dev                                    | 0          | 2          |
| RIP:ipv6_add_dev                                                                | 0          | 2          |
| WARNING:at_net/ipv6/mcast.c:#__ipv6_dev_mc_inc                                  | 0          | 2          |
| RIP:__ipv6_dev_mc_inc                                                           | 0          | 2          |
| WARNING:at_net/mac80211/iface.c:#ieee80211_if_remove[mac80211]                  | 0          | 2          |
| RIP:ieee80211_if_remove[mac80211]                                               | 0          | 2          |
| WARNING:at_net/core/dev.c:#unregister_netdevice_queue                           | 0          | 2          |
| RIP:unregister_netdevice_queue                                                  | 0          | 2          |
| WARNING:at_net/ipv4/igmp.c:#ip_mc_down                                          | 0          | 2          |
| RIP:ip_mc_down                                                                  | 0          | 2          |
| WARNING:at_net/ipv4/igmp.c:#__ip_mc_dec_group                                   | 0          | 2          |
| RIP:__ip_mc_dec_group                                                           | 0          | 2          |
| WARNING:at_net/ipv6/addrconf.c:#addrconf_ifdown                                 | 0          | 2          |
| RIP:addrconf_ifdown                                                             | 0          | 2          |
| WARNING:at_net/ipv6/addrconf.c:#__ipv6_ifa_notify                               | 0          | 3          |
| RIP:__ipv6_ifa_notify                                                           | 0          | 3          |
| WARNING:at_net/ipv6/mcast.c:#__ipv6_dev_mc_dec                                  | 0          | 2          |
| RIP:__ipv6_dev_mc_dec                                                           | 0          | 2          |
| WARNING:at_net/core/dev.c:#unlist_netdevice                                     | 0          | 1          |
| RIP:unlist_netdevice                                                            | 0          | 1          |
| WARNING:at_net/sched/sch_api.c:#qdisc_hash_del                                  | 0          | 1          |
| RIP:qdisc_hash_del                                                              | 0          | 1          |
| WARNING:at_net/ipv4/igmp.c:#ip_mc_destroy_dev                                   | 0          | 1          |
| RIP:ip_mc_destroy_dev                                                           | 0          | 1          |
| WARNING:at_net/wireless/core.c:#__cfg80211_unregister_wdev[cfg80211]            | 0          | 1          |
| RIP:__cfg80211_unregister_wdev[cfg80211]                                        | 0          | 1          |
| WARNING:at_net/core/dev.c:#netdev_has_any_upper_dev                             | 0          | 1          |
| RIP:netdev_has_any_upper_dev                                                    | 0          | 1          |
| WARNING:at_net/core/dev.c:#rollback_registered_many                             | 0          | 2          |
| RIP:rollback_registered_many                                                    | 0          | 2          |
| WARNING:at_net/core/dev.c:#__dev_close_many                                     | 0          | 2          |
| RIP:__dev_close_many                                                            | 0          | 2          |
| BUG:soft_lockup-CPU##stuck_for#s                                                | 0          | 1          |
| RIP:find_next_bit                                                               | 0          | 1          |
| Kernel_panic-not_syncing:softlockup:hung_tasks                                  | 0          | 1          |
+---------------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


[  186.333346] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  186.336318] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  186.339612] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[  186.343633] cfg80211: failed to load regulatory.db
[  186.359277] ------------[ cut here ]------------
[  186.361527] RTNL: assertion failed at net/wireless/reg.c (306)
[  186.364166] WARNING: CPU: 0 PID: 4804 at net/wireless/reg.c:306 reset_regdomains+0xd5/0xe0 [cfg80211]
[  186.367388] Modules linked in: cfg80211 rfkill bochs_drm ttm sr_mod cdrom crct10dif_pclmul drm_kms_helper crc32_pclmul sg crc32c_intel ata_generic pata_acpi ghash_clmulni_intel ppdev syscopyarea sysfillrect sysimgblt fb_sys_fops snd_pcm drm ata_piix aesni_intel snd_timer snd crypto_simd libata cryptd glue_helper soundcore joydev pcspkr serio_raw parport_pc i2c_piix4 floppy parport ip_tables
[  186.378827] CPU: 0 PID: 4804 Comm: crda Not tainted 5.2.0-rc3-01111-gd8572a5 #1
[  186.381529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  186.384383] RIP: 0010:reset_regdomains+0xd5/0xe0 [cfg80211]
[  186.386829] Code: 33 07 09 00 00 0f 85 63 ff ff ff ba 32 01 00 00 48 c7 c6 40 9d 55 c0 48 c7 c7 68 9d 55 c0 c6 05 13 07 09 00 01 e8 eb fa 79 ea <0f> 0b e9 3d ff ff ff 0f 1f 40 00 66 66 66 66 90 48 8b 05 d4 26 08
[  186.392729] RSP: 0018:ffffb103c09bba38 EFLAGS: 00010282
[  186.395104] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  186.397792] RDX: ffff95233fc26d80 RSI: ffff95233fc17778 RDI: ffff95233fc17778
[  186.400389] RBP: ffff95227e894400 R08: 0000000000000459 R09: 0000000000aaaaaa
[  186.403046] R10: 0000000000000000 R11: ffff95227dd39e30 R12: ffff95227e894414
[  186.405696] R13: ffffffffc0556140 R14: 0000000000000000 R15: ffff95227e7ef9c8
[  186.408337] FS:  00007f157ef5cb40(0000) GS:ffff95233fc00000(0000) knlGS:0000000000000000
[  186.411470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.413856] CR2: 00005623bc744028 CR3: 000000008861e000 CR4: 00000000000406f0
[  186.416457] Call Trace:
[  186.418174]  set_regdom+0x2b0/0x430 [cfg80211]
[  186.420255]  nl80211_set_reg+0x290/0x2c0 [cfg80211]
[  186.422395]  genl_family_rcv_msg+0x203/0x400
[  186.424986]  ? __alloc_pages_nodemask+0x157/0x340
[  186.427159]  genl_rcv_msg+0x47/0x90
[  186.429001]  ? __kmalloc_node_track_caller+0x59/0x2a0
[  186.431140]  ? genl_family_rcv_msg+0x400/0x400
[  186.433207]  netlink_rcv_skb+0x4a/0x110
[  186.435092]  genl_rcv+0x24/0x40
[  186.436918]  netlink_unicast+0x193/0x230
[  186.438784]  netlink_sendmsg+0x2c1/0x3c0
[  186.440809]  sock_sendmsg+0x4c/0x50
[  186.442756]  ___sys_sendmsg+0x289/0x300
[  186.444825]  ? mem_cgroup_throttle_swaprate+0x20/0x160
[  186.447196]  ? do_anonymous_page+0x2f3/0x3f0
[  186.449197]  ? __seccomp_filter+0x96/0x6c0
[  186.451348]  ? __sys_sendmsg+0x5e/0xa0
[  186.453442]  __sys_sendmsg+0x5e/0xa0
[  186.455394]  do_syscall_64+0x5b/0x1e0
[  186.457454]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  186.459677] RIP: 0033:0x7f157e463dc7
[  186.461625] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb cd 66 0f 1f 44 00 00 8b 05 4a 49 2b 00 85 c0 75 2e 48 63 ff 48 63 d2 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 a1 f0 2a 00 f7 d8 64 89 02 48
[  186.467465] RSP: 002b:00007ffd7f9d92d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  186.470182] RAX: ffffffffffffffda RBX: 00005623bc756010 RCX: 00007f157e463dc7
[  186.472725] RDX: 0000000000000000 RSI: 00007ffd7f9d9360 RDI: 0000000000000000
[  186.475275] RBP: 00005623bc755ef0 R08: 0000000000000000 R09: 00000000000000f0
[  186.477814] R10: 00000000000000ea R11: 0000000000000246 R12: 00005623bc756060
[  186.480547] R13: 00007ffd7f9d9360 R14: 00005623bc755c20 R15: 0000000000000008
[  186.484264] ---[ end trace 9a39044671a6e95d ]---
[  186.486521] ------------[ cut here ]------------
[  186.488449] RTNL: assertion failed at net/wireless/reg.c (2252)
[  186.491060] WARNING: CPU: 0 PID: 4804 at net/wireless/reg.c:2252 update_all_wiphy_regulatory+0x8a/0x90 [cfg80211]
[  186.495546] Modules linked in: cfg80211 rfkill bochs_drm ttm sr_mod cdrom crct10dif_pclmul drm_kms_helper crc32_pclmul sg crc32c_intel ata_generic pata_acpi ghash_clmulni_intel ppdev syscopyarea sysfillrect sysimgblt fb_sys_fops snd_pcm drm ata_piix aesni_intel snd_timer snd crypto_simd libata cryptd glue_helper soundcore joydev pcspkr serio_raw parport_pc i2c_piix4 floppy parport ip_tables
[  186.506468] CPU: 0 PID: 4804 Comm: crda Tainted: G        W         5.2.0-rc3-01111-gd8572a5 #1
[  186.509258] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  186.512042] RIP: 0010:update_all_wiphy_regulatory+0x8a/0x90 [cfg80211]
[  186.514585] Code: 7b ea 80 3d d5 e3 08 00 00 75 a7 ba cc 08 00 00 48 c7 c6 40 9d 55 c0 48 c7 c7 68 9d 55 c0 c6 05 b9 e3 08 00 01 e8 96 d7 79 ea <0f> 0b eb 84 66 90 66 66 66 66 90 41 55 41 54 55 53 48 89 fb 8b 6f
[  186.520426] RSP: 0018:ffffb103c09bba38 EFLAGS: 00010282
[  186.522651] RAX: 0000000000000000 RBX: ffff95227e894400 RCX: 0000000000000000
[  186.525202] RDX: ffff95233fc26d80 RSI: ffff95233fc17778 RDI: ffff95233fc17778
[  186.527808] RBP: 0000000000000000 R08: 0000000000000488 R09: 0000000000aaaaaa
[  186.530318] R10: 0000000000000000 R11: ffff95227dd38b70 R12: 0000000000000000
[  186.533247] R13: ffffffffc0556140 R14: 0000000000000000 R15: ffff95227e7ef9c8
[  186.535818] FS:  00007f157ef5cb40(0000) GS:ffff95233fc00000(0000) knlGS:0000000000000000
[  186.538591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.540959] CR2: 00005623bc744028 CR3: 000000008861e000 CR4: 00000000000406f0
[  186.543642] Call Trace:
[  186.545460]  set_regdom+0x149/0x430 [cfg80211]
[  186.547596]  nl80211_set_reg+0x290/0x2c0 [cfg80211]
[  186.549758]  genl_family_rcv_msg+0x203/0x400
[  186.551913]  ? __alloc_pages_nodemask+0x157/0x340
[  186.554053]  genl_rcv_msg+0x47/0x90
[  186.556085]  ? __kmalloc_node_track_caller+0x59/0x2a0
[  186.558417]  ? genl_family_rcv_msg+0x400/0x400
[  186.560609]  netlink_rcv_skb+0x4a/0x110
[  186.562710]  genl_rcv+0x24/0x40
[  186.564712]  netlink_unicast+0x193/0x230
[  186.566835]  netlink_sendmsg+0x2c1/0x3c0
[  186.568847]  sock_sendmsg+0x4c/0x50
[  186.570935]  ___sys_sendmsg+0x289/0x300
[  186.572994]  ? mem_cgroup_throttle_swaprate+0x20/0x160
[  186.575196]  ? do_anonymous_page+0x2f3/0x3f0
[  186.577419]  ? __seccomp_filter+0x96/0x6c0
[  186.579439]  ? __sys_sendmsg+0x5e/0xa0
[  186.581528]  __sys_sendmsg+0x5e/0xa0
[  186.583526]  do_syscall_64+0x5b/0x1e0
[  186.585418]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  186.587625] RIP: 0033:0x7f157e463dc7
[  186.589610] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb cd 66 0f 1f 44 00 00 8b 05 4a 49 2b 00 85 c0 75 2e 48 63 ff 48 63 d2 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 a1 f0 2a 00 f7 d8 64 89 02 48
[  186.595368] RSP: 002b:00007ffd7f9d92d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  186.598376] RAX: ffffffffffffffda RBX: 00005623bc756010 RCX: 00007f157e463dc7
[  186.601001] RDX: 0000000000000000 RSI: 00007ffd7f9d9360 RDI: 0000000000000000
[  186.603656] RBP: 00005623bc755ef0 R08: 0000000000000000 R09: 00000000000000f0
[  186.606129] R10: 00000000000000ea R11: 0000000000000246 R12: 00005623bc756060
[  186.608590] R13: 00007ffd7f9d9360 R14: 00005623bc755c20 R15: 0000000000000008
[  186.614598] ---[ end trace 9a39044671a6e95e ]---
[  186.749954] mac80211_hwsim: initializing netlink
[  186.777079] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'


To reproduce:

        # build kernel
	cd linux
	cp config-5.2.0-rc3-01111-gd8572a5 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Rong Chen


--6FinHCQBQ0zFDOqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.2.0-rc3-01111-gd8572a5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-9) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS_PROC is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_ARCH_HAS_HMM_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
# CONFIG_TEST_VMALLOC is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--6FinHCQBQ0zFDOqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hwsim'
	export testcase='hwsim'
	export category='functional'
	export need_memory='1G'
	export job_origin='/lkp/lkp/.src-20190624-160221/allot/cyclic:vm-p1:linux-devel:devel-hourly/vm-snb-4G/hwsim.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-4G-719'
	export tbox_group='vm-snb-4G'
	export submit_id='5d136d98c383310fe6b71b41'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-719/hwsim-hwsim-13-debian-x86_64-2018-04-03.cgz-d8572a564d8aa17cb726a2ae-20190626-4070-1418vh2-2.yaml'
	export id='7642bc1487a45b3b27a509c36b48c73362941229'
	export queuer_version='/lkp/lkp/src'
	export arch='x86_64'
	export need_kconfig='CONFIG_WLAN=y
CONFIG_CFG80211=m
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HWSIM=m
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_KVM_GUEST=y'
	export commit='d8572a564d8aa17cb726a2aed04d0bbe52403249'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-06-26 21:05:30 +0800'
	export _id='5d136d9ac383310fe6b71b42'
	export _rt='/result/hwsim/hwsim-13/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d8572a564d8aa17cb726a2aed04d0bbe52403249'
	export user='lkp'
	export head_commit='eb8f5ce7ad7d39f2464ee65f1654fe2f853c8b76'
	export base_commit='4b972a01a7da614b4796475f933094751a295a2f'
	export branch='linux-devel/devel-hourly-2019062500'
	export result_root='/result/hwsim/hwsim-13/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d8572a564d8aa17cb726a2aed04d0bbe52403249/3'
	export scheduler_version='/lkp/lkp/.src-20190626-173845'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-719/hwsim-hwsim-13-debian-x86_64-2018-04-03.cgz-d8572a564d8aa17cb726a2ae-20190626-4070-1418vh2-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019062500
commit=d8572a564d8aa17cb726a2aed04d0bbe52403249
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/d8572a564d8aa17cb726a2aed04d0bbe52403249/vmlinuz-5.2.0-rc3-01111-gd8572a5
max_uptime=3600
RESULT_ROOT=/result/hwsim/hwsim-13/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/d8572a564d8aa17cb726a2aed04d0bbe52403249/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/d8572a564d8aa17cb726a2aed04d0bbe52403249/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-06-26.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hwsim_2019-06-26.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/hwsim-x86_64-6749c6756_2019-06-26.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export queue_at_least_once=1
	export vm_tbox_group='vm-snb-4G'
	export nr_vm=76
	export vm_base_id=701
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/d8572a564d8aa17cb726a2aed04d0bbe52403249/vmlinuz-5.2.0-rc3-01111-gd8572a5'
	export dequeue_time='2019-06-27 05:23:51 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-719/hwsim-hwsim-13-debian-x86_64-2018-04-03.cgz-d8572a564d8aa17cb726a2ae-20190626-4070-1418vh2-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='hwsim-13' $LKP_SRC/tests/wrapper hwsim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper hwsim
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time hwsim.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--6FinHCQBQ0zFDOqT
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
WVo=

--6FinHCQBQ0zFDOqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hwsim
Content-Transfer-Encoding: quoted-printable

2019-06-27 05:24:32 export USER=3Droot
2019-06-27 05:24:32 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2019-06-27 05:27:04 ./start.sh
2019-06-27 05:27:08 	./run-tests.py sae_anti_clogging_proto=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_anti_clogging_proto 1/1
Test: SAE anti clogging protocol testing
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_anti_clogging_proto 1.34419 2019-06-27 05:27:11.886975
passed all 1 test case(s)
2019-06-27 05:27:11 	./run-tests.py sae_bignum_failure=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_bignum_failure 1/1
Test: SAE and bignum failure
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_bignum_failure 3.971643 2019-06-27 05:27:16.224123
passed all 1 test case(s)
2019-06-27 05:27:16 	./run-tests.py sae_bignum_failure_unsafe_group=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_bignum_failure_unsafe_group 1/1
Test: SAE and bignum failure unsafe group
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_bignum_failure_unsafe_group 0.521206 2019-06-27 05:27:17.191284
passed all 1 test case(s)
2019-06-27 05:27:17 	./run-tests.py sae_commit_invalid_element_ap=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_invalid_element_ap 1/1
Test: SAE commit invalid element from AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_invalid_element_ap 1.373771 2019-06-27 05:27:19.068131
passed all 1 test case(s)
2019-06-27 05:27:19 	./run-tests.py sae_commit_invalid_element_sta=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_invalid_element_sta 1/1
Test: SAE commit invalid element from STA
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_invalid_element_sta 1.425777 2019-06-27 05:27:20.937635
passed all 1 test case(s)
2019-06-27 05:27:20 	./run-tests.py sae_commit_invalid_scalar_element_ap=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_invalid_scalar_element_ap 1/1
Test: SAE commit invalid scalar/element from AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_invalid_scalar_element_ap 1.359774 2019-06-27 05:27:22.6783=
56
passed all 1 test case(s)
2019-06-27 05:27:22 	./run-tests.py sae_commit_invalid_scalar_element_sta=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_invalid_scalar_element_sta 1/1
Test: SAE commit invalid scalar/element from STA
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_invalid_scalar_element_sta 1.400208 2019-06-27 05:27:24.511=
208
passed all 1 test case(s)
2019-06-27 05:27:24 	./run-tests.py sae_commit_override=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_override 1/1
Test: SAE commit override (hostapd)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_override 1.491748 2019-06-27 05:27:26.568047
passed all 1 test case(s)
2019-06-27 05:27:26 	./run-tests.py sae_commit_override2=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_override2 1/1
Test: SAE commit override (wpa_supplicant)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_override2 1.460371 2019-06-27 05:27:28.573915
passed all 1 test case(s)
2019-06-27 05:27:28 	./run-tests.py sae_connect_cmd=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_connect_cmd 1/1
Test: SAE with connect command
Starting AP wlan3
Connect STA wlan5 to AP
PASS sae_connect_cmd 6.624683 2019-06-27 05:27:35.612110
passed all 1 test case(s)
2019-06-27 05:27:35 	./run-tests.py sae_forced_anti_clogging=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_forced_anti_clogging 1/1
Test: SAE anti clogging (forced)
Starting AP wlan3
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS sae_forced_anti_clogging 1.401065 2019-06-27 05:27:37.405081
passed all 1 test case(s)
2019-06-27 05:27:37 	./run-tests.py sae_forced_anti_clogging_pw_id=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_forced_anti_clogging_pw_id 1/1
Test: SAE anti clogging (forced and Password Identifier)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS sae_forced_anti_clogging_pw_id 0.954854 2019-06-27 05:27:38.899736
passed all 1 test case(s)
2019-06-27 05:27:38 	./run-tests.py sae_group_nego=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_group_nego 1/1
Test: SAE group negotiation
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_group_nego 0.727627 2019-06-27 05:27:40.007468
passed all 1 test case(s)
2019-06-27 05:27:40 	./run-tests.py sae_group_nego_no_match=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_group_nego_no_match 1/1
Test: SAE group negotiation (no match)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_group_nego_no_match 3.310586 2019-06-27 05:27:43.705528
passed all 1 test case(s)
2019-06-27 05:27:43 	./run-tests.py sae_groups=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_groups 1/1
Test: SAE with all supported groups
Add Brainpool EC groups since OpenSSL is new enough
Starting AP wlan3
Testing SAE group 19
Connect STA wlan0 to AP
Testing SAE group 25
Connect STA wlan0 to AP
Testing SAE group 26
Connect STA wlan0 to AP
Testing SAE group 20
Connect STA wlan0 to AP
Testing SAE group 21
Connect STA wlan0 to AP
Testing SAE group 1
Connect STA wlan0 to AP
Testing SAE group 2
Connect STA wlan0 to AP
Testing SAE group 5
Connect STA wlan0 to AP
Testing SAE group 14
Connect STA wlan0 to AP
Connection with heavy SAE group 14
Testing SAE group 15
Connect STA wlan0 to AP
Connection with heavy SAE group 15
Testing SAE group 16
Connect STA wlan0 to AP
Connection with heavy SAE group 16
Testing SAE group 22
Connect STA wlan0 to AP
Testing SAE group 23
Connect STA wlan0 to AP
Testing SAE group 24
Connect STA wlan0 to AP
Testing SAE group 27
Connect STA wlan0 to AP
Testing SAE group 28
Connect STA wlan0 to AP
Testing SAE group 29
Connect STA wlan0 to AP
Testing SAE group 30
Connect STA wlan0 to AP
PASS sae_groups 7.681196 2019-06-27 05:27:51.779193
passed all 1 test case(s)
2019-06-27 05:27:51 	./run-tests.py sae_invalid_anti_clogging_token_req=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_invalid_anti_clogging_token_req 1/1
Test: SAE and invalid anti-clogging token request
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_invalid_anti_clogging_token_req 1.372067 2019-06-27 05:27:53.557533
passed all 1 test case(s)
2019-06-27 05:27:53 	./run-tests.py sae_key_lifetime_in_memory=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_key_lifetime_in_memory 1/1
Test: SAE and key lifetime in memory
Starting AP wlan3
Connect STA wlan0 to AP
Reading process memory (pid=3D4868)
[heap] 0x55fb83216000-0x55fb83237000 is at 12288-147456
[stack] 0x7ffcb1a88000-0x7ffcb1aaa000 is at 1691648-1830912
Total process memory read: 1830912 bytes
Checking keys in memory while associated
Skip test case: Password not found while associated
SKIP sae_key_lifetime_in_memory 1.83266 2019-06-27 05:27:55.842303
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:27:55 	./run-tests.py sae_mfp=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_mfp 1/1
Test: SAE and MFP enabled without sae_require_mfp
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS sae_mfp 1.084706 2019-06-27 05:27:57.477660
passed all 1 test case(s)
2019-06-27 05:27:57 	./run-tests.py sae_missing_password=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_missing_password 1/1
Test: SAE and missing password
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_missing_password 0.355002 2019-06-27 05:27:58.289465
passed all 1 test case(s)
2019-06-27 05:27:58 	./run-tests.py sae_mixed=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_mixed 1/1
Test: Mixed SAE and non-SAE network
Starting AP wlan3
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS sae_mixed 1.174034 2019-06-27 05:27:59.843598
passed all 1 test case(s)
2019-06-27 05:27:59 	./run-tests.py sae_mixed_mfp=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_mixed_mfp 1/1
Test: Mixed SAE and non-SAE network and MFP required with SAE
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS sae_mixed_mfp 1.371203 2019-06-27 05:28:01.590546
passed all 1 test case(s)
2019-06-27 05:28:01 	./run-tests.py sae_no_ffc_by_default=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_no_ffc_by_default 1/1
Test: SAE and default groups rejecting FFC
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_no_ffc_by_default 0.948452 2019-06-27 05:28:03.050143
passed all 1 test case(s)
2019-06-27 05:28:03 	./run-tests.py sae_no_random=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_no_random 1/1
Test: SAE and no random numbers available
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_no_random 1.064144 2019-06-27 05:28:04.556404
passed all 1 test case(s)
2019-06-27 05:28:04 	./run-tests.py sae_oom_wpas=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_oom_wpas 1/1
Test: SAE and OOM in wpa_supplicant
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_oom_wpas 1.943588 2019-06-27 05:28:07.060308
passed all 1 test case(s)
2019-06-27 05:28:07 	./run-tests.py sae_password=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password 1/1
Test: SAE and sae_password in hostapd configuration
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS sae_password 1.340607 2019-06-27 05:28:08.808553
passed all 1 test case(s)
2019-06-27 05:28:08 	./run-tests.py sae_password_ecc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_ecc 1/1
Test: SAE with number of different passwords (ECC)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_password_ecc 3.966445 2019-06-27 05:28:13.219364
passed all 1 test case(s)
2019-06-27 05:28:13 	./run-tests.py sae_password_ffc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_ffc 1/1
Test: SAE with number of different passwords (FFC)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_password_ffc 6.39828 2019-06-27 05:28:20.076449
passed all 1 test case(s)
2019-06-27 05:28:20 	./run-tests.py sae_password_id=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_id 1/1
Test: SAE and password identifier
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_password_id 1.344542 2019-06-27 05:28:22.285355
passed all 1 test case(s)
2019-06-27 05:28:22 	./run-tests.py sae_password_id_ecc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_id_ecc 1/1
Test: SAE and password identifier (ECC)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_password_id_ecc 1.14588 2019-06-27 05:28:24.055466
passed all 1 test case(s)
2019-06-27 05:28:24 	./run-tests.py sae_password_id_ffc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_id_ffc 1/1
Test: SAE and password identifier (FFC)
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_password_id_ffc 1.817408 2019-06-27 05:28:26.352353
passed all 1 test case(s)
2019-06-27 05:28:26 	./run-tests.py sae_password_id_only=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_id_only 1/1
Test: SAE and password identifier (exclusively)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_password_id_only 0.825436 2019-06-27 05:28:27.818176
passed all 1 test case(s)
2019-06-27 05:28:27 	./run-tests.py sae_password_long=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_long 1/1
Test: SAE and long password
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_password_long 0.94327 2019-06-27 05:28:29.232780
passed all 1 test case(s)
2019-06-27 05:28:29 	./run-tests.py sae_password_short=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_password_short 1/1
Test: SAE and short password
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_password_short 1.02158 2019-06-27 05:28:30.887157
passed all 1 test case(s)
2019-06-27 05:28:30 	./run-tests.py sae_pmksa_caching=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pmksa_caching 1/1
Test: SAE and PMKSA caching
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_pmksa_caching 1.222709 2019-06-27 05:28:32.571587
passed all 1 test case(s)
2019-06-27 05:28:32 	./run-tests.py sae_pmksa_caching_disabled=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pmksa_caching_disabled 1/1
Test: SAE and PMKSA caching disabled
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_pmksa_caching_disabled 1.164466 2019-06-27 05:28:34.408109
passed all 1 test case(s)
2019-06-27 05:28:34 	./run-tests.py sae_proto_confirm_replay=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_proto_confirm_replay 1/1
Test: SAE protocol testing - Confirm replay
Starting AP wlan3
Connect STA wlan0 to AP
Commit
Confirm
Replay Confirm
Association Request
PASS sae_proto_confirm_replay 0.828357 2019-06-27 05:28:35.754055
passed all 1 test case(s)
2019-06-27 05:28:35 	./run-tests.py sae_proto_ecc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_proto_ecc 1/1
Test: SAE protocol testing (ECC)
Starting AP wlan3
Confirm mismatch
Connect STA wlan0 to AP
Commit
Confirm
Commit without even full cyclic group field
Connect STA wlan0 to AP
Commit
Too short commit
Connect STA wlan0 to AP
Commit
Invalid commit scalar (0)
Connect STA wlan0 to AP
Commit
Invalid commit scalar (1)
Connect STA wlan0 to AP
Commit
Invalid commit scalar (> r)
Connect STA wlan0 to AP
Commit
Commit element not on curve
Connect STA wlan0 to AP
Commit
Invalid commit element (y coordinate > P)
Connect STA wlan0 to AP
Commit
Invalid commit element (x coordinate > P)
Connect STA wlan0 to AP
Commit
Different group in commit
Connect STA wlan0 to AP
Commit
Too short confirm
Connect STA wlan0 to AP
Commit
Confirm
PASS sae_proto_ecc 2.215201 2019-06-27 05:28:38.529091
passed all 1 test case(s)
2019-06-27 05:28:38 	./run-tests.py sae_proto_ffc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_proto_ffc 1/1
Test: SAE protocol testing (FFC)
Starting AP wlan3
Confirm mismatch
Connect STA wlan0 to AP
Commit
Confirm
Too short commit
Connect STA wlan0 to AP
Commit
Invalid element (0) in commit
Connect STA wlan0 to AP
Commit
Invalid element (1) in commit
Connect STA wlan0 to AP
Commit
Invalid element (> P) in commit
Connect STA wlan0 to AP
Commit
PASS sae_proto_ffc 1.142693 2019-06-27 05:28:40.110502
passed all 1 test case(s)
2019-06-27 05:28:40 	./run-tests.py sae_proto_hostapd=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_proto_hostapd 1/1
Test: SAE protocol testing with hostapd
Starting AP wlan3
PASS sae_proto_hostapd 0.315671 2019-06-27 05:28:40.850070
passed all 1 test case(s)
2019-06-27 05:28:40 	./run-tests.py sae_proto_hostapd_ecc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_proto_hostapd_ecc 1/1
Test: SAE protocol testing with hostapd (ECC)
Starting AP wlan3
PASS sae_proto_hostapd_ecc 0.387274 2019-06-27 05:28:41.686439
passed all 1 test case(s)
2019-06-27 05:28:41 	./run-tests.py sae_proto_hostapd_ffc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_proto_hostapd_ffc 1/1
Test: SAE protocol testing with hostapd (FFC)
Starting AP wlan3
PASS sae_proto_hostapd_ffc 0.39337 2019-06-27 05:28:42.483085
passed all 1 test case(s)
2019-06-27 05:28:42 	./run-tests.py sae_pwe_failure=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pwe_failure 1/1
Test: SAE and pwe failure
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_pwe_failure 2.80674 2019-06-27 05:28:45.775701
passed all 1 test case(s)
2019-06-27 05:28:45 	./run-tests.py sae_reauth=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_reauth 1/1
Test: SAE reauthentication
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_reauth 1.87722 2019-06-27 05:28:48.076625
passed all 1 test case(s)
2019-06-27 05:28:48 	./run-tests.py sae_reflection_attack_ecc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_reflection_attack_ecc 1/1
Test: SAE reflection attack (ECC)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_reflection_attack_ecc 0.909924 2019-06-27 05:28:49.390866
passed all 1 test case(s)
2019-06-27 05:28:49 	./run-tests.py sae_reflection_attack_ecc_internal=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_reflection_attack_ecc_internal 1/1
Test: SAE reflection attack (ECC) - internal
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_reflection_attack_ecc_internal 1.350354 2019-06-27 05:28:51.140339
passed all 1 test case(s)
2019-06-27 05:28:51 	./run-tests.py sae_reflection_attack_ffc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_reflection_attack_ffc 1/1
Test: SAE reflection attack (FFC)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_reflection_attack_ffc 0.906177 2019-06-27 05:28:52.447894
passed all 1 test case(s)
2019-06-27 05:28:52 	./run-tests.py sae_reflection_attack_ffc_internal=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_reflection_attack_ffc_internal 1/1
Test: SAE reflection attack (FFC) - internal
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_reflection_attack_ffc_internal 1.385316 2019-06-27 05:28:54.217406
passed all 1 test case(s)
2019-06-27 05:28:54 	./run-tests.py scan=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan 1/1
Test: Control interface behavior on scan parameters
Starting AP wlan3
Full scan
Limited channel scan
Passive single-channel scan
Active single-channel scan
Active single-channel scan on AP's operating channel
PASS scan 8.249903 2019-06-27 05:29:02.902431
passed all 1 test case(s)
2019-06-27 05:29:03 	./run-tests.py scan_abort=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_abort 1/1
Test: Aborting a full scan
PASS scan_abort 0.135258 2019-06-27 05:29:03.481785
passed all 1 test case(s)
2019-06-27 05:29:03 	./run-tests.py scan_abort_on_connect=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_abort_on_connect 1/1
Test: Aborting a full scan on connection request
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_abort_on_connect 0.601185 2019-06-27 05:29:04.470177
passed all 1 test case(s)
2019-06-27 05:29:04 	./run-tests.py scan_and_bss_entry_removed=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_and_bss_entry_removed 1/1
Test: Last scan result and connect work processing on BSS entry update
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS scan_and_bss_entry_removed 4.456229 2019-06-27 05:29:09.359265
passed all 1 test case(s)
2019-06-27 05:29:09 	./run-tests.py scan_and_interface_disabled=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_and_interface_disabled 1/1
Test: Scan operation when interface gets disabled
PASS scan_and_interface_disabled 7.356707 2019-06-27 05:29:17.300817
passed all 1 test case(s)
2019-06-27 05:29:17 	./run-tests.py scan_ap_scan_2_ap_mode=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_ap_scan_2_ap_mode 1/1
Test: AP_SCAN 2 AP mode and scan()
Connect STA wlan1 to AP
PASS scan_ap_scan_2_ap_mode 1.323393 2019-06-27 05:29:19.284906
passed all 1 test case(s)
2019-06-27 05:29:19 	./run-tests.py scan_bss_expiration_age=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_expiration_age 1/1
Test: BSS entry expiration based on age
Starting AP wlan3
Waiting for BSS entry to expire
PASS scan_bss_expiration_age 15.799777 2019-06-27 05:29:35.901782
passed all 1 test case(s)
2019-06-27 05:29:36 	./run-tests.py scan_bss_expiration_count=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_expiration_count 1/1
Test: BSS entry expiration based on scan results without match
Starting AP wlan3
PASS scan_bss_expiration_count 0.5154 2019-06-27 05:29:36.953339
passed all 1 test case(s)
2019-06-27 05:29:37 	./run-tests.py scan_bss_expiration_on_ssid_change=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_expiration_on_ssid_change 1/1
Test: BSS entry expiration when AP changes SSID
Starting AP wlan3
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_bss_expiration_on_ssid_change 1.47884 2019-06-27 05:29:38.896494
passed all 1 test case(s)
2019-06-27 05:29:38 	./run-tests.py scan_bss_limit=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_limit 1/1
Test: Scan and wpa_supplicant BSS entry limit
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS scan_bss_limit 0.822228 2019-06-27 05:29:40.099586
passed all 1 test case(s)
2019-06-27 05:29:40 	./run-tests.py scan_bss_operations=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_operations 1/1
Test: Control interface behavior on BSS parameters
Starting AP wlan3
Starting AP wlan4
PASS scan_bss_operations 0.7167 2019-06-27 05:29:41.225906
passed all 1 test case(s)
2019-06-27 05:29:41 	./run-tests.py scan_chan_switch=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_chan_switch 1/1
Test: Scanning and AP changing channels
Starting AP wlan3
AP channel switch while not connected
AP channel switch while connected
Connect STA wlan0 to AP
PASS scan_chan_switch 2.993737 2019-06-27 05:29:44.628915
passed all 1 test case(s)
2019-06-27 05:29:44 	./run-tests.py scan_dfs=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_dfs 1/1
Test: Scan on DFS channels
Active scan seen on channels: [2412, 2417, 2422, 2427, 2432, 2437, 2442, 24=
47, 2452, 2457, 2462, 5180, 5200, 5220, 5240, 5745, 5765, 5785, 5805, 5825]
PASS scan_dfs 4.716916 2019-06-27 05:29:49.719985
passed all 1 test case(s)
2019-06-27 05:29:49 	./run-tests.py scan_ext=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_ext 1/1
Test: Custom IE in Probe Request frame
Starting AP wlan3
PASS scan_ext 0.452128 2019-06-27 05:29:50.672705
passed all 1 test case(s)
2019-06-27 05:29:50 	./run-tests.py scan_external_trigger=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_external_trigger 1/1
Test: Avoid operations during externally triggered scan
Starting AP wlan3
PASS scan_external_trigger 8.228326 2019-06-27 05:29:59.308402
passed all 1 test case(s)
2019-06-27 05:29:59 	./run-tests.py scan_fail=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_fail 1/1
Test: Scan failures
Connect STA wlan0 to AP
Starting AP wlan3
PASS scan_fail 0.690821 2019-06-27 05:30:00.419327
passed all 1 test case(s)
2019-06-27 05:30:00 	./run-tests.py scan_fail_type_only=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_fail_type_only 1/1
Test: Scan failures for TYPE=3DONLY
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_fail_type_only 0.482398 2019-06-27 05:30:01.319228
passed all 1 test case(s)
2019-06-27 05:30:01 	./run-tests.py scan_filter=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_filter 1/1
Test: Filter scan results based on SSID
Connect STA wlan0 to AP
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS scan_filter 0.553617 2019-06-27 05:30:02.214057
passed all 1 test case(s)
2019-06-27 05:30:02 	./run-tests.py scan_flush=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_flush 1/1
Test: Ongoing scan and FLUSH
Starting AP wlan3
PASS scan_flush 0.456314 2019-06-27 05:30:03.069673
passed all 1 test case(s)
2019-06-27 05:30:03 	./run-tests.py scan_for_auth=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_for_auth 1/1
Test: cfg80211 workaround with scan-for-auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_for_auth 0.546037 2019-06-27 05:30:03.991692
passed all 1 test case(s)
2019-06-27 05:30:04 	./run-tests.py scan_for_auth_fail=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_for_auth_fail 1/1
Test: cfg80211 workaround with scan-for-auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_for_auth_fail 0.728753 2019-06-27 05:30:05.101844
passed all 1 test case(s)
2019-06-27 05:30:05 	./run-tests.py scan_for_auth_wep=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_for_auth_wep 1/1
Test: cfg80211 scan-for-auth workaround with WEP keys
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_for_auth_wep 0.786197 2019-06-27 05:30:06.282371
passed all 1 test case(s)
2019-06-27 05:30:06 	./run-tests.py scan_freq_list=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_freq_list 1/1
Test: Scan with SET freq_list and scan_cur_freq
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_freq_list 0.769421 2019-06-27 05:30:07.509149
passed all 1 test case(s)
2019-06-27 05:30:07 	./run-tests.py scan_hidden=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_hidden 1/1
Test: Control interface behavior on scan parameters
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS scan_hidden 0.628846 2019-06-27 05:30:08.613942
passed all 1 test case(s)
2019-06-27 05:30:08 	./run-tests.py scan_hidden_many=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_hidden_many 1/1
Test: scan_ssid=3D1 with large number of profile with hidden SSID
Starting AP wlan3
PASS scan_hidden_many 1.775722 2019-06-27 05:30:10.764673
passed all 1 test case(s)
2019-06-27 05:30:10 	./run-tests.py scan_ies=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_ies 1/1
Test: Scan and both Beacon and Probe Response frame IEs
Starting AP wlan3
ie: [0, 1, 50, 3, 127, 221, 42, 59, 45, 61]
beacon_ie: [0, 1, 50, 3, 127, 221, 42, 59, 45, 61]
PASS scan_ies 0.508718 2019-06-27 05:30:11.699515
passed all 1 test case(s)
2019-06-27 05:30:11 	./run-tests.py scan_int=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_int 1/1
Test: scan interval configuration
Connect STA wlan0 to AP
Waiting for scan to start
Waiting for scan to complete
Waiting for scan to start
Waiting for scan to complete
Waiting for scan to start
Waiting for scan to complete
times=3D{0: 0.019999999552965164, 1: 1.0099999997764826, 2: 1.0300000002607=
703}
PASS scan_int 2.244956 2019-06-27 05:30:14.319944
passed all 1 test case(s)
2019-06-27 05:30:14 	./run-tests.py scan_mbssid_hidden_ssid=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_mbssid_hidden_ssid 1/1
Test: Non-transmitting BSS has hidden SSID
bssid: 02:00:00:00:03:00
Starting AP wlan3
AP 02:00:00:00:03:00: {'est_throughput': '65000', 'snr': '59', 'id': '71', =
'flags': '[ESS]', 'tsf': '1561584615117075', 'qual': '0', 'noise': '-89', '=
bssid': '02:00:00:00:03:00', 'capabilities': '0x0401', 'update_idx': '146',=
 'freq': '2412', 'ssid': 'transmitted', 'beacon_ie': '000b7472616e736d69747=
46564010882848b960c1218240301010504000200002a010432043048606c3b0251002d1a0c=
001bffff0000000000000000000001000000000000000000003d16010000000000000000000=
000000000000000000000007f080400400200000040dd180050f2020101010003a4000027a4=
000042435e0062322f004718020009530201000000550101000a53020200000132550102', =
'level': '-30', 'age': '0', 'ie': '000b7472616e736d6974746564010882848b960c=
1218240301012a010432043048606c3b0251002d1a0c001bffff00000000000000000000010=
00000000000000000003d16010000000000000000000000000000000000000000007f080400=
400200000040dd180050f2020101010003a4000027a4000042435e0062322f0047180200095=
30201000000550101000a53020200000132550102', 'beacon_int': '100'}
AP 02:00:00:00:03:01: {'est_throughput': '65000', 'snr': '59', 'id': '72', =
'flags': '[ESS]', 'tsf': '1561584615117075', 'qual': '0', 'noise': '-89', '=
bssid': '02:00:00:00:03:01', 'capabilities': '0x0001', 'update_idx': '146',=
 'freq': '2412', 'ssid': '', 'beacon_ie': '0000010882848b960c12182403010105=
04000200002a010432043048606c3b0251002d1a0c001bffff0000000000000000000001000=
000000000000000003d16010000000000000000000000000000000000000000007f08040040=
0200000040dd180050f2020101010003a4000027a4000042435e0062322f00550101', 'lev=
el': '-30', 'age': '0', 'ie': '0000010882848b960c1218240301012a010432043048=
606c3b0251002d1a0c001bffff0000000000000000000001000000000000000000003d16010=
000000000000000000000000000000000000000007f080400400200000040dd180050f20201=
01010003a4000027a4000042435e0062322f00550101', 'beacon_int': '100'}
AP 02:00:00:00:03:02: {'est_throughput': '65000', 'snr': '59', 'id': '73', =
'flags': '[IBSS]', 'tsf': '1561584615117075', 'qual': '0', 'noise': '-89', =
'bssid': '02:00:00:00:03:02', 'capabilities': '0x0002', 'update_idx': '146'=
, 'freq': '2412', 'ssid': '2', 'beacon_ie': '000132010882848b960c1218240301=
010504000200002a010432043048606c3b0251002d1a0c001bffff000000000000000000000=
1000000000000000000003d16010000000000000000000000000000000000000000007f0804=
00400200000040dd180050f2020101010003a4000027a4000042435e0062322f00550102', =
'level': '-30', 'age': '0', 'ie': '000132010882848b960c1218240301012a010432=
043048606c3b0251002d1a0c001bffff0000000000000000000001000000000000000000003=
d16010000000000000000000000000000000000000000007f080400400200000040dd180050=
f2020101010003a4000027a4000042435e0062322f00550102', 'beacon_int': '100'}
PASS scan_mbssid_hidden_ssid 0.677337 2019-06-27 05:30:15.432295
passed all 1 test case(s)
2019-06-27 05:30:15 	./run-tests.py scan_multi_bssid=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multi_bssid 1/1
Test: Scan and Multiple BSSID element
Starting AP wlan3
Starting AP wlan4
AP 02:00:00:00:03:00: {'beacon_int': '100', 'tsf': '1561584616409380', 'lev=
el': '-30', 'snr': '59', 'capabilities': '0x0401', 'noise': '-89', 'id': '7=
4', 'qual': '0', 'ie': '0009746573742d7363616e010882848b960c1218240301012a0=
10432043048606c3b0251002d1a0c001bffff00000000000000000000010000000000000000=
00003d16010000000000000000000000000000000000000000007f080400400200000040dd1=
80050f2020101010003a4000027a4000042435e0062322f00470100', 'age': '0', 'beac=
on_ie': '0009746573742d7363616e010882848b960c1218240301010504010200002a0104=
32043048606c3b0251002d1a0c001bffff00000000000000000000010000000000000000000=
03d16010000000000000000000000000000000000000000007f080400400200000040dd1800=
50f2020101010003a4000027a4000042435e0062322f00470100', 'update_idx': '149',=
 'bssid': '02:00:00:00:03:00', 'est_throughput': '65000', 'ssid': 'test-sca=
n', 'flags': '[ESS]', 'freq': '2412'}
AP 02:00:00:00:04:00: {'beacon_int': '100', 'tsf': '1561584616409729', 'lev=
el': '-30', 'snr': '59', 'capabilities': '0x0401', 'noise': '-89', 'id': '7=
5', 'qual': '0', 'ie': '0009746573742d7363616e010882848b960c1218240301012a0=
10432043048606c3b0251002d1a0c001bffff00000000000000000000010000000000000000=
00003d16010000000000000000000000000000000000000000007f080400400200000040dd1=
80050f2020101010003a4000027a4000042435e0062322f00470d01000a5302010400013155=
0101', 'age': '0', 'beacon_ie': '0009746573742d7363616e010882848b960c121824=
0301010504010200002a010432043048606c3b0251002d1a0c001bffff00000000000000000=
00001000000000000000000003d16010000000000000000000000000000000000000000007f=
080400400200000040dd180050f2020101010003a4000027a4000042435e0062322f00470d0=
1000a53020104000131550101', 'update_idx': '149', 'bssid': '02:00:00:00:04:0=
0', 'est_throughput': '65000', 'ssid': 'test-scan', 'flags': '[ESS]', 'freq=
': '2412'}
AP 02:00:00:00:04:01: {'beacon_int': '100', 'tsf': '1561584616409729', 'lev=
el': '-30', 'snr': '59', 'capabilities': '0x0401', 'noise': '-89', 'id': '7=
6', 'qual': '0', 'ie': '000131010882848b960c1218240301012a010432043048606c3=
b0251002d1a0c001bffff0000000000000000000001000000000000000000003d1601000000=
0000000000000000000000000000000000007f080400400200000040dd180050f2020101010=
003a4000027a4000042435e0062322f00550101', 'age': '0', 'beacon_ie': '0001310=
10882848b960c1218240301010504010200002a010432043048606c3b0251002d1a0c001bff=
ff0000000000000000000001000000000000000000003d16010000000000000000000000000=
000000000000000007f080400400200000040dd180050f2020101010003a4000027a4000042=
435e0062322f00550101', 'update_idx': '149', 'bssid': '02:00:00:00:04:01', '=
est_throughput': '65000', 'ssid': '1', 'flags': '[ESS]', 'freq': '2412'}
PASS scan_multi_bssid 0.82411 2019-06-27 05:30:16.627771
passed all 1 test case(s)
2019-06-27 05:30:16 	./run-tests.py scan_multi_bssid_2=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multi_bssid_2 1/1
Test: Scan and Multiple BSSID element (2)
Starting AP wlan3
AP 02:00:00:00:03:00: {'freq': '2412', 'est_throughput': '65000', 'qual': '=
0', 'capabilities': '0x0401', 'id': '77', 'ssid': 'transmitted', 'noise': '=
-89', 'snr': '59', 'beacon_int': '100', 'tsf': '1561584617438056', 'ie': '0=
00b7472616e736d6974746564010882848b960c1218240301012a010432043048606c3b0251=
002d1a0c001bffff0000000000000000000001000000000000000000003d160100000000000=
00000000000000000000000000000007f080400400200000040dd180050f2020101010003a4=
000027a4000042435e0062322f00474b04001453020100000b7472616e736d6974746564550=
100001753020100000e6e6f6e7472616e736d697474656455010100195302010000106e6f6e=
7472616e736d69747465645f32550102', 'level': '-30', 'bssid': '02:00:00:00:03=
:00', 'update_idx': '152', 'flags': '[ESS]', 'age': '0'}
AP 02:00:00:00:03:01: {'freq': '2412', 'est_throughput': '65000', 'qual': '=
0', 'capabilities': '0x0001', 'id': '78', 'ssid': 'nontransmitted', 'noise'=
: '-89', 'snr': '59', 'beacon_int': '100', 'tsf': '1561584617438056', 'ie':=
 '000e6e6f6e7472616e736d6974746564010882848b960c1218240301012a0104320430486=
06c3b0251002d1a0c001bffff0000000000000000000001000000000000000000003d160100=
00000000000000000000000000000000000000007f080400400200000040dd180050f202010=
1010003a4000027a4000042435e0062322f00550101', 'level': '-30', 'bssid': '02:=
00:00:00:03:01', 'update_idx': '152', 'flags': '[ESS]', 'age': '0'}
AP 02:00:00:00:03:02: {'freq': '2412', 'est_throughput': '65000', 'qual': '=
0', 'capabilities': '0x0001', 'id': '79', 'ssid': 'nontransmitted_2', 'nois=
e': '-89', 'snr': '59', 'beacon_int': '100', 'tsf': '1561584617438056', 'ie=
': '00106e6f6e7472616e736d69747465645f32010882848b960c1218240301012a0104320=
43048606c3b0251002d1a0c001bffff0000000000000000000001000000000000000000003d=
16010000000000000000000000000000000000000000007f080400400200000040dd180050f=
2020101010003a4000027a4000042435e0062322f00550102', 'level': '-30', 'bssid'=
: '02:00:00:00:03:02', 'update_idx': '152', 'flags': '[ESS]', 'age': '0'}
PASS scan_multi_bssid_2 0.53558 2019-06-27 05:30:17.657765
passed all 1 test case(s)
2019-06-27 05:30:17 	./run-tests.py scan_multi_bssid_3=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multi_bssid_3 1/1
Test: Scan and Multiple BSSID element (3)
Starting AP wlan3
AP 02:00:00:00:03:00: {'tsf': '1561584618346561', 'level': '-30', 'snr': '5=
9', 'beacon_ie': '000b7472616e736d6974746564010882848b960c12182403010105040=
00200002a010432043048606c3b0251002d1a0c001bffff0000000000000000000001000000=
000000000000003d16010000000000000000000000000000000000000000007f08040040020=
0000040dd180050f2020101010003a4000027a4000042435e0062322f004733020017530201=
00000e6e6f6e7472616e736d6974746564550101001753020100000e6e6f6e7472616e736d6=
974746564550101', 'bssid': '02:00:00:00:03:00', 'update_idx': '155', 'age':=
 '0', 'freq': '2412', 'ie': '000b7472616e736d6974746564010882848b960c121824=
0301012a010432043048606c3b0251002d1a0c001bffff00000000000000000000010000000=
00000000000003d16010000000000000000000000000000000000000000007f080400400200=
000040dd180050f2020101010003a4000027a4000042435e0062322f0047330200175302010=
0000e6e6f6e7472616e736d6974746564550101001753020100000e6e6f6e7472616e736d69=
74746564550101', 'id': '80', 'capabilities': '0x0401', 'noise': '-89', 'ssi=
d': 'transmitted', 'flags': '[ESS]', 'qual': '0', 'est_throughput': '65000'=
, 'beacon_int': '100'}
AP 02:00:00:00:03:01: {'tsf': '1561584618346561', 'level': '-30', 'snr': '5=
9', 'beacon_ie': '000e6e6f6e7472616e736d6974746564010882848b960c12182403010=
10504000200002a010432043048606c3b0251002d1a0c001bffff0000000000000000000001=
000000000000000000003d16010000000000000000000000000000000000000000007f08040=
0400200000040dd180050f2020101010003a4000027a4000042435e0062322f00550101', '=
bssid': '02:00:00:00:03:01', 'update_idx': '155', 'age': '0', 'freq': '2412=
', 'ie': '000e6e6f6e7472616e736d6974746564010882848b960c1218240301012a01043=
2043048606c3b0251002d1a0c001bffff000000000000000000000100000000000000000000=
3d16010000000000000000000000000000000000000000007f080400400200000040dd18005=
0f2020101010003a4000027a4000042435e0062322f00550101', 'id': '81', 'capabili=
ties': '0x0001', 'noise': '-89', 'ssid': 'nontransmitted', 'flags': '[ESS]'=
, 'qual': '0', 'est_throughput': '65000', 'beacon_int': '100'}
PASS scan_multi_bssid_3 0.460962 2019-06-27 05:30:18.498173
passed all 1 test case(s)
2019-06-27 05:30:18 	./run-tests.py scan_multi_bssid_4=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multi_bssid_4 1/1
Test: Scan and Multiple BSSID element (3)
Starting AP wlan3
AP 02:00:00:00:03:01: {'est_throughput': '65000', 'ssid': 'transmitted', 'b=
ssid': '02:00:00:00:03:01', 'tsf': '1561584619213023', 'flags': '[ESS]', 'a=
ge': '0', 'id': '82', 'beacon_int': '100', 'capabilities': '0x0401', 'qual'=
: '0', 'beacon_ie': '000b7472616e736d6974746564010882848b960c12182403010105=
04000200002a010432043048606c3b0251002d1a0c001bffff0000000000000000000001000=
000000000000000003d16010000000000000000000000000000000000000000007f08040040=
0200000040dd180050f2020101010003a4000027a4000042435e0062322f00472502000a530=
20100000131550101000a53020100000132550102000a53020100000133550103', 'noise'=
: '-89', 'freq': '2412', 'ie': '000b7472616e736d6974746564010882848b960c121=
8240301012a010432043048606c3b0251002d1a0c001bffff00000000000000000000010000=
00000000000000003d16010000000000000000000000000000000000000000007f080400400=
200000040dd180050f2020101010003a4000027a4000042435e0062322f00472502000a5302=
0100000131550101000a53020100000132550102000a53020100000133550103', 'update_=
idx': '158', 'level': '-30', 'snr': '59'}
AP 02:00:00:00:03:02: {'est_throughput': '65000', 'ssid': '1', 'bssid': '02=
:00:00:00:03:02', 'tsf': '1561584619213023', 'flags': '[ESS]', 'age': '0', =
'id': '83', 'beacon_int': '100', 'capabilities': '0x0001', 'qual': '0', 'be=
acon_ie': '000131010882848b960c1218240301010504000200002a010432043048606c3b=
0251002d1a0c001bffff0000000000000000000001000000000000000000003d16010000000=
000000000000000000000000000000000007f080400400200000040dd180050f20201010100=
03a4000027a4000042435e0062322f00550101', 'noise': '-89', 'freq': '2412', 'i=
e': '000131010882848b960c1218240301012a010432043048606c3b0251002d1a0c001bff=
ff0000000000000000000001000000000000000000003d16010000000000000000000000000=
000000000000000007f080400400200000040dd180050f2020101010003a4000027a4000042=
435e0062322f00550101', 'update_idx': '158', 'level': '-30', 'snr': '59'}
AP 02:00:00:00:03:03: {'est_throughput': '65000', 'ssid': '2', 'bssid': '02=
:00:00:00:03:03', 'tsf': '1561584619213023', 'flags': '[ESS]', 'age': '0', =
'id': '84', 'beacon_int': '100', 'capabilities': '0x0001', 'qual': '0', 'be=
acon_ie': '000132010882848b960c1218240301010504000200002a010432043048606c3b=
0251002d1a0c001bffff0000000000000000000001000000000000000000003d16010000000=
000000000000000000000000000000000007f080400400200000040dd180050f20201010100=
03a4000027a4000042435e0062322f00550102', 'noise': '-89', 'freq': '2412', 'i=
e': '000132010882848b960c1218240301012a010432043048606c3b0251002d1a0c001bff=
ff0000000000000000000001000000000000000000003d16010000000000000000000000000=
000000000000000007f080400400200000040dd180050f2020101010003a4000027a4000042=
435e0062322f00550102', 'update_idx': '158', 'level': '-30', 'snr': '59'}
AP 02:00:00:00:03:00: {'est_throughput': '65000', 'ssid': '3', 'bssid': '02=
:00:00:00:03:00', 'tsf': '1561584619213023', 'flags': '[ESS]', 'age': '0', =
'id': '85', 'beacon_int': '100', 'capabilities': '0x0001', 'qual': '0', 'be=
acon_ie': '000133010882848b960c1218240301010504000200002a010432043048606c3b=
0251002d1a0c001bffff0000000000000000000001000000000000000000003d16010000000=
000000000000000000000000000000000007f080400400200000040dd180050f20201010100=
03a4000027a4000042435e0062322f00550103', 'noise': '-89', 'freq': '2412', 'i=
e': '000133010882848b960c1218240301012a010432043048606c3b0251002d1a0c001bff=
ff0000000000000000000001000000000000000000003d16010000000000000000000000000=
000000000000000007f080400400200000040dd180050f2020101010003a4000027a4000042=
435e0062322f00550103', 'update_idx': '158', 'level': '-30', 'snr': '59'}
PASS scan_multi_bssid_4 0.798514 2019-06-27 05:30:19.675954
passed all 1 test case(s)
2019-06-27 05:30:19 	./run-tests.py scan_multi_bssid_check_ie=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multi_bssid_check_ie 1/1
Test: Scan and check if nontransmitting BSS inherits IE from transmitting B=
SS
Starting AP wlan3
trans_bss beacon_ie: [0, 1, 3, 5, 71, 42, 45, 61, 50, 59, 221, 127]
nontrans_bss1 beacon_ie: [0, 1, 3, 5, 42, 45, 61, 50, 85, 59, 221, 127]
PASS scan_multi_bssid_check_ie 0.699913 2019-06-27 05:30:20.771531
passed all 1 test case(s)
2019-06-27 05:30:20 	./run-tests.py scan_multi_bssid_fms=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multi_bssid_fms 1/1
Test: Non-transmitting BSS has different FMS IE from transmitting BSS
Starting AP wlan3
trans_bss fms ie: 013901
nontrans_bss fms ie: 0229320102
PASS scan_multi_bssid_fms 0.793552 2019-06-27 05:30:21.960709
passed all 1 test case(s)
2019-06-27 05:30:22 	./run-tests.py scan_multiple_mbssid_ie=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_multiple_mbssid_ie 1/1
Test: Transmitting BSS has 2 MBSSID IE
bssid: 02:00:00:00:03:00
Starting AP wlan3
AP 02:00:00:00:03:00: {'est_throughput': '65000', 'qual': '0', 'tsf': '1561=
584622597709', 'capabilities': '0x0401', 'ssid': 'transmitted', 'ie': '000b=
7472616e736d6974746564010882848b960c1218240301012a010432043048606c3b0251002=
d1a0c001bffff0000000000000000000001000000000000000000003d160100000000000000=
00000000000000000000000000007f080400400200000040dd180050f2020101010003a4000=
027a4000042435e0062322f00470d02000a53020100000131550101470d02000a5302020000=
0132550102', 'bssid': '02:00:00:00:03:00', 'flags': '[ESS]', 'beacon_ie': '=
000b7472616e736d6974746564010882848b960c1218240301010504000200002a010432043=
048606c3b0251002d1a0c001bffff0000000000000000000001000000000000000000003d16=
010000000000000000000000000000000000000000007f080400400200000040dd180050f20=
20101010003a4000027a4000042435e0062322f00470d02000a53020100000131550101470d=
02000a53020200000132550102', 'beacon_int': '100', 'noise': '-89', 'level': =
'-30', 'snr': '59', 'update_idx': '167', 'id': '90', 'age': '0', 'freq': '2=
412'}
AP 02:00:00:00:03:01: {'est_throughput': '65000', 'qual': '0', 'tsf': '1561=
584622597709', 'capabilities': '0x0001', 'ssid': '1', 'ie': '00013101088284=
8b960c1218240301012a010432043048606c3b0251002d1a0c001bffff00000000000000000=
00001000000000000000000003d16010000000000000000000000000000000000000000007f=
080400400200000040dd180050f2020101010003a4000027a4000042435e0062322f0055010=
1', 'bssid': '02:00:00:00:03:01', 'flags': '[ESS]', 'beacon_ie': '000131010=
882848b960c1218240301010504000200002a010432043048606c3b0251002d1a0c001bffff=
0000000000000000000001000000000000000000003d1601000000000000000000000000000=
0000000000000007f080400400200000040dd180050f2020101010003a4000027a400004243=
5e0062322f00550101', 'beacon_int': '100', 'noise': '-89', 'level': '-30', '=
snr': '59', 'update_idx': '167', 'id': '91', 'age': '0', 'freq': '2412'}
AP 02:00:00:00:03:02: {'est_throughput': '65000', 'qual': '0', 'tsf': '1561=
584622597709', 'capabilities': '0x0002', 'ssid': '2', 'ie': '00013201088284=
8b960c1218240301012a010432043048606c3b0251002d1a0c001bffff00000000000000000=
00001000000000000000000003d16010000000000000000000000000000000000000000007f=
080400400200000040dd180050f2020101010003a4000027a4000042435e0062322f0055010=
2', 'bssid': '02:00:00:00:03:02', 'flags': '[IBSS]', 'beacon_ie': '00013201=
0882848b960c1218240301010504000200002a010432043048606c3b0251002d1a0c001bfff=
f0000000000000000000001000000000000000000003d160100000000000000000000000000=
00000000000000007f080400400200000040dd180050f2020101010003a4000027a40000424=
35e0062322f00550102', 'beacon_int': '100', 'noise': '-89', 'level': '-30', =
'snr': '59', 'update_idx': '167', 'id': '92', 'age': '0', 'freq': '2412'}
PASS scan_multiple_mbssid_ie 0.469995 2019-06-27 05:30:22.754697
passed all 1 test case(s)
2019-06-27 05:30:22 	./run-tests.py scan_new_only=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_new_only 1/1
Test: Scan and only_new=3D1 multiple times
Starting AP wlan3
PASS scan_new_only 1.009654 2019-06-27 05:30:24.143174
passed all 1 test case(s)
2019-06-27 05:30:24 	./run-tests.py scan_only=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_only 1/1
Test: Control interface behavior on scan parameters with type=3Donly
Starting AP wlan3
Full scan
Limited channel scan
Passive single-channel scan
Active single-channel scan
Unexpectedly updated BSS entry
Traceback (most recent call last):
  File "./run-tests.py", line 506, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_scan.py", line 139, in test_=
scan_only
    raise Exception("Unexpectedly updated BSS entry")
Exception: Unexpectedly updated BSS entry
FAIL scan_only 7.351187 2019-06-27 05:30:31.837685
passed 0 test case(s)
skipped 0 test case(s)
failed tests: scan_only
2019-06-27 05:30:31 	./run-tests.py scan_parsing=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_parsing 1/1
Test: Scan result parsing
SCAN_RESULTS:
bssid / frequency / signal level / flags / ssid
02:ff:00:00:00:02	1234	10	[WEP]	test
02:ff:00:00:00:03	0	0	=09
02:ff:00:00:00:04	0	0	=09
02:ff:00:00:00:05	58320	0	[DMG]	dmg
02:ff:00:00:00:06	60480	0	[DMG][IBSS]	dmg
02:ff:00:00:00:07	62640	0	[DMG][PBSS]	dmg
02:ff:00:00:00:08	64800	0	[DMG][ESS]	dmg
02:ff:00:00:00:09	2412	1	[WEP][ESS]	upd
02:ff:00:00:00:00	0	0	=09

BSS output:
id=3D95
bssid=3D02:ff:00:00:00:02
freq=3D1234
beacon_int=3D102
capabilities=3D0x1234
qual=3D10
noise=3D10
level=3D10
tsf=3D1234605616436508552
age=3D124
ie=3D000474657374
flags=3D[WEP]
ssid=3Dtest
snr=3D10
est_throughput=3D100
update_idx=3D186
beacon_ie=3D000474657374

BSS output:
id=3D96
bssid=3D02:ff:00:00:00:03
freq=3D0
beacon_int=3D0
capabilities=3D0x0000
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D0000
flags=3D
ssid=3D
snr=3D0
est_throughput=3D0
update_idx=3D186
beacon_ie=3D0003ffff

BSS output:
id=3D97
bssid=3D02:ff:00:00:00:04
freq=3D0
beacon_int=3D0
capabilities=3D0x0000
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D00000101
flags=3D
ssid=3D
snr=3D0
est_throughput=3D0
update_idx=3D186
beacon_ie=3D0000

BSS output:
id=3D98
bssid=3D02:ff:00:00:00:05
freq=3D58320
beacon_int=3D0
capabilities=3D0x0000
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D0003646d67
flags=3D[DMG]
ssid=3Ddmg
snr=3D0
est_throughput=3D0
update_idx=3D186

BSS output:
id=3D99
bssid=3D02:ff:00:00:00:06
freq=3D60480
beacon_int=3D0
capabilities=3D0x0001
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D0003646d67
flags=3D[DMG][IBSS]
ssid=3Ddmg
snr=3D0
est_throughput=3D0
update_idx=3D186

BSS output:
id=3D100
bssid=3D02:ff:00:00:00:07
freq=3D62640
beacon_int=3D0
capabilities=3D0x0002
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D0003646d67
flags=3D[DMG][PBSS]
ssid=3Ddmg
snr=3D0
est_throughput=3D0
update_idx=3D186

BSS output:
id=3D101
bssid=3D02:ff:00:00:00:08
freq=3D64800
beacon_int=3D0
capabilities=3D0x0003
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D0003646d67
flags=3D[DMG][ESS]
ssid=3Ddmg
snr=3D0
est_throughput=3D0
update_idx=3D186

BSS output:
id=3D102
bssid=3D02:ff:00:00:00:09
freq=3D2412
beacon_int=3D0
capabilities=3D0x0011
qual=3D0
noise=3D0
level=3D1
tsf=3D0000000000000000
age=3D0
ie=3D0003757064010182
flags=3D[WEP][ESS]
ssid=3Dupd
snr=3D0
est_throughput=3D0
update_idx=3D186

BSS output:
id=3D103
bssid=3D02:ff:00:00:00:00
freq=3D0
beacon_int=3D0
capabilities=3D0x0000
qual=3D0
noise=3D0
level=3D0
tsf=3D0000000000000000
age=3D0
ie=3D0000
flags=3D
ssid=3D
snr=3D0
est_throughput=3D0
update_idx=3D186

Discovered BSSs: ['02:ff:00:00:00:02', '02:ff:00:00:00:03', '02:ff:00:00:00=
:04', '02:ff:00:00:00:05', '02:ff:00:00:00:06', '02:ff:00:00:00:07', '02:ff=
:00:00:00:08', '02:ff:00:00:00:09', '02:ff:00:00:00:00']
Update BSS parameters
Updated BSS:
id=3D102
bssid=3D02:ff:00:00:00:09
freq=3D2412
beacon_int=3D0
capabilities=3D0x0002
qual=3D0
noise=3D0
level=3D2
tsf=3D0000000000000000
age=3D0
ie=3D000375706401028204
flags=3D[IBSS]
ssid=3Dupd
snr=3D0
est_throughput=3D0
update_idx=3D187

PASS scan_parsing 0.101607 2019-06-27 05:30:32.331412
passed all 1 test case(s)
2019-06-27 05:30:32 	./run-tests.py scan_probe_req_events=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_probe_req_events 1/1
Test: Probe Request frame RX events from hostapd
Starting AP wlan3
PASS scan_probe_req_events 0.986598 2019-06-27 05:30:33.652658
passed all 1 test case(s)
2019-06-27 05:30:33 	./run-tests.py scan_random_mac=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_random_mac 1/1
Test: Random MAC address in scans
Starting AP wlan3
Probe Request frames seen from: ['9a:9c:c7:fe:d0:b0', 'f2:11:22:33:44:55', =
'f2:11:33:e6:96:13']
PASS scan_random_mac 0.957143 2019-06-27 05:30:34.999277
passed all 1 test case(s)
2019-06-27 05:30:35 	./run-tests.py scan_random_mac_connected=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_random_mac_connected 1/1
Test: Random MAC address in scans while connected
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS scan_random_mac_connected 0.833243 2019-06-27 05:30:36.195375
passed all 1 test case(s)
2019-06-27 05:30:36 	./run-tests.py scan_reqs_with_non_scan_radio_work=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_reqs_with_non_scan_radio_work 1/1
Test: SCAN commands while non-scan radio_work is in progress
PASS scan_reqs_with_non_scan_radio_work 4.219534 2019-06-27 05:30:40.814067
passed all 1 test case(s)
2019-06-27 05:30:40 	./run-tests.py scan_setband=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_setband 1/1
Test: Band selection for scan operations
Starting AP wlan3
Starting AP wlan4
PASS scan_setband 3.879981 2019-06-27 05:30:45.070989
passed all 1 test case(s)
2019-06-27 05:30:45 	./run-tests.py scan_specific_bssid=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_specific_bssid 1/1
Test: Scan for a specific BSSID
Starting AP wlan3
PASS scan_specific_bssid 0.5353 2019-06-27 05:30:45.951154
passed all 1 test case(s)
2019-06-27 05:30:46 	./run-tests.py scan_specify_ssid=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_specify_ssid 1/1
Test: Control interface behavior on scan SSID parameter
Starting AP wlan3
PASS scan_specify_ssid 0.702502 2019-06-27 05:30:47.008165
passed all 1 test case(s)
2019-06-27 05:30:47 	./run-tests.py scan_trigger_failure=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_trigger_failure 1/1
Test: Scan trigger to the driver failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_trigger_failure 1.426008 2019-06-27 05:30:48.803779
passed all 1 test case(s)
2019-06-27 05:30:48 	./run-tests.py scan_tsf=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_tsf 1/1
Test: Scan and TSF updates from Beacon/Probe Response frames
Starting AP wlan3
TSF: 1561584649318621
TSF: 1561584649523421
TSF: 1561584649625810
TSF: 1561584649728214
TSF: 1561584649933030
TSF: 1561584650035427
TSF: 1561584650093021
TSF: 1561584650143343
TSF: 1561584650193359
TSF: 1561584650245098
TSF: 1561584650342622
TSF: 1561584650445023
PASS scan_tsf 1.530298 2019-06-27 05:30:50.686405
passed all 1 test case(s)
2019-06-27 05:30:50 	./run-tests.py sigma_dut_ap_cipher_ccmp_128=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_ccmp_128 1/1
Test: sigma_dut controlled AP with CCMP-128/BIP-CMAC-128 cipher
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_ccmp_128 0.269594 2019-06-27 05:30:51.404486
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:51 	./run-tests.py sigma_dut_ap_cipher_ccmp_256=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_ccmp_256 1/1
Test: sigma_dut controlled AP with CCMP-256/BIP-CMAC-256 cipher
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_ccmp_256 0.218769 2019-06-27 05:30:51.927330
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:51 	./run-tests.py sigma_dut_ap_cipher_ccmp_gcmp_1=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_ccmp_gcmp_1 1/1
Test: sigma_dut controlled AP with CCMP-128+GCMP-256 ciphers (1)
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_ccmp_gcmp_1 0.209078 2019-06-27 05:30:52.424038
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:52 	./run-tests.py sigma_dut_ap_cipher_ccmp_gcmp_2=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_ccmp_gcmp_2 1/1
Test: sigma_dut controlled AP with CCMP-128+GCMP-256 ciphers (2)
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_ccmp_gcmp_2 0.259351 2019-06-27 05:30:53.010031
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:53 	./run-tests.py sigma_dut_ap_cipher_gcmp_128=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_gcmp_128 1/1
Test: sigma_dut controlled AP with GCMP-128/BIP-GMAC-128 cipher
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_gcmp_128 0.252998 2019-06-27 05:30:53.618082
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:53 	./run-tests.py sigma_dut_ap_cipher_gcmp_256=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_gcmp_256 1/1
Test: sigma_dut controlled AP with GCMP-256/BIP-GMAC-256 cipher
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_gcmp_256 0.291702 2019-06-27 05:30:54.234811
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:54 	./run-tests.py sigma_dut_ap_cipher_gcmp_256_group_ccmp=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_cipher_gcmp_256_group_ccmp 1/1
Test: sigma_dut controlled AP with GCMP-256/CCMP/BIP-GMAC-256 cipher
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_cipher_gcmp_256_group_ccmp 0.297155 2019-06-27 05:30:54.8=
88292
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:54 	./run-tests.py sigma_dut_ap_dpp_pkex_responder=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_pkex_responder 1/1
Test: sigma_dut controlled AP as DPP PKEX responder
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_pkex_responder 0.118276 2019-06-27 05:30:55.430480
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:55 	./run-tests.py sigma_dut_ap_dpp_qr=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_qr 1/1
Test: sigma_dut controlled AP (DPP)
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_qr 0.107316 2019-06-27 05:30:55.891186
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:55 	./run-tests.py sigma_dut_ap_dpp_qr_legacy=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_qr_legacy 1/1
Test: sigma_dut controlled AP (legacy)
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_qr_legacy 0.109646 2019-06-27 05:30:56.354355
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:56 	./run-tests.py sigma_dut_ap_dpp_qr_legacy_psk=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_qr_legacy_psk 1/1
Test: sigma_dut controlled AP (legacy)
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_qr_legacy_psk 0.100934 2019-06-27 05:30:56.805559
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:56 	./run-tests.py sigma_dut_ap_dpp_self_config=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_self_config 1/1
Test: sigma_dut DPP AP Configurator using self-configuration
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_self_config 0.102297 2019-06-27 05:30:57.250464
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:57 	./run-tests.py sigma_dut_ap_eap=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_eap 1/1
Test: sigma_dut controlled AP WPA2-Enterprise
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_eap 0.128292 2019-06-27 05:30:57.800411
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:57 	./run-tests.py sigma_dut_ap_eap_osen=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_eap_osen 1/1
Test: sigma_dut controlled AP with EAP+OSEN
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_eap_osen 0.096141 2019-06-27 05:30:58.254919
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:58 	./run-tests.py sigma_dut_ap_eap_sha256=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_eap_sha256 1/1
Test: sigma_dut controlled AP WPA2-Enterprise SHA256
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_eap_sha256 0.093248 2019-06-27 05:30:58.691537
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:58 	./run-tests.py sigma_dut_ap_ent_ft_eap=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_ent_ft_eap 1/1
Test: sigma_dut controlled AP WPA-EAP and FT-EAP
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_ent_ft_eap 0.091654 2019-06-27 05:30:59.120647
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:59 	./run-tests.py sigma_dut_ap_ft_eap=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_ft_eap 1/1
Test: sigma_dut controlled AP FT-EAP
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_ft_eap 0.117395 2019-06-27 05:30:59.579253
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:30:59 	./run-tests.py sigma_dut_ap_ft_psk=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_ft_psk 1/1
Test: sigma_dut controlled AP FT-PSK
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_ft_psk 0.091627 2019-06-27 05:31:00.018577
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:00 	./run-tests.py sigma_dut_ap_hs20=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_hs20 1/1
Test: sigma_dut controlled AP with Hotspot 2.0 parameters
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_hs20 0.112986 2019-06-27 05:31:00.464639
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:00 	./run-tests.py sigma_dut_ap_osen=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_osen 1/1
Test: sigma_dut controlled AP with OSEN
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_osen 0.096346 2019-06-27 05:31:00.928217
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:00 	./run-tests.py sigma_dut_ap_override_rsne=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_override_rsne 1/1
Test: sigma_dut controlled AP overriding RSNE
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_override_rsne 0.122947 2019-06-27 05:31:01.417799
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:01 	./run-tests.py sigma_dut_ap_owe=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_owe 1/1
Test: sigma_dut controlled AP with OWE
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_owe 0.100596 2019-06-27 05:31:01.835705
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:01 	./run-tests.py sigma_dut_ap_owe_ecgroupid=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_owe_ecgroupid 1/1
Test: sigma_dut controlled AP with OWE and ECGroupID
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_owe_ecgroupid 0.09571 2019-06-27 05:31:02.393610
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:02 	./run-tests.py sigma_dut_ap_owe_transition_mode=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_owe_transition_mode 1/1
Test: sigma_dut controlled AP with OWE and transition mode
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_owe_transition_mode 0.147557 2019-06-27 05:31:02.876444
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:02 	./run-tests.py sigma_dut_ap_owe_transition_mode_2=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_owe_transition_mode_2 1/1
Test: sigma_dut controlled AP with OWE and transition mode (2)
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_owe_transition_mode_2 0.134461 2019-06-27 05:31:03.357066
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:03 	./run-tests.py sigma_dut_ap_psk=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_psk 1/1
Test: sigma_dut controlled AP
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_psk 0.104062 2019-06-27 05:31:03.847162
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:03 	./run-tests.py sigma_dut_ap_psk_sae=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_psk_sae 1/1
Test: sigma_dut controlled AP with PSK+SAE
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_psk_sae 0.169915 2019-06-27 05:31:04.371811
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:04 	./run-tests.py sigma_dut_ap_psk_sae_ft=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_psk_sae_ft 1/1
Test: sigma_dut controlled AP with PSK, SAE, FT
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_psk_sae_ft 0.204676 2019-06-27 05:31:04.956070
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:05 	./run-tests.py sigma_dut_ap_psk_sha256=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_psk_sha256 1/1
Test: sigma_dut controlled AP PSK SHA256
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_psk_sha256 0.177967 2019-06-27 05:31:05.613259
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:05 	./run-tests.py sigma_dut_ap_pskhex=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_pskhex 1/1
Test: sigma_dut controlled AP and PSKHEX
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_pskhex 0.134602 2019-06-27 05:31:06.206778
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:06 	./run-tests.py sigma_dut_ap_sae=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae 1/1
Test: sigma_dut controlled AP with SAE
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae 0.160124 2019-06-27 05:31:06.822070
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:06 	./run-tests.py sigma_dut_ap_sae_group=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae_group 1/1
Test: sigma_dut controlled AP with SAE and specific group
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae_group 0.105976 2019-06-27 05:31:07.385971
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:07 	./run-tests.py sigma_dut_ap_sae_password=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae_password 1/1
Test: sigma_dut controlled AP with SAE and long password
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae_password 0.154609 2019-06-27 05:31:08.047526
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:08 	./run-tests.py sigma_dut_ap_sae_pw_id=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae_pw_id 1/1
Test: sigma_dut controlled AP with SAE Password Identifier
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae_pw_id 0.160104 2019-06-27 05:31:08.606158
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:08 	./run-tests.py sigma_dut_ap_sae_pw_id_ft=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae_pw_id_ft 1/1
Test: sigma_dut controlled AP with SAE Password Identifier and FT
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae_pw_id_ft 0.096592 2019-06-27 05:31:09.091137
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:09 	./run-tests.py sigma_dut_ap_suite_b=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_suite_b 1/1
Test: sigma_dut controlled AP Suite B
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_suite_b 0.342008 2019-06-27 05:31:09.876758
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:09 	./run-tests.py sigma_dut_basic=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_basic 1/1
Test: sigma_dut basic functionality
Skip test case: sigma_dut not available
SKIP sigma_dut_basic 0.064402 2019-06-27 05:31:10.314452
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:10 	./run-tests.py sigma_dut_dpp_incompatible_roles_init=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_incompatible_roles_init 1/1
Test: sigma_dut DPP roles incompatible (Initiator)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_incompatible_roles_init 0.064899 2019-06-27 05:31:10.810=
583
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:10 	./run-tests.py sigma_dut_dpp_incompatible_roles_resp=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_incompatible_roles_resp 1/1
Test: sigma_dut DPP roles incompatible (Responder)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_incompatible_roles_resp 0.061511 2019-06-27 05:31:11.208=
523
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:11 	./run-tests.py sigma_dut_dpp_pkex_init_configurator=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_pkex_init_configurator 1/1
Test: sigma_dut DPP/PKEX initiator as Configurator
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_pkex_init_configurator 0.066226 2019-06-27 05:31:11.6859=
96
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:11 	./run-tests.py sigma_dut_dpp_pkex_responder_proto=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_pkex_responder_proto 1/1
Test: sigma_dut controlled STA as DPP PKEX responder and error case
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_pkex_responder_proto 0.061441 2019-06-27 05:31:12.108113
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:12 	./run-tests.py sigma_dut_dpp_proto_initiator=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_initiator 1/1
Test: sigma_dut DPP protocol testing - Initiator
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_initiator 0.064163 2019-06-27 05:31:12.527651
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:12 	./run-tests.py sigma_dut_dpp_proto_initiator_pkex=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_initiator_pkex 1/1
Test: sigma_dut DPP protocol testing - Initiator (PKEX)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_initiator_pkex 0.067927 2019-06-27 05:31:12.947765
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:13 	./run-tests.py sigma_dut_dpp_proto_peer_disc_req=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_peer_disc_req 1/1
Test: sigma_dut DPP protocol testing - Peer Discovery Request
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_peer_disc_req 0.06088 2019-06-27 05:31:13.459136
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:13 	./run-tests.py sigma_dut_dpp_proto_responder=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_responder 1/1
Test: sigma_dut DPP protocol testing - Responder
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_responder 0.080484 2019-06-27 05:31:13.875024
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:13 	./run-tests.py sigma_dut_dpp_proto_responder_pkex=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_responder_pkex 1/1
Test: sigma_dut DPP protocol testing - Responder (PKEX)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_responder_pkex 0.060927 2019-06-27 05:31:14.262724
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:14 	./run-tests.py sigma_dut_dpp_proto_stop_at_initiator=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_stop_at_initiator 1/1
Test: sigma_dut DPP protocol testing - Stop at RX on Initiator
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_stop_at_initiator 0.060331 2019-06-27 05:31:14.646=
359
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:14 	./run-tests.py sigma_dut_dpp_proto_stop_at_initiator_e=
nrollee=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_stop_at_initiator_enrollee 1/1
Test: sigma_dut DPP protocol testing - Stop at TX on Initiator/Enrollee
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_stop_at_initiator_enrollee 0.061935 2019-06-27 05:=
31:15.040127
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:15 	./run-tests.py sigma_dut_dpp_proto_stop_at_responder=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_proto_stop_at_responder 1/1
Test: sigma_dut DPP protocol testing - Stop at RX on Responder
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_proto_stop_at_responder 0.061413 2019-06-27 05:31:15.426=
204
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:15 	./run-tests.py sigma_dut_dpp_qr_init_configurator_1=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_1 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 1)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_1 0.056449 2019-06-27 05:31:15.8070=
42
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:15 	./run-tests.py sigma_dut_dpp_qr_init_configurator_2=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_2 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 2)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_2 0.056713 2019-06-27 05:31:16.1907=
78
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:16 	./run-tests.py sigma_dut_dpp_qr_init_configurator_3=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_3 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 3)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_3 0.058306 2019-06-27 05:31:16.5755=
92
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:16 	./run-tests.py sigma_dut_dpp_qr_init_configurator_4=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_4 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 4)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_4 0.061983 2019-06-27 05:31:16.9621=
44
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:17 	./run-tests.py sigma_dut_dpp_qr_init_configurator_5=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_5 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 5)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_5 0.059414 2019-06-27 05:31:17.3501=
81
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:17 	./run-tests.py sigma_dut_dpp_qr_init_configurator_6=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_6 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 6)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_6 0.057473 2019-06-27 05:31:17.7341=
57
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:17 	./run-tests.py sigma_dut_dpp_qr_init_configurator_7=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_7 1/1
Test: sigma_dut DPP/QR initiator as Configurator (conf index 7)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_7 0.06137 2019-06-27 05:31:18.125555
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:18 	./run-tests.py sigma_dut_dpp_qr_init_configurator_both=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_both 1/1
Test: sigma_dut DPP/QR initiator as Configurator or Enrollee (conf index 1)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_both 0.059676 2019-06-27 05:31:18.5=
19603
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:18 	./run-tests.py sigma_dut_dpp_qr_init_configurator_neg_=
freq=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_configurator_neg_freq 1/1
Test: sigma_dut DPP/QR initiator as Configurator (neg_freq)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_configurator_neg_freq 0.093733 2019-06-27 05:31:=
18.934675
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:18 	./run-tests.py sigma_dut_dpp_qr_init_enrollee=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_enrollee 1/1
Test: sigma_dut DPP/QR initiator as Enrollee
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_enrollee 0.37099 2019-06-27 05:31:19.634498
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:19 	./run-tests.py sigma_dut_dpp_qr_init_enrollee_psk=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_enrollee_psk 1/1
Test: sigma_dut DPP/QR initiator as Enrollee (PSK)
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_enrollee_psk 0.521256 2019-06-27 05:31:20.536290
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:20 	./run-tests.py sigma_dut_dpp_qr_init_enrollee_sae=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_init_enrollee_sae 1/1
Test: sigma_dut DPP/QR initiator as Enrollee (SAE)
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_init_enrollee_sae 0.500239 2019-06-27 05:31:21.433683
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:21 	./run-tests.py sigma_dut_dpp_qr_mutual_init_enrollee=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_mutual_init_enrollee 1/1
Test: sigma_dut DPP/QR (mutual) initiator as Enrollee
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_mutual_init_enrollee 0.357953 2019-06-27 05:31:22.270=
704
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:22 	./run-tests.py sigma_dut_dpp_qr_mutual_init_enrollee_c=
heck=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_mutual_init_enrollee_check 1/1
Test: sigma_dut DPP/QR (mutual) initiator as Enrollee (extra check)
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_mutual_init_enrollee_check 0.26758 2019-06-27 05:31:2=
2.949099
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:23 	./run-tests.py sigma_dut_dpp_qr_mutual_init_enrollee_p=
ending=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_mutual_init_enrollee_pending 1/1
Test: sigma_dut DPP/QR (mutual) initiator as Enrollee (response pending)
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_mutual_init_enrollee_pending 0.305885 2019-06-27 05:3=
1:23.656839
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:23 	./run-tests.py sigma_dut_dpp_qr_mutual_resp_enrollee=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_mutual_resp_enrollee 1/1
Test: sigma_dut DPP/QR (mutual) responder as Enrollee
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_mutual_resp_enrollee 0.361387 2019-06-27 05:31:24.621=
727
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:24 	./run-tests.py sigma_dut_dpp_qr_mutual_resp_enrollee_p=
ending=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_mutual_resp_enrollee_pending 1/1
Test: sigma_dut DPP/QR (mutual) responder as Enrollee (response pending)
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_mutual_resp_enrollee_pending 0.302716 2019-06-27 05:3=
1:25.346431
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:25 	./run-tests.py sigma_dut_dpp_qr_resp_1=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_1 1/1
Test: sigma_dut DPP/QR responder (conf index 1)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_1 0.102209 2019-06-27 05:31:25.963546
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:26 	./run-tests.py sigma_dut_dpp_qr_resp_2=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_2 1/1
Test: sigma_dut DPP/QR responder (conf index 2)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_2 0.076859 2019-06-27 05:31:26.500125
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:26 	./run-tests.py sigma_dut_dpp_qr_resp_3=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_3 1/1
Test: sigma_dut DPP/QR responder (conf index 3)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_3 0.086582 2019-06-27 05:31:27.004104
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:27 	./run-tests.py sigma_dut_dpp_qr_resp_4=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_4 1/1
Test: sigma_dut DPP/QR responder (conf index 4)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_4 0.073265 2019-06-27 05:31:27.460603
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:27 	./run-tests.py sigma_dut_dpp_qr_resp_5=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_5 1/1
Test: sigma_dut DPP/QR responder (conf index 5)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_5 0.081397 2019-06-27 05:31:27.945055
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:28 	./run-tests.py sigma_dut_dpp_qr_resp_6=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_6 1/1
Test: sigma_dut DPP/QR responder (conf index 6)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_6 0.067804 2019-06-27 05:31:28.408508
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:28 	./run-tests.py sigma_dut_dpp_qr_resp_7=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_7 1/1
Test: sigma_dut DPP/QR responder (conf index 7)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_7 0.070899 2019-06-27 05:31:28.857650
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:28 	./run-tests.py sigma_dut_dpp_qr_resp_8=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_8 1/1
Test: sigma_dut DPP/QR responder (conf index 8)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_8 0.064581 2019-06-27 05:31:29.309487
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:29 	./run-tests.py sigma_dut_dpp_qr_resp_chan_list=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_qr_resp_chan_list 1/1
Test: sigma_dut DPP/QR responder (channel list override)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_qr_resp_chan_list 0.064539 2019-06-27 05:31:29.728595
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:29 	./run-tests.py sigma_dut_dpp_self_config=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_self_config 1/1
Test: sigma_dut DPP Configurator enrolling an AP and using self-configurati=
on
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_self_config 0.263015 2019-06-27 05:31:30.355031
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:30 	./run-tests.py sigma_dut_eap_ttls=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_eap_ttls 1/1
Test: sigma_dut controlled STA and EAP-TTLS parameters
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_eap_ttls 0.329357 2019-06-27 05:31:31.008022
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:31 	./run-tests.py sigma_dut_eap_ttls_uosc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_eap_ttls_uosc 1/1
Test: sigma_dut controlled STA and EAP-TTLS with UOSC
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_eap_ttls_uosc 0.275111 2019-06-27 05:31:31.666867
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:31 	./run-tests.py sigma_dut_eap_ttls_uosc_ca_mistrust=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_eap_ttls_uosc_ca_mistrust 1/1
Test: sigma_dut controlled STA and EAP-TTLS with UOSC when CA is not trusted
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_eap_ttls_uosc_ca_mistrust 0.247946 2019-06-27 05:31:32.271192
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:32 	./run-tests.py sigma_dut_eap_ttls_uosc_tod=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_eap_ttls_uosc_tod 1/1
Test: sigma_dut controlled STA and EAP-TTLS with UOSC/TOD
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_eap_ttls_uosc_tod 0.2782 2019-06-27 05:31:32.893790
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:32 	./run-tests.py sigma_dut_hs20_assoc_24=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_hs20_assoc_24 1/1
Test: sigma_dut controlled Hotspot 2.0 connection (2.4 GHz)
Starting AP wlan3
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_hs20_assoc_24 0.674181 2019-06-27 05:31:33.925045
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:33 	./run-tests.py sigma_dut_hs20_assoc_5=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_hs20_assoc_5 1/1
Test: sigma_dut controlled Hotspot 2.0 connection (5 GHz)
Starting AP wlan3
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_hs20_assoc_5 0.785267 2019-06-27 05:31:35.100934
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:35 	./run-tests.py sigma_dut_open=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_open 1/1
Test: sigma_dut controlled open network association
Skip test case: sigma_dut not available
SKIP sigma_dut_open 0.065999 2019-06-27 05:31:35.547010
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:35 	./run-tests.py sigma_dut_owe=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_owe 1/1
Test: sigma_dut controlled OWE station
Skip test case: sigma_dut not available
SKIP sigma_dut_owe 0.056653 2019-06-27 05:31:36.143188
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:36 	./run-tests.py sigma_dut_preconfigured_profile=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_preconfigured_profile 1/1
Test: sigma_dut controlled connection using preconfigured profile
Skip test case: sigma_dut not available
SKIP sigma_dut_preconfigured_profile 0.067333 2019-06-27 05:31:36.531869
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:36 	./run-tests.py sigma_dut_psk_pmf=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_psk_pmf 1/1
Test: sigma_dut controlled PSK+PMF association
Skip test case: sigma_dut not available
SKIP sigma_dut_psk_pmf 0.064838 2019-06-27 05:31:36.965885
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:37 	./run-tests.py sigma_dut_psk_pmf_bip_cmac_128=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_psk_pmf_bip_cmac_128 1/1
Test: sigma_dut controlled PSK+PMF association with BIP-CMAC-128
Skip test case: sigma_dut not available
SKIP sigma_dut_psk_pmf_bip_cmac_128 0.066695 2019-06-27 05:31:37.395653
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:37 	./run-tests.py sigma_dut_psk_pmf_bip_cmac_256=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_psk_pmf_bip_cmac_256 1/1
Test: sigma_dut controlled PSK+PMF association with BIP-CMAC-256
Skip test case: sigma_dut not available
SKIP sigma_dut_psk_pmf_bip_cmac_256 0.06568 2019-06-27 05:31:37.805831
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:37 	./run-tests.py sigma_dut_psk_pmf_bip_gmac_128=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_psk_pmf_bip_gmac_128 1/1
Test: sigma_dut controlled PSK+PMF association with BIP-GMAC-128
Skip test case: sigma_dut not available
SKIP sigma_dut_psk_pmf_bip_gmac_128 0.06585 2019-06-27 05:31:38.213132
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:38 	./run-tests.py sigma_dut_psk_pmf_bip_gmac_256=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_psk_pmf_bip_gmac_256 1/1
Test: sigma_dut controlled PSK+PMF association with BIP-GMAC-256
Skip test case: sigma_dut not available
SKIP sigma_dut_psk_pmf_bip_gmac_256 0.066349 2019-06-27 05:31:38.625122
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:38 	./run-tests.py sigma_dut_psk_pmf_bip_gmac_256_mismatch=
=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_psk_pmf_bip_gmac_256_mismatch 1/1
Test: sigma_dut controlled PSK+PMF association with BIP-GMAC-256 mismatch
Skip test case: sigma_dut not available
SKIP sigma_dut_psk_pmf_bip_gmac_256_mismatch 0.062727 2019-06-27 05:31:39.0=
05918
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:39 	./run-tests.py sigma_dut_sae=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sae 1/1
Test: sigma_dut controlled SAE association
Skip test case: sigma_dut not available
SKIP sigma_dut_sae 0.064596 2019-06-27 05:31:39.448522
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:39 	./run-tests.py sigma_dut_sae_password=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sae_password 1/1
Test: sigma_dut controlled SAE association and long password
Skip test case: sigma_dut not available
SKIP sigma_dut_sae_password 0.05978 2019-06-27 05:31:39.851377
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:39 	./run-tests.py sigma_dut_sae_pw_id=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sae_pw_id 1/1
Test: sigma_dut controlled SAE association with Password Identifier
Skip test case: sigma_dut not available
SKIP sigma_dut_sae_pw_id 0.064264 2019-06-27 05:31:40.263082
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:40 	./run-tests.py sigma_dut_sae_pw_id_ft=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sae_pw_id_ft 1/1
Test: sigma_dut controlled SAE association with Password Identifier and FT
Skip test case: sigma_dut not available
SKIP sigma_dut_sae_pw_id_ft 0.059807 2019-06-27 05:31:40.665544
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:40 	./run-tests.py sigma_dut_sta_override_rsne=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sta_override_rsne 1/1
Test: sigma_dut and RSNE override on STA
Skip test case: sigma_dut not available
SKIP sigma_dut_sta_override_rsne 0.064434 2019-06-27 05:31:41.063581
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:41 	./run-tests.py sigma_dut_sta_scan_bss=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sta_scan_bss 1/1
Test: sigma_dut sta_scan_bss
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_sta_scan_bss 0.234711 2019-06-27 05:31:41.659258
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:41 	./run-tests.py sigma_dut_sta_scan_ssid_bssid=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sta_scan_ssid_bssid 1/1
Test: sigma_dut sta_scan GetParameter,SSID_BSSID
Starting AP wlan3
Starting AP wlan4
Skip test case: sigma_dut not available
SKIP sigma_dut_sta_scan_ssid_bssid 0.414635 2019-06-27 05:31:42.443536
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:42 	./run-tests.py sigma_dut_suite_b=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_suite_b 1/1
Test: sigma_dut controlled STA Suite B
Starting AP wlan4
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_suite_b 0.516333 2019-06-27 05:31:43.319437
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:43 	./run-tests.py sigma_dut_suite_b_rsa=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_suite_b_rsa 1/1
Test: sigma_dut controlled STA Suite B (RSA)
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_suite_b_rsa 0.347014 2019-06-27 05:31:44.023895
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:44 	./run-tests.py sigma_dut_venue_url=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_venue_url 1/1
Test: sigma_dut controlled Venue URL fetch
Skip test case: sigma_dut not available
SKIP sigma_dut_venue_url 0.05808 2019-06-27 05:31:44.477007
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:44 	./run-tests.py sigma_dut_wps_pbc=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_wps_pbc 1/1
Test: sigma_dut and WPS PBC Enrollee
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_wps_pbc 0.278004 2019-06-27 05:31:45.083108
passed all 0 test case(s)
skipped 1 test case(s)
2019-06-27 05:31:45 	./run-tests.py ssid_1_octet=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ssid_1_octet 1/1
Test: SSID with one octet
Starting AP wlan3
Connect STA wlan0 to AP
PASS ssid_1_octet 0.450567 2019-06-27 05:31:45.885273
passed all 1 test case(s)
2019-06-27 05:31:45 	./run-tests.py ssid_32_octets=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ssid_32_octets 1/1
Test: SSID with 32 octets
Starting AP wlan3
Connect STA wlan0 to AP
PASS ssid_32_octets 0.428974 2019-06-27 05:31:46.649783
passed all 1 test case(s)
2019-06-27 05:31:46 	./run-tests.py ssid_32_octets_nul_term=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ssid_32_octets_nul_term 1/1
Test: SSID with 32 octets with nul at the end
Starting AP wlan3
Connect STA wlan0 to AP
PASS ssid_32_octets_nul_term 0.50275 2019-06-27 05:31:47.499010
passed all 1 test case(s)
2019-06-27 05:31:47 	./run-tests.py ssid_hex_encoded=20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ssid_hex_encoded 1/1
Test: SSID configuration using hex encoded version
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ssid_hex_encoded 0.669016 2019-06-27 05:31:48.500524
passed all 1 test case(s)
2019-06-27 05:31:48 ./stop.sh
2019-06-27 05:31:49 ./start.sh channels=3D4
2019-06-27 05:31:51 ./stop.sh

--6FinHCQBQ0zFDOqT--
