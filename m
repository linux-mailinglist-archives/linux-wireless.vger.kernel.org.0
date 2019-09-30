Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B013C28EE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfI3ViO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 17:38:14 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42740 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3ViO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 17:38:14 -0400
Received: by mail-qt1-f178.google.com with SMTP id w14so18953067qto.9
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WxI0iRXlXWneiyvXbYQIs9S1AwT9XFZRPS04+P+ewwg=;
        b=CRCbRaAJq3+IXuLgKK62dpof4LbrvzOc4ZoYX3pLpfhSfuRUIeXC3o+itF79GHDp7L
         v2Ox19oWj3M5izLTKYPfIYug3p3kENcGoIrTS/QUI+iLBVnaCCJgHKK3nNj/B4otsAzU
         BjXH97Ys4rBpi8+DQTgKTXTr57XKmDuprgnNuV4vu0n8lH/T0qLiZDrpRepdguUf550H
         BuorJUJGhO4/2P5K3Xx8SDJF3/S1fajVltQXWrWwbN4NlVOwCDM7qAG0KbSb6BeDqT5W
         CETuse9oCzuoAoaHo2/hCzlsxfSnS8XYnMid2MvCNuCM/icjeAroHRiOj2OxLNnsRu8d
         lYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WxI0iRXlXWneiyvXbYQIs9S1AwT9XFZRPS04+P+ewwg=;
        b=kVoTngJ4EhV0DIS2E92L5wJJ3k9x2qh6/MkqFmlVMZ/qZjpZwGv9Yo5AUN7T/vT7XA
         VJ+/dBYoJjN+nkAu5Wdz71LKHIx91/eNb0AkO6wbt5L5yCMobG94/Kzl3cTCkR7+AkF2
         XAIiZFG8od1msl8BaFlWZtrzF8nAbhNBDPSbLG2pDX6j0gQ5VDaTvry3C03wo9EiJAC9
         4n3WAdRtIGdFDEuJtNrgERPsPwQuLfG0Gbcne7mLbtDJFknp0FztORytRNlUoQd5OuNV
         lONRHlQ3DUjaUjdSLyIk7sbgWT2nlK/sYRnuTVS9p39LFxFbfsKDDPx08wqzLlA4Qnrk
         Uu6A==
X-Gm-Message-State: APjAAAWGckIpl09xQdKxGR465kIwgaWNhLfa1DMSKAwHwubZK0Yj0RNw
        jDWXmwHmSuY73FNEYNsKR3U8Oue8TzZFOmMU8BRP67IYw80=
X-Google-Smtp-Source: APXvYqwV+DGAZtxiCFPm8T/EqK0xQeDjregewPJqkt5PjTKOEilu/E2SR+fo2KL9si1hLsjo+JcFs0BMZy/ZfiGkR/4=
X-Received: by 2002:ac8:1616:: with SMTP id p22mr25376141qtj.356.1569865376988;
 Mon, 30 Sep 2019 10:42:56 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 30 Sep 2019 13:42:42 -0400
Message-ID: <CAMdYzYpqYbgb-9s1VPSreoosQ=BPnhzC_gKOzbGipKikk5+4zA@mail.gmail.com>
Subject: bug: nl80211 / brcmfmac broken for bcm4329/bcm4330 sdio in linux-next
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good Afternoon,

Since 5.3 landed, brcmfmac has been broken both on bcm4329 and bcm4330
sdio devices.

The error received is as follows:
[   19.743990] ------------[ cut here ]------------
[   19.744914] WARNING: CPU: 1 PID: 32 at net/wireless/nl80211.c:3118
nl80211_send_chandef+0x178/0x180 [cfg80211]
[   19.745140] Modules linked in: brcmfmac zram tegra_drm
drm_kms_helper cfbfillrect syscopyarea cfg80211 cfbimgblt sysfillrect
sysimgblt fb_sys_fops hci_uart cfbcopyarea drm btbcm bluetooth
snd_soc_tegra30_i2s snd_soc_tegra_pcm ax88179_178a
drm_panel_orientation_quirks usbnet host1x mii sg brcmutil
snd_soc_tegra30_ahub tegra_wdt sch_fq_codel ip_tables x_tables autofs4
[   19.745473] CPU: 1 PID: 32 Comm: kworker/1:1 Tainted: G        W
     5.3.0-next-20190926+ #34
