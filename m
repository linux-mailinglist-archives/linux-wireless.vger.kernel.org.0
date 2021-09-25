Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07E64181F1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 14:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbhIYMiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 08:38:03 -0400
Received: from mail.kotidze.in ([185.117.119.164]:35244 "EHLO mail.kotidze.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237543AbhIYMiC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 08:38:02 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Sep 2021 08:38:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodka.home.kg;
        s=vodka; t=1632572806;
        bh=9lXo5H+5KVYZF4pcgmCzBscCmTgSWpSboB4PvxHG5Kg=;
        h=Date:From:To:Subject:From;
        b=O3JBMfIMOl8kzj3mWRxfUa0SSyDVAOCz7iT8y0VEAI6rO7cIKIypmmgoTkKY1pUUo
         DgaLx4PMg1VGKi0YCjFtCNeETSof4Intxwll15jYV+g1Kb3PplGzsVTb5Fi8eTEwHC
         5pW18WGqKDKYw5ZlEWjVtkx8+Ge13Wne8k+mPHxg=
Date:   Sat, 25 Sep 2021 15:26:36 +0300
From:   k@vodka.home.kg
Message-ID: <4510598865.20210925152636@vodka.home.kg>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: [MEDIATEK MT76 WIRELESS LAN DRIVER] kernel crash on ifdown of monitor interface
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi !

I'm using openwrt 21.02 kernel 5.4.143 on Tp-link c6u device
It's MT7621DAT based board with 128 MB RAM :
https://openwrt.org/toh/hwdata/tp-link/tp-link_archer_c6u_v1_eu
https://wikidevi.wi-cat.ru/MediaTek_MT7621

Device has 2 wireless interfaces. One for 2.4 Ghz, one for 5 GHz (802.11ac)
If I put both devices to monitor mode then ifdown second device kernel cras=
hes.

wifi down; sleep 3; iw phy phy0 interface add m0 type monitor; iw phy phy1 =
interface add m1 type monitor; ifconfig m0 up; ifconfig m1 up
ifconfig m1 down

[  103.080887] WARNING: CPU: 3 PID: 9247 at target-mipsel_24kc_musl/linux-r=
amips_mt7621/mt76-2021-06-06-22b69033/mt7615/mcu.c:838 mt7615_mcu_add_bss+0=
x1a4/0x3c0 [mt7615_common]
[  103.096360] Modules linked in: pppoe ppp_async wireguard pppox ppp_gener=
ic mt7615e mt7615_common mt7603e mt76_connac_lib mt76 mac80211 lz4 libchach=
a20poly1305 libblake2s ipt_REJECT cfg80211 xt_u32 xt_time xt_tcpudp xt_tcpm=
ss xt_string xt_statistic xt_state xt_recent xt_quota xt_pkttype xt_owner x=
t_nat xt_multiport xt_mark xt_mac xt_limit xt_length xt_ipv4options xt_ipra=
nge xt_iface xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_con=
nlimit xt_connbytes xt_comment xt_bpf xt_addrtype xt_TCPMSS xt_REDIRECT xt_=
NFQUEUE xt_NFLOG xt_NETMAP xt_MASQUERADE xt_LOG xt_IPMARK xt_HL xt_FLOWOFFL=
OAD xt_DSCP xt_CT xt_CLASSIFY ts_kmp ts_fsm ts_bm slhc poly1305_mips nfnetl=
ink_queue nfnetlink_log nf_reject_ipv4 nf_log_ipv4 nf_flow_table_hw nf_flow=
_table nf_conntrack_netlink nf_conncount lz4_decompress lz4_compress libcur=
ve25519_generic libblake2s_generic iptable_raw iptable_nat iptable_mangle i=
ptable_filter ipt_ECN ip_tables hwmon crc_ccitt compat_xtables compat chach=
a_mips sch_tbf
[  103.096659]  sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_tcindex cls=
_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_ga=
ct ledtrig_usbport xt_set ip_set_list_set ip_set_hash_netportnet ip_set_has=
h_netport ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net ip_set_ha=
sh_mac ip_set_hash_ipportnet ip_set_hash_ipportip ip_set_hash_ipport ip_set=
_hash_ipmark ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_b=
itmap_ip ip_set nfnetlink ip6table_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 ip6t_NPT ip6t_rt ip6t_mh ip6t_ipv6header ip6t_hbh ip6t_frag i=
p6t_eui64 ip6t_ah nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter=
 ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 nfsv4 nfsd nfs ip6_udp_tunn=
el udp_tunnel sit tunnel4 ip_tunnel rpcsec_gss_krb5 auth_rpcgss oid_registr=
y loop lockd sunrpc grace cifs dns_resolver dm_mirror dm_region_hash dm_log=
 dm_crypt dm_mod dax nls_utf8 zram zsmalloc sha512_generic sha256_generic l=
ibsha256 sha1_generic seqiv
[  103.183417]  jitterentropy_rng drbg md5 md4 kpp hmac ecb des_generic lib=
des cts ctr cmac ccm cbc arc4 usb_storage leds_gpio xhci_plat_hcd xhci_pci =
xhci_mtk xhci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 mbcache jbd2 usb=
core nls_base usb_common crc32c_generic
[  103.293588] CPU: 3 PID: 9247 Comm: ifconfig Not tainted 5.4.143 #0
[  103.299742] Stack : 00000001 80082090 00000000 00000000 80740000 80741c1=
c 807408e0 831d5af4
[  103.308069]         808f0000 8078eda3 806bfa64 806bfa64 00000003 0000000=
1 831d5a98 00000007
[  103.316393]         00000000 00000000 80930000 00000000 00000030 000001c=
9 35206465 312e342e
[  103.324714]         00000000 00000005 00000000 00047ad4 80000000 807b000=
0 00000000 857659f0
[  103.333038]         00000009 00000000 8553dec0 0000007f 00000001 8038208=
4 0000000c 808f000c
[  103.341362]         ...
[  103.343800] Call Trace:
[  103.346258] [<8000b68c>] show_stack+0x30/0x100
[  103.350697] [<805f89d0>] dump_stack+0xa4/0xdc
[  103.355054] [<8003002c>] __warn+0xc0/0x10c
[  103.359139] [<800300d4>] warn_slowpath_fmt+0x5c/0xac
[  103.364131] [<857659f0>] mt7615_mcu_add_bss+0x1a4/0x3c0 [mt7615_common]
[  103.370738] [<85760a14>] mt7615_remove_interface+0x74/0x1e0 [mt7615_comm=
on]
[  103.377948] [<85603fcc>] drv_remove_interface+0x2c/0xa0 [mac80211]
[  103.384279] [<8561a8e4>] ieee80211_del_virtual_monitor.part.22+0x74/0xe8=
 [mac80211]
[  103.392115] [<8561b7f0>] ieee80211_do_stop+0x4a4/0x8a0 [mac80211]
[  103.398370] [<8561bc00>] ieee80211_stop+0x14/0x24 [mac80211]
[  103.404102] [<8045a328>] __dev_close_many+0x9c/0x10c
[  103.409066] [<80463de4>] __dev_change_flags+0x16c/0x1e4
[  103.414272] [<80463e84>] dev_change_flags+0x28/0x70
[  103.419143] [<80521e54>] devinet_ioctl+0x280/0x774
[  103.423921] [<80526248>] inet_ioctl+0xa4/0x1c8
[  103.428377] [<80436830>] sock_ioctl+0x2d8/0x4bc
[  103.432901] [<801adbb4>] do_vfs_ioctl+0xb8/0x7c0
[  103.437500] [<801ae30c>] ksys_ioctl+0x50/0xb4
[  103.441850] [<80014598>] syscall_common+0x34/0x58
[  103.446943] ---[ end trace c9d0244457e77d7c ]---
[  103.451600] CPU 3 Unable to handle kernel paging request at virtual addr=
ess 00000003, epc =3D=3D 8576591c, ra =3D=3D 857659f0
[  103.462226] Oops[#1]:
[  103.464499] CPU: 3 PID: 9247 Comm: ifconfig Tainted: G        W         =
5.4.143 #0
[  103.472031] $ 0   : 00000000 00000001 83be3854 00000000
[  103.477239] $ 4   : 8102a374 8102a374 8102f0b0 00000200
[  103.482444] $ 8   : 0000002d 000001e4 64373765 5d206337
[  103.487647] $12   : 00000000 00000005 00000000 0006d1df
[  103.492853] $16   : 83be3848 853838a8 8743d600 00010000
[  103.498059] $20   : 00000000 00000000 8553dec0 0000007f
[  103.503266] $24   : 00000003 80382084                 =20
[  103.508472] $28   : 831d4000 831d5bc0 00000001 857659f0
[  103.513678] Hi    : 00000122
[  103.516543] Lo    : d1768000
[  103.519452] epc   : 8576591c mt7615_mcu_add_bss+0xd0/0x3c0 [mt7615_commo=
n]
[  103.526306] ra    : 857659f0 mt7615_mcu_add_bss+0x1a4/0x3c0 [mt7615_comm=
on]
[  103.533232] Status: 11007c03 KERNEL EXL IE=20
[  103.537402] Cause : 40800008 (ExcCode 02)
[  103.541389] BadVA : 00000003
[  103.544253] PrId  : 0001992f (MIPS 1004Kc)
[  103.548324] Modules linked in: pppoe ppp_async wireguard pppox ppp_gener=
ic mt7615e mt7615_common mt7603e mt76_connac_lib mt76 mac80211 lz4 libchach=
a20poly1305 libblake2s ipt_REJECT cfg80211 xt_u32 xt_time xt_tcpudp xt_tcpm=
ss xt_string xt_statistic xt_state xt_recent xt_quota xt_pkttype xt_owner x=
t_nat xt_multiport xt_mark xt_mac xt_limit xt_length xt_ipv4options xt_ipra=
nge xt_iface xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_con=
nlimit xt_connbytes xt_comment xt_bpf xt_addrtype xt_TCPMSS xt_REDIRECT xt_=
NFQUEUE xt_NFLOG xt_NETMAP xt_MASQUERADE xt_LOG xt_IPMARK xt_HL xt_FLOWOFFL=
OAD xt_DSCP xt_CT xt_CLASSIFY ts_kmp ts_fsm ts_bm slhc poly1305_mips nfnetl=
ink_queue nfnetlink_log nf_reject_ipv4 nf_log_ipv4 nf_flow_table_hw nf_flow=
_table nf_conntrack_netlink nf_conncount lz4_decompress lz4_compress libcur=
ve25519_generic libblake2s_generic iptable_raw iptable_nat iptable_mangle i=
ptable_filter ipt_ECN ip_tables hwmon crc_ccitt compat_xtables compat chach=
a_mips sch_tbf
[  103.548514]  sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_tcindex cls=
_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_ga=
ct ledtrig_usbport xt_set ip_set_list_set ip_set_hash_netportnet ip_set_has=
h_netport ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net ip_set_ha=
sh_mac ip_set_hash_ipportnet ip_set_hash_ipportip ip_set_hash_ipport ip_set=
_hash_ipmark ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_b=
itmap_ip ip_set nfnetlink ip6table_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 ip6t_NPT ip6t_rt ip6t_mh ip6t_ipv6header ip6t_hbh ip6t_frag i=
p6t_eui64 ip6t_ah nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter=
 ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 nfsv4 nfsd nfs ip6_udp_tunn=
el udp_tunnel sit tunnel4 ip_tunnel rpcsec_gss_krb5 auth_rpcgss oid_registr=
y loop lockd sunrpc grace cifs dns_resolver dm_mirror dm_region_hash dm_log=
 dm_crypt dm_mod dax nls_utf8 zram zsmalloc sha512_generic sha256_generic l=
ibsha256 sha1_generic seqiv
[  103.634944]  jitterentropy_rng drbg md5 md4 kpp hmac ecb des_generic lib=
des cts ctr cmac ccm cbc arc4 usb_storage leds_gpio xhci_plat_hcd xhci_pci =
xhci_mtk xhci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 mbcache jbd2 usb=
core nls_base usb_common crc32c_generic
[  103.744799] Process ifconfig (pid: 9247, threadinfo=3D650b3d16, task=3D0=
2576f7a, tls=3D77e28ec8)
[  103.753022] Stack : 870df080 00000000 0000143c 00000000 00000000 0000000=
0 00000000 853838a8
[  103.761345]         8553dec0 8553f9d8 8553fb38 8553db68 8553e0a0 0000007=
f 00000001 85760a14
[  103.769668]         8553d07c 00000000 00000001 856495c4 85383000 8538300=
0 8553db68 856cc4a0
[  103.777996]         8553db68 8553d07c 00000000 85603fcc 856cc4a0 85649ef=
0 8553cc20 85383000
[  103.786322]         8553db68 856cc4a0 8553cc20 8561a8e4 00000003 8563ae4=
0 8553cc20 856cc4d0
[  103.794645]         ...
[  103.797086] Call Trace:
[  103.799562] [<8576591c>] mt7615_mcu_add_bss+0xd0/0x3c0 [mt7615_common]
[  103.806082] [<85760a14>] mt7615_remove_interface+0x74/0x1e0 [mt7615_comm=
on]
[  103.813280] [<85603fcc>] drv_remove_interface+0x2c/0xa0 [mac80211]
[  103.819612] [<8561a8e4>] ieee80211_del_virtual_monitor.part.22+0x74/0xe8=
 [mac80211]
[  103.827410] [<8561b7f0>] ieee80211_do_stop+0x4a4/0x8a0 [mac80211]
[  103.833671] [<8561bc00>] ieee80211_stop+0x14/0x24 [mac80211]
[  103.839405] [<8045a328>] __dev_close_many+0x9c/0x10c
[  103.844364] [<80463de4>] __dev_change_flags+0x16c/0x1e4
[  103.849569] [<80463e84>] dev_change_flags+0x28/0x70
[  103.854440] [<80521e54>] devinet_ioctl+0x280/0x774
[  103.859222] [<80526248>] inet_ioctl+0xa4/0x1c8
[  103.863674] [<80436830>] sock_ioctl+0x2d8/0x4bc
[  103.868201] [<801adbb4>] do_vfs_ioctl+0xb8/0x7c0
[  103.872804] [<801ae30c>] ksys_ioctl+0x50/0xb4
[  103.877156] [<80014598>] syscall_common+0x34/0x58
[  103.881851] Code: 3c130004  8e230008  2602000c <88640003> 98640000  aa04=
000f  b8440000  90640004  a0440004=20
[  103.891574]=20
[  103.893955] ---[ end trace c9d0244457e77d7d ]---
[  103.898611] Kernel panic - not syncing: Fatal exception
[  103.903850] Rebooting in 3 seconds..

