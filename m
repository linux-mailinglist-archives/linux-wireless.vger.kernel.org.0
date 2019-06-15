Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAC44715A
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfFORCG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 13:02:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:40505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFORCG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 13:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560618121;
        bh=IS0VNzGMxoUA5mU74wLOyIZOW5yr2bzHmiK/O0J6Gsg=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=bBNYXc7gH5hk1ZEEaZjKUWT/pzduv8aTEFAutMcjsTTVZCZEbZw91Vb0DmfDxqdGS
         apuRsY7Pl9vW2i60xGHlx8knCfJfUNOnfNRxGdWX9CZKFdPHsfoGxR/OTWn72F651y
         Sc4aE9zxGWoHNKDe+iY+HZWIqzYj/vQ3NQWl4Ipg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1iHsbh3sK1-00gI8Q; Sat, 15
 Jun 2019 19:02:01 +0200
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
From:   Stefan Wahren <wahrenst@gmx.net>
Subject: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
Date:   Sat, 15 Jun 2019 19:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:ryVtXsQsCJoev94Ia3yg8InhSQS9QDLbz2+VYifmeUWLpR8j60g
 Hd/wWJhsXhfrkLAPvrLFaXZhOxoR8/rMwUa8MoDW6Ylv1A/LuVDaEhKopqTA+bfgxuH3vIy
 dbgr8VzZO/OeEJwN2I+xh8pHRGImn3utwFhCAIJuE7Q88qcYN7q99bQUdYC+UfA4LTj54Ay
 gunm2WeB3N4Fer2WPhRJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:crr9TtQc0Cw=:0rve4Q0OM4zF2ufggVeIfQ
 wJzjZwtz0aL1k5KpV/1rcG6ABtB9l2J54Oe9JUoKivXcpoKYGbRkssuDhFgHISmhCp7RXh3S9
 PWX90PqHo4hN7FASKGwmNJC+DXyOJy1b7yiewoX+6wNJtSxdGGASiHjIVLDGsg6en8JE3g+VB
 KwdN7MdYFVbdfX2ocp9WynQ5Bc6TOqeZsyaF8Bm0k0HYgwNJrPUTMJUb8Os8JpsZ12ajadszH
 UyFKK6zmpM1qQFfo+dW/oVi1+IO0pao71odHSUVpQj1cIs4krjiFuxsTWYdAWgJiyfih+fXFJ
 QgwGVRNx+8p+/K704PpHkGZ4SziiAKFzRm/ibEzS6RIm9L3sOFU4MzM168TvTOxbUVelMIUpm
 gJatLYpTLJj0l2pNnnnFRHIrT3gKdshJ5zJ9hf7Re0ER6rhHTvpvxMqRzTNAenCVxxoNbNOtf
 A9+FsMO4NRnWgpIKRrVMeaS4E9jWoepE704kk+99XA8PY5rd7cS5zRhM7you/g4gfZt6+wLmd
 hbPfLtz0VhjSOBVBEKitc94xSsI3px9ednqMZbhEcBUlOBIAmdARgWEZMZW1oCmCFRkvXA8Jd
 Wu2AN3LYwFPd/42H/DqdZSF5Vdc0Jr12nVdyrpbhvWmeWZjpsYWqgOVA/m6QgJ8rh9xExT1au
 XdCpsUM3eYVowUP1mw+rN3G8l3xcvXdVM2h1JfvCl3M0Ps5QLs0Gw2gPHPZY3I7OARlgl5c+J
 Fg9Y37PfA1IbtV9OC/2zi9H2hRcUKZ9QorjCXqUeAuw4WqfkCbM7rXYR1LgO5upXm7ziXNvqN
 y7eBu/QCLgIDHXDneV6XfvBJ9vDwsYfCLN9G+bIkseaDB+d0RQK9qD4xy8C3vYPVV3yI0fs1z
 7EXz8BmJ6mR6cpX5O2X1uj2Rbpi7p0I18xjjn5oXI3OfHPAzKIrOOV6LfYm4qvXjvGyfAHrE9
 Ftv1Uy9WHna4HQs2QrRHBR4cjzk9efOesk76HcR3MZivF6hI7C+ZFTc3AcHC2fnxPvthr3ZLH
 xg==
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

i was able to reproduce an (maybe older issue) with 4-way handshake
offloading for 802.1X in the brcmfmac driver. My setup consists of
Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
Raspberry Pi 3 A+ (Linux 4.19) on AP side. The issue occurs on the STA
side with wpa_supplicant 2.8, which gives the following output:

Configure PMK for driver-based RSN 4-way handshake
EAPOL: Successfully fetched key (len=3D32)
RSN: Configure PMK for driver-based 4-way handshake - hexdump(len=3D32):
[REMOVED]
wpa_driver_nl80211_set_key: ifindex=3D3 (wlan0) alg=3D5 addr=3D(nil) key_=
idx=3D0
set_tx=3D0 seq_len=3D0 key_len=3D32
nl80211: Set PMK to the driver for b8:27:eb:6c:5e:c9
nl80211: PMK - hexdump(len=3D32): [REMOVED]
nl80211: Set PMK failed: ret=3D-22 (Invalid argument)

During this the kernel also gave this warning:

[=C2=A0 874.485374] WARNING: CPU: 0 PID: 460 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5208
brcmf_cfg80211_set_pmk+0x3c/0x58 [brcmfmac]
[=C2=A0 874.504523] Modules linked in: 8021q garp stp mrp llc bcm2835_v4l=
2(C)
brcmfmac vc4 v4l2_common videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 cec videobuf2_common drm_kms_helper videodev brcmutil
hci_uart cfg80211 mc btbcm drm snd_bcm2835(C) bluetooth smsc95xx
crct10dif_ce usbnet ecdh_generic ecc drm_panel_orientation_quirks
raspberrypi_hwmon rfkill bcm2835_rng bcm2835_thermal pwm_bcm2835
i2c_bcm2835 rng_core vchiq(C) ip_tables x_tables ipv6 nf_defrag_ipv6
[=C2=A0 874.558134] CPU: 0 PID: 460 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
WC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.2.0-rc4-next-20190614-g65b=
eedb66 #3
[=C2=A0 874.574984] Hardware name: Raspberry Pi 3 Model B (DT)
[=C2=A0 874.586546] pstate: 80000005 (Nzcv daif -PAN -UAO)
[=C2=A0 874.597817] pc : brcmf_cfg80211_set_pmk+0x3c/0x58 [brcmfmac]
[=C2=A0 874.610049] lr : nl80211_set_pmk+0x16c/0x1a8 [cfg80211]
[=C2=A0 874.621776] sp : ffff000011aab910
[=C2=A0 874.631533] x29: ffff000011aab910 x28: ffff80002ec5a000
[=C2=A0 874.643326] x27: 0000000000000014 x26: ffff80002fd9c300
[=C2=A0 874.655094] x25: ffff80002fd9c000 x24: ffff80002ec5c000
[=C2=A0 874.666843] x23: 00000000ffffff95 x22: ffff80002ec5d050
[=C2=A0 874.678580] x21: ffff80002ec5d008 x20: ffff000011aaba30
[=C2=A0 874.690336] x19: ffff000011349000 x18: 0000000000000000
[=C2=A0 874.702080] x17: 0000000000000000 x16: 0000000000000000
[=C2=A0 874.713809] x15: 0000000000000000 x14: be1127680d12277d
[=C2=A0 874.725547] x13: 8ba575fc53793d9f x12: ffff000008dff8a8
[=C2=A0 874.737297] x11: 0000000000000fe0 x10: 0000000000000000
[=C2=A0 874.749059] x9 : ffff000010c12068 x8 : ffff000010c12050
[=C2=A0 874.760832] x7 : ffff000008dfe8c8 x6 : 000000000000003f
[=C2=A0 874.772598] x5 : 0000000000000008 x4 : 000000006ceb27b8
[=C2=A0 874.784349] x3 : ffff000008ef1eb0 x2 : ffff000011aab978
[=C2=A0 874.796091] x1 : 0000000000000000 x0 : ffff80002ec5c7c0
[=C2=A0 874.807853] Call trace:
[=C2=A0 874.816698]=C2=A0 brcmf_cfg80211_set_pmk+0x3c/0x58 [brcmfmac]
[=C2=A0 874.828399]=C2=A0 nl80211_set_pmk+0x16c/0x1a8 [cfg80211]
[=C2=A0 874.839327]=C2=A0 genl_family_rcv_msg+0x364/0x460
[=C2=A0 874.849343]=C2=A0 genl_rcv_msg+0x5c/0xc0
[=C2=A0 874.858282]=C2=A0 netlink_rcv_skb+0x5c/0x128
[=C2=A0 874.867486]=C2=A0 genl_rcv+0x34/0x48
[=C2=A0 874.875956]=C2=A0 netlink_unicast+0x190/0x1f8
[=C2=A0 874.885203]=C2=A0 netlink_sendmsg+0x2cc/0x348
[=C2=A0 874.894397]=C2=A0 sock_sendmsg+0x18/0x30
[=C2=A0 874.903124]=C2=A0 ___sys_sendmsg+0x28c/0x2c8
[=C2=A0 874.912216]=C2=A0 __sys_sendmsg+0x6c/0xc8
[=C2=A0 874.921040]=C2=A0 __arm64_sys_sendmsg+0x20/0x28
[=C2=A0 874.930408]=C2=A0 el0_svc_common.constprop.0+0x64/0x160
[=C2=A0 874.940520]=C2=A0 el0_svc_handler+0x28/0x78
[=C2=A0 874.949552]=C2=A0 el0_svc+0x8/0xc
[=C2=A0 874.957674] ---[ end trace 72f634728d4e750f ]---

Here are the information about the used firmware:

[=C2=A0=C2=A0 11.622355] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430-sdio for chip BCM43430/1
[=C2=A0=C2=A0 11.637498] brcmfmac: brcmf_c_process_clm_blob: no clm_blob =
available
(err=3D-2), device may have limited channels available
[=C2=A0=C2=A0 11.658814] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43=
430/1
wl0: Oct 23 2017 03:55:53 version 7.45.98.38 (r674442 CY) FWID 01-e58d219=
f

The actual STA configuration can be found here [1] and other report of
this issue here [2].

Any ideas how to fix this?

[1] - https://gist.github.com/lategoodbye/d4b5da60e905cbdf069affbd41cd14a=
b'
[2] - https://archlinuxarm.org/forum/viewtopic.php?f=3D60&t=3D13644