[   19.745489] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   19.745549] Workqueue: events request_firmware_work_func
[   19.745568] Backtrace:
[   19.745607] [<c010e934>] (dump_backtrace) from [<c010ec48>]
(show_stack+0x20/0x24)
[   19.745650]  r7:60070113 r6:c12cce70 r5:00000000 r4:c12cce70
[   19.745728] [<c010ec28>] (show_stack) from [<c0ad7998>]
(dump_stack+0x80/0x94)
[   19.745776] [<c0ad7918>] (dump_stack) from [<c012ec8c>] (__warn+0xec/0x104)
[   19.745796]  r7:00000009 r6:bf2738b8 r5:00000000 r4:00000000
[   19.745818] [<c012eba0>] (__warn) from [<c012ed5c>]
(warn_slowpath_fmt+0xb8/0xc0)
[   19.745838]  r9:00000009 r8:bf213d5c r7:00000c2e r6:bf2738b8
r5:00000000 r4:c1209888
[   19.746597] [<c012eca8>] (warn_slowpath_fmt) from [<bf213d5c>]
(nl80211_send_chandef+0x178/0x180 [cfg80211])
[   19.746640]  r9:e8de0360 r8:ffffffea r7:ea07b3c0 r6:c1209888
r5:ea07b3c0 r4:ed365b18
[   19.747685] [<bf213be4>] (nl80211_send_chandef [cfg80211]) from
[<bf22eaf0>] (nl80211_send_iface+0xa78/0xb94 [cfg80211])
[   19.747716]  r8:00000000 r7:c12098a8 r6:ed365b18 r5:ea07b3c0 r4:ed58f004
[   19.748578] [<bf22e078>] (nl80211_send_iface [cfg80211]) from
[<bf239908>] (nl80211_notify_iface+0x58/0xe4 [cfg80211])
[   19.748611]  r10:ed593408 r9:00000005 r8:e8de0000 r7:00000007
r6:ed58f004 r5:ea07b3c0
[   19.748627]  r4:e8de0000
[   19.749503] [<bf2398b0>] (nl80211_notify_iface [cfg80211]) from
[<bf1ff98c>] (cfg80211_init_wdev+0x118/0x130 [cfg80211])
[   19.749525]  r7:e8de0360 r6:ed58d000 r5:e8de0000 r4:ed58f004
[   19.750410] [<bf1ff874>] (cfg80211_init_wdev [cfg80211]) from
[<bf1ffd18>] (cfg80211_netdev_notifier_call+0x374/0x7fc [cfg80211])
[   19.750432]  r5:c1209888 r4:ed58f004
[   19.751031] [<bf1ff9a4>] (cfg80211_netdev_notifier_call [cfg80211])
from [<c0159bb0>] (notifier_call_chain+0x58/0x94)
[   19.751068]  r10:ed593408 r9:ffffffe0 r8:00000000 r7:00000005
r6:ed365d5c r5:c12c6568
[   19.751084]  r4:ffffffef
[   19.751109] [<c0159b58>] (notifier_call_chain) from [<c0159cac>]
(raw_notifier_call_chain+0x28/0x30)
[   19.751154]  r9:ffffffe0 r8:00000000 r7:00000000 r6:00000001
r5:ed365d5c r4:00000005
[   19.751221] [<c0159c84>] (raw_notifier_call_chain) from
[<c08e1734>] (call_netdevice_notifiers_info+0x3c/0x88)
[   19.751275] [<c08e16f8>] (call_netdevice_notifiers_info) from
[<c08f2184>] (register_netdevice+0x500/0x5e4)
[   19.751295]  r5:c1209888 r4:ed58d000
[   19.751317] [<c08f1c84>] (register_netdevice) from [<c08f2294>]
(register_netdev+0x2c/0x44)
[   19.751349]  r8:00000000 r7:e8de0760 r6:ed58d728 r5:ed58d000 r4:ed58d000
[   19.751856] [<c08f2268>] (register_netdev) from [<bf3ef620>]
(brcmf_net_attach+0x14c/0x194 [brcmfmac])
[   19.751883]  r5:ed58d000 r4:ed58d6c0
[   19.752375] [<bf3ef4d4>] (brcmf_net_attach [brcmfmac]) from
[<bf3f01f8>] (brcmf_attach+0x194/0x540 [brcmfmac])
[   19.752408]  r9:e97da600 r8:ed58d6c0 r7:e97abf80 r6:e8de2760
r5:00000000 r4:e8de0760
[   19.752817] [<bf3f0064>] (brcmf_attach [brcmfmac]) from
[<bf3ff8f0>] (brcmf_sdio_firmware_callback+0x720/0x838 [brcmfmac])
[   19.752841]  r10:e97ab340 r9:bf407b60 r8:ea26b800 r7:00000000
r6:c1209888 r5:ed593408
[   19.752857]  r4:e9560000
[   19.753259] [<bf3ff1d0>] (brcmf_sdio_firmware_callback [brcmfmac])
from [<bf3f12d4>] (brcmf_fw_request_done+0xbc/0x110 [brcmfmac])
[   19.753272] Adding 109752k swap on /dev/zram3.  Priority:5
extents:1 across:109752k SSFS
[   19.753293]  r10:00000001 r9:c1209888 r8:c12098a8 r7:ee4edb00
r6:ee4ea680 r5:00000000
[   19.753308]  r4:e97ab0c0
[   19.753569] [<bf3f1218>] (brcmf_fw_request_done [brcmfmac]) from
[<c06a8e10>] (request_firmware_work_func+0x5c/0x98)
[   19.753615]  r8:c12098a8 r7:ee4edb00 r6:ee4ea680 r5:c1209888 r4:e97aba40
[   19.753666] [<c06a8db4>] (request_firmware_work_func) from
[<c0150a88>] (process_one_work+0x304/0x7f4)
[   19.753703]  r5:edeb6b00 r4:e97aba40
[   19.753753] [<c0150784>] (process_one_work) from [<c0150fd4>]
(worker_thread+0x5c/0x5c4)
[   19.753792]  r10:c1206100 r9:00000008 r8:ffffe000 r7:ee4ea6bc
r6:edeb6b14 r5:ee4ea680
[   19.753810]  r4:edeb6b00
[   19.753839] [<c0150f78>] (worker_thread) from [<c0158368>]
(kthread+0x168/0x170)
[   19.753858]  r10:ede85e50 r9:c0150f78 r8:edeb6b00 r7:ed364000
r6:00000000 r5:ed2f0d80
[   19.753877]  r4:ed59a900
[   19.753928] [<c0158200>] (kthread) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[   19.753964] Exception stack(0xed365fb0 to 0xed365ff8)
[   19.754004] 5fa0:                                     00000000
00000000 00000000 00000000
[   19.754037] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   19.754056] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   19.754076]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c0158200
[   19.754091]  r4:ed2f0d80
[   19.785561] ---[ end trace c0485f03d4b7a6d9 ]---

