Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1356A3C751
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404425AbfFKJht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 05:37:49 -0400
Received: from mout.web.de ([212.227.17.12]:50759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbfFKJht (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 05:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560245867;
        bh=YlJDNtX4gq4Mga8MclaxVGjG+bKS08LrrzLPBMI5fR0=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=gQxLIBYIK7B1Hkiw/eKWkM+tUB7O/VLz3NMyRpwFdiy6DoxcuXho27/e3KozfMj0D
         v4oZJQ39tNmtoubUMW54nFoxxUWg8EOV1mRhVOfguUIF33VJVYC8pspSHE2Iq7iC1F
         La479qj9zK7DkUyuygJi7LZ8uqtIQ5A6kFAWDlRU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from schienar ([128.141.85.100]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MN4Oy-1hU1WE38TA-006dGf for
 <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2019 11:37:46 +0200
Date:   Tue, 11 Jun 2019 11:37:45 +0200
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-wireless@vger.kernel.org
Subject: Trace with softblocked wireless card during startup on v5.1.x
Message-ID: <20190611113745.5588df6f@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uSJdGXmrnY9EN/oovcK0xeaswJmKuTc4Ibcr1UyO4ja1K35q1tL
 3WQ/vWPXtJXuXVOe5ebWdjx4N7CA/SOBAMJbmCWHHEVJkxB1mUVJ2FhfFBSWf3HMeWv4PDy
 ZPi/wkYGEol4Drp/3UkEWp8pRO9nWquCTdsdoeTwk4ChDDo/piSLU9w1jdi1oM41mHTNC4j
 gYkwzQnyvoVIQQcnwhP8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:miHBInCpRpA=:ctgr3iM46chCVXCiGzENeF
 RK82SXh+D7yg4Ym4xwIEjJkwh5MRwIHTFBqk8v6LA8HCj4TWV2ysfBhVJMg9OWUfoVEDsb5jz
 ZNxEio0/c06jdTSVGD6t1LaooY618/XjlQgfDkp3yHNs2RTAKEH8zXhBPuh3UZSQCTZ+M8np1
 Cef2/eX3OOUu5gSOdfKd51LYnUyeX5XzlA/QRgfuapvz6D2SAajIESoLC/NxYyMrq+euS/7ji
 uH/S9dkPPMnD7vBfL7qkeQ8YierpukA1wmyWoSE6HPqPTw6TPZEm6BEzTcwh5HFG6Kih4XHQ6
 hbWqqSgTK16H9+A0ZRGFR56aRb2uNPBXj3OyPtY+J1TApZkVK8zoIrevpQLgaY71EC+J7P7TW
 +fIdYricUpT4MJ2muiCuRgckVX09OGpF8QhxEXk4CHOlmBTWtuTnp3bVu4/wIbOSIrAtnKs2F
 MgyrBOp/VoJntJdDDOOPr6EsnBjqB9f3cUcPe18x9CaO1663t4vzWd82LhIk1Nr80H9X1ZWfZ
 lT0XPtouafuGxAf21BLmciJvxRVdkpgBIK+9OCrrarMzAqg78u5leg1R7xUbhB79t3U+MI0xS
 GKEAz51yCEZ90udrRx1CzpW7sB5u07q+WrDTPHVUtxIbnTOS03Ijoy52UC1Yg7XJXapEfrKH1
 3i3/MAsJdmdeVK9yOgTRU3Q479GPJbL9WrqJjo3Hi1z4EJjO+cBOXp54hdC2A27Nr6I5vLD0o
 YmiGeh9QmW4T2bvSQJi012hEyru/J8yYJwWcvLvGeJerb0OC7TJ/n4QQUaAVH5GxmqO9PoLEz
 K8Ar1yI4IY0bWZjnFVsZ/qDDp8JU8irc/chwto+y1Vo9KMTOia9YO6vEBPWZN+jF2isWN009d
 TNsEw5D32zjaizQO6aETrB4O/llm5XfgStI7RQeNPrVn6tsboutVv9vMW2CRjBipEq0+C5tK/
 +HZyYnO2dFUm6apNy2s1M0g6uHLsLGkrPtT1ErhvvDnF4VZhVgnKb
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have an Intel Corporation Wireless 8265 / 8275 [8086:24fd] card which
is softblocked during startup and I get the following reproducable
trace:

wpa_supplicant[580]: rfkill: WLAN soft blocked
kernel: [   10.881037] WARNING: CPU: 0 PID: 580 at net/wireless/nl80211.c:=
6714 nl80211_get_reg_do+0x1d9/0x240 [cfg802

kernel: [   10.881038] Modules linked in: arc4 snd_hda_codec_hdmi iwlmvm m=
ac80211 snd_hda_codec_realtek snd_hda_codec
m btintel bluetooth nft_counter iwlwifi nft_limit drbg snd_hda_intel uvcvi=
deo snd_hda_codec snd_usb_audio(+) videobuf
s intel_rapl snd_usbmidi_lib ansi_cprng x86_pkg_temp_thermal snd_hwdep snd=
_hda_core intel_powerclamp coretemp snd_pcm
odev snd_rawmidi snd_timer snd_seq_device videobuf2_common evdev serio_raw=
 snd soundcore cfg80211 i2c_algo_bit nft_ct
per crc16 rfkill syscopyarea sysfillrect sysimgblt fb_sys_fops nf_conntrac=
k idma64 drm nf_defrag_ipv6 nf_defrag_ipv4
b fujitsu_laptop tpm sparse_keymap acpi_pad video ac nf_tables_set nf_tabl=
es nfnetlink sch_fq autofs4 algif_skcipher
 hid dm_crypt dm_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel i2c=
_designware_platform i2c_designware_core gh
psmouse ptp pps_core
kernel: [   10.881066]  ahci libahci i2c_i801 sdhci_pci cqhci xhci_pci sdh=
ci libata xhci_hcd mmc_core scsi_mod usbcor
ss usb_common
kernel: [   10.881073] CPU: 0 PID: 580 Comm: wpa_supplicant Not tainted 5.=
1.8 #4
kernel: [   10.881074] Hardware name: FUJITSU LIFEBOOK U747/FJNB2A5, BIOS =
Version 1.17 09/11/2017
kernel: [   10.881082] RIP: 0010:nl80211_get_reg_do+0x1d9/0x240 [cfg80211]
kernel: [   10.881083] Code: 9a 00 00 00 c7 44 24 0c 01 00 00 00 48 89 df =
e8 ed ff 24 cf 85 c0 74 c3 48 89 df e8 91 1
 73 ff ff ff <0f> 0b 48 89 df e8 7d 18 3c cf b8 ea ff ff ff e9 5f ff ff ff=
 b8 97
kernel: [   10.881084] RSP: 0018:ffffb6b5c1ce7ad8 EFLAGS: 00010202
kernel: [   10.881085] RAX: 0000000000000000 RBX: ffff8ef0951e3e00 RCX: 00=
00000000000000
kernel: [   10.881086] RDX: ffff8ef09331c008 RSI: 0000000000000000 RDI: ff=
ff8ef09331c300
kernel: [   10.881086] RBP: ffffb6b5c1ce7b68 R08: 0000000000000004 R09: ff=
ff8ef093ad2014
kernel: [   10.881087] R10: ffffffffc07da5e0 R11: 0000000000000004 R12: ff=
ff8ef093ad2014
kernel: [   10.881088] R13: 0000000000000000 R14: ffff8ef09331c300 R15: 00=
00000000000001
kernel: [   10.881089] FS:  00007f689cc7a800(0000) GS:ffff8ef09dc00000(000=
0) knlGS:0000000000000000
kernel: [   10.881090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [   10.881091] CR2: 000055d5cdb69000 CR3: 000000024bc50001 CR4: 00=
000000003606f0
kernel: [   10.881091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
kernel: [   10.881092] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00=
00000000000400
kernel: [   10.881093] Call Trace:
kernel: [   10.881098]  ? _cond_resched+0x10/0x20
kernel: [   10.881100]  genl_family_rcv_msg+0x1c5/0x3b0
kernel: [   10.881103]  genl_rcv_msg+0x42/0x87
kernel: [   10.881104]  ? genl_family_rcv_msg+0x3b0/0x3b0
kernel: [   10.881106]  netlink_rcv_skb+0x44/0x110
kernel: [   10.881108]  genl_rcv+0x1f/0x30
kernel: [   10.881111]  netlink_unicast+0x194/0x250
kernel: [   10.881113]  netlink_sendmsg+0x1c7/0x3f0
kernel: [   10.881115]  ? netlink_unicast+0x250/0x250
kernel: [   10.881117]  ___sys_sendmsg+0x291/0x2e0
kernel: [   10.881122]  ? alloc_set_pte+0xe7/0x530
kernel: [   10.881133]  ? filemap_map_pages+0x1ae/0x390
kernel: [   10.881134]  ? __handle_mm_fault+0x100d/0x1240
kernel: [   10.881136]  __sys_sendmsg+0x52/0xa0
kernel: [   10.881139]  do_syscall_64+0x43/0xf0
kernel: [   10.881142]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: [   10.881144] RIP: 0033:0x7f689cfc5914
kernel: [   10.881145] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 =
0f 1f 80 00 00 00 00 48 8d 05 e9 5d 0c 00 8
 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55 48 89=
 f5 53
kernel: [   10.881146] RSP: 002b:00007fff25f0fac8 EFLAGS: 00000246 ORIG_RA=
X: 000000000000002e
kernel: [   10.881147] RAX: ffffffffffffffda RBX: 000055d5cdb5c480 RCX: 00=
007f689cfc5914
kernel: [   10.881148] RDX: 0000000000000000 RSI: 00007fff25f0fb00 RDI: 00=
00000000000005
kernel: [   10.881148] RBP: 000055d5cdb5cbb0 R08: 0000000000000004 R09: 00=
0000000000000d
kernel: [   10.881149] R10: 00007fff25f0fbd4 R11: 0000000000000246 R12: 00=
0055d5cdb5c390
kernel: [   10.881150] R13: 00007fff25f0fb00 R14: 00007fff25f0fc30 R15: 00=
007fff25f0fbd4
kernel: [   10.881151] ---[ end trace dfad2d1ce058f730 ]---



Best regards,
Julian Wollrath

=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
