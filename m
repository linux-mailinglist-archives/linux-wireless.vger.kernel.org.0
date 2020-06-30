Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4094620F767
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbgF3Ok6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 10:40:58 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:57511 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgF3Ok5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 10:40:57 -0400
Received: from [141.24.111.129] (unknown [141.24.111.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 52257580080
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 16:40:54 +0200 (CEST)
To:     linux-wireless@vger.kernel.org
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Subject: BUG: HE CAP IE is build on hw without HE support in mesh mode
Message-ID: <6d0293f4-20ae-1069-0221-dbc2f7254682@tu-ilmenau.de>
Date:   Tue, 30 Jun 2020 16:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I was able to trigger the following warning with the current
wireless-testing git as of 2020-06-30.
wpa_supplicant joins a mesh on ath10k hw without HE support and
therefore should not run into this warning.

[ 3138.720146] WARNING: CPU: 1 PID: 1897 at net/mac80211/util.c:2878
ieee80211_ie_build_he_6ghz_cap+0x149/0x150 [mac80211]
[ 3138.720149] Modules linked in: esp4 poly1305_generic libpoly1305
poly1305_x86_64 chacha_generic chacha_x86_64 libchacha chacha20poly1305
xfrm_user xfrm_algo mt76x2u mt76x2_common mt76x02_usb mt76_usb
ath10k_pci mt76x02_lib mt76 ath10k_core vrf dummy bridge ath stp llc
mac80211 amd64_edac_mod edac_mce_amd kvm_amd kvm cfg80211 irqbypass
crct10dif_pclmul crc32_pclmul pcengines_apuv2 ghash_clmulni_intel
aesni_intel gpio_keys_polled crypto_simd gpio_amd_fch cryptd glue_helper
igb pcspkr k10temp sp5100_tco fam15h_power i2c_piix4 ccp i2c_algo_bit
rfkill rng_core dca libarc4 uio_pdrv_genirq evdev leds_gpio uio
pinctrl_amd mac_hid coreboot_table acpi_cpufreq drm usbip_host
usbip_core agpgart ip_tables x_tables ext4 crc32c_generic crc16 mbcache
jbd2 sdhci_pci cqhci sdhci xhci_pci crc32c_intel ehci_pci xhci_hcd
mmc_core ehci_hcd gpio_keys
[ 3138.720292] CPU: 1 PID: 1897 Comm: wpa_supplicant Tainted: G       
W         5.8.0-rc2-wt-9 #27
[ 3138.720295] Hardware name: PC Engines apu2/apu2, BIOS v4.10.0.3
11/07/2019
[ 3138.720298] RIP: 0010:ieee80211_ie_build_he_6ghz_cap+0x149/0x150
[mac80211]
[ 3138.720319] Code: 75 d4 0f 0b eb ca 41 bc 08 00 00 00 e9 0a ff ff ff
66 41 81 cc 00 02 eb bd 0f 0b 5b 5d 41 5c 41 5d 41 5e e9 59 f1 5f d0 0f
0b <0f> 0b eb c6 0f 1f 00 0f 1f 44 00 00 41 56 45 89 c6 41 55 41 89 cd
[ 3138.720334] RSP: 0018:ffffa4ae8101f870 EFLAGS: 00010246
[ 3138.720338] RAX: ffff8fae5def02e0 RBX: ffff8fae5c1fe900 RCX:
0000000000000007
[ 3138.720341] RDX: 0000000000000000 RSI: ffff8fae5def2fd0 RDI:
ffff8fae5da6bd00
[ 3138.720344] RBP: ffff8fae57e5d800 R08: 0000000000000000 R09:
0000000000000005
[ 3138.720346] R10: 0000000000000004 R11: 0000000000000000 R12:
0000000000000007
[ 3138.720349] R13: 0000000000000001 R14: ffff8fae5def07c0 R15:
0000000000000001
[ 3138.720352] FS:  00007f4d717f1840(0000) GS:ffff8fae6ac80000(0000)
knlGS:0000000000000000
[ 3138.720354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3138.720357] CR2: 00006210000aecf0 CR3: 0000000117ee6000 CR4:
00000000000406e0
[ 3138.720358] Call Trace:
[ 3138.720361]  ieee80211_mesh_build_beacon+0x462/0x530 [mac80211]
[ 3138.720363]  ieee80211_start_mesh+0xa8/0xf0 [mac80211]
[ 3138.720365]  __cfg80211_join_mesh+0x122/0x3e0 [cfg80211]
[ 3138.720368]  nl80211_join_mesh+0x3d3/0x510 [cfg80211]
[ 3138.720370]  genl_rcv_msg+0x1b7/0x310
[ 3138.720372]  ? genl_family_rcv_msg_attrs_parse.isra.0+0x100/0x100
[ 3138.720374]  netlink_rcv_skb+0x75/0x140
[ 3138.720376]  genl_rcv+0x24/0x40
[ 3138.720378]  netlink_unicast+0x242/0x340
[ 3138.720380]  netlink_sendmsg+0x243/0x480
[ 3138.720382]  sock_sendmsg+0x5e/0x60
[ 3138.720384]  ____sys_sendmsg+0x25a/0x2a0
[ 3138.720386]  ? copy_msghdr_from_user+0x6e/0xa0
[ 3138.720388]  ___sys_sendmsg+0x97/0xe0
[ 3138.720390]  __sys_sendmsg+0x81/0xd0
[ 3138.720392]  do_syscall_64+0x44/0x70
[ 3138.720394]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3138.720396] RIP: 0033:0x7f4d71d4e137
[ 3138.720398] Code: Bad RIP value.
[ 3138.720400] RSP: 002b:00007ffee453c468 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[ 3138.720405] RAX: ffffffffffffffda RBX: 0000606000000200 RCX:
00007f4d71d4e137
[ 3138.720407] RDX: 0000000000000000 RSI: 00007ffee453c4d0 RDI:
0000000000000007
[ 3138.720410] RBP: 00007ffee453c4d0 R08: 0000000000000004 R09:
0000000000000011
[ 3138.720413] R10: 00007ffee453c620 R11: 0000000000000246 R12:
0000607000010be0
[ 3138.720415] R13: 00007ffee453c4d0 R14: 00007ffee453c5e0 R15:
0000000000000000
[ 3138.720418] ---[ end trace 3bdd113d937ace9f ]---