The iw command also fails to produce anything useful:
root@ouya:~# iw wlan0 info
command failed: No buffer space available (-105)

With the following kernel log:
[  222.287296] ------------[ cut here ]------------
[  222.287885] WARNING: CPU: 2 PID: 812 at net/wireless/nl80211.c:3118
nl80211_send_chandef+0x178/0x180 [cfg80211]
[  222.287904] Modules linked in: cpufreq_conservative
cpufreq_userspace cpufreq_powersave brcmfmac zram tegra_drm
drm_kms_helper cfbfillrect syscopyarea cfg80211 cfbimgblt sysfillrect
sysimgblt fb_sys_fops hci_uart cfbcopyarea drm btbcm bluetooth
snd_soc_tegra30_i2s snd_soc_tegra_pcm ax88179_178a
drm_panel_orientation_quirks usbnet host1x mii sg brcmutil
snd_soc_tegra30_ahub tegra_wdt sch_fq_codel ip_tables x_tables autofs4
[  222.288054] CPU: 2 PID: 812 Comm: iw Tainted: G        W
5.3.0-next-20190926+ #34
[  222.288069] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[  222.288083] Backtrace:
[  222.288118] [<c010e934>] (dump_backtrace) from [<c010ec48>]
(show_stack+0x20/0x24)
[  222.288138]  r7:60010013 r6:c12cce70 r5:00000000 r4:c12cce70
[  222.288173] [<c010ec28>] (show_stack) from [<c0ad7998>]
(dump_stack+0x80/0x94)
[  222.288203] [<c0ad7918>] (dump_stack) from [<c012ec8c>] (__warn+0xec/0x104)
[  222.288221]  r7:00000009 r6:bf2738b8 r5:00000000 r4:00000000
[  222.288241] [<c012eba0>] (__warn) from [<c012ed5c>]
(warn_slowpath_fmt+0xb8/0xc0)
[  222.288260]  r9:00000009 r8:bf213d5c r7:00000c2e r6:bf2738b8
r5:00000000 r4:c1209888
[  222.288594] [<c012eca8>] (warn_slowpath_fmt) from [<bf213d5c>]
(nl80211_send_chandef+0x178/0x180 [cfg80211])
[  222.288616]  r9:e8de0360 r8:ffffffea r7:ea27d9c0 r6:c1209888
r5:ea27d9c0 r4:e8d87be0
[  222.289143] [<bf213be4>] (nl80211_send_chandef [cfg80211]) from
[<bf22eaf0>] (nl80211_send_iface+0xa78/0xb94 [cfg80211])
[  222.289164]  r8:d4c0032c r7:c12098a8 r6:e8d87be0 r5:ea27d9c0 r4:ed58f004
[  222.289684] [<bf22e078>] (nl80211_send_iface [cfg80211]) from
[<bf22f440>] (nl80211_get_interface+0x58/0x9c [cfg80211])
[  222.289705]  r10:e8d87d14 r9:c12bba00 r8:ea27d900 r7:ed58f004
r6:e8de0000 r5:ea27d9c0
[  222.289721]  r4:e8d87cb4
[  222.290004] [<bf22f3e8>] (nl80211_get_interface [cfg80211]) from
[<c0964fac>] (genl_rcv_msg+0x274/0x4e0)
[  222.290024]  r7:c1209888 r6:ea777014 r5:bf27a14c r4:bf26ff40
[  222.290045] [<c0964d38>] (genl_rcv_msg) from [<c0962de4>]
(netlink_rcv_skb+0xc8/0x120)
[  222.290065]  r10:c1209888 r9:00000000 r8:0000001c r7:ea777000
r6:c0964d38 r5:c1209888
[  222.290080]  r4:ea27d900
[  222.290099] [<c0962d1c>] (netlink_rcv_skb) from [<c096367c>]
(genl_rcv+0x34/0x44)
[  222.290118]  r8:e8d87d78 r7:ea27d900 r6:0000001c r5:ea27d900 r4:c12c2138
[  222.290138] [<c0963648>] (genl_rcv) from [<c0962618>]
(netlink_unicast+0x18c/0x208)
[  222.290153]  r5:e8cee800 r4:ecf99800
[  222.290173] [<c096248c>] (netlink_unicast) from [<c0962910>]
(netlink_sendmsg+0x27c/0x3ac)
[  222.290191]  r10:0000001c r9:00000000 r8:00000000 r7:e8cee800
r6:ea27d900 r5:c1209888
[  222.290206]  r4:e8d87f44
[  222.290236] [<c0962694>] (netlink_sendmsg) from [<c08c2ed8>]
(___sys_sendmsg+0x23c/0x25c)
[  222.290254]  r10:c0962694 r9:00000000 r8:e9dd0680 r7:00000000
r6:0000001c r5:c1209888
[  222.290269]  r4:e8d87f44
[  222.290293] [<c08c2c9c>] (___sys_sendmsg) from [<c08c44ec>]
(__sys_sendmsg+0x60/0x9c)
[  222.290313]  r10:00000128 r9:e8d86000 r8:c0101204 r7:e9dd0680
r6:00000000 r5:bec73440
[  222.290328]  r4:c1209888
[  222.290349] [<c08c448c>] (__sys_sendmsg) from [<c08c4544>]
(sys_sendmsg+0x1c/0x20)
[  222.290366]  r7:00000128 r6:00b0d668 r5:00b0d5b0 r4:0000006c
[  222.290388] [<c08c4528>] (sys_sendmsg) from [<c0101000>]
(ret_fast_syscall+0x0/0x54)
[  222.290404] Exception stack(0xe8d87fa8 to 0xe8d87ff0)
[  222.290423] 7fa0:                   0000006c 00b0d5b0 00000003
bec73440 00000000 00000000
[  222.290442] 7fc0: 0000006c 00b0d5b0 00b0d668 00000128 b6f00000
00b0d5b0 00000000 bec736d0
[  222.290459] 7fe0: 00000128 bec733f0 b6e7d73f b6dfb206
[  222.290701] ---[ end trace c0485f03d4b7a6db ]---
