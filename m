Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E34130579
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEBuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jan 2020 20:50:35 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:39249 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgAEBuf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jan 2020 20:50:35 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 402fb785
        for <linux-wireless@vger.kernel.org>;
        Sun, 5 Jan 2020 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=mail; bh=BzICo/
        M1bSAhtF+KKECfS2oBqOc=; b=L/tykdr0CTP/XQUuvIQ6vXWgdv4iulhVdBAryW
        Awk0By0RvATPvilmUaNxtDD4d6w0Rr6MLCHGjUQ3CxfQpc3/SWILFWhUB8fV45lQ
        rCNiPdKfqaipi/8MndK1xz6Hjc8JNc6Cec1Hval4dFfaSNckxb8tFqqeKwB1SuCg
        L1o1XBuzLd4vf5ybJ1f/9oXsy0YdXFgIGAwuV4nEGkzlZHZjCNQ2SNQEVkglvmoX
        9TjXUCJpE3HF98zF1UvQ49VZts98/VVfTe8Xu8HO1zaTLJujrNLYT9rtno0LP19t
        sXjC8C3tTNtNRs1kgZcKxWj/XREFeJ2QGGHHEJn4qstSTErg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ebd3e6dd (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-wireless@vger.kernel.org>;
        Sun, 5 Jan 2020 00:51:43 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id a15so66532203otf.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jan 2020 17:50:33 -0800 (PST)
X-Gm-Message-State: APjAAAW2kFrhfFgdyOuk0EW5Aa6m/7YdrN43nXYA85l9o/rsQ1IP0I4R
        E5gHeS6af/bzznuKDEiVyjEEzTkJ5yPrwWBxhxs=
X-Google-Smtp-Source: APXvYqwYnfEmhdwHOe74o77TkcL0H+4Hhck/2WOmnG1lKz7amPU8H4mta+b8tOBn00/9YNaHuRijqI4fNk9cShHP6f4=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr93888171otm.52.1578189032359;
 Sat, 04 Jan 2020 17:50:32 -0800 (PST)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 4 Jan 2020 20:50:21 -0500
X-Gmail-Original-Message-ID: <CAHmME9o69-6B+8NdKffYv84jz8AsHXhubXPSbvzKyZq=MRNn4A@mail.gmail.com>
Message-ID: <CAHmME9o69-6B+8NdKffYv84jz8AsHXhubXPSbvzKyZq=MRNn4A@mail.gmail.com>
Subject: various collected problems on AX200 and 5.5
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com, "Berg, Johannes" <johannes.berg@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've been running 5.5 for the last few weeks with a new computer
(Thinkpad P1 Gen 2) that has an AX200, and I've collected four
problems, described below. lspci is "52:00.0 0280: 8086:2723" and
kernel is 5.5-rc4 with nothing too fancy going on.

Regards,
Jason

1) This likely happens when wpa_supplicant runs but the card is rfkill'd:

[   15.376167] ------------[ cut here ]------------
[   15.376180] WARNING: CPU: 9 PID: 754 at net/wireless/nl80211.c:7035
nl80211_get_reg_do+0x1c0/0x1f0 [cfg80211]
[   15.376191] CPU: 9 PID: 754 Comm: wpa_supplicant Tainted: P     U
W  O      5.5.0-rc4+ #16
[   15.376192] Hardware name: LENOVO 20QTCTO1WW/20QTCTO1WW, BIOS
N2OET41W (1.28 ) 11/25/2019
[   15.376199] RIP: 0010:nl80211_get_reg_do+0x1c0/0x1f0 [cfg80211]
[   15.376200] Code: 24 0c 01 00 00 00 e8 0f 04 c2 df 85 c0 0f 84 15
ff ff ff eb a6 48 89 ef 48 89 04 24 e8 c9 29 f2 df 48 8b 04 24 e9 57
ff ff ff <0f> 0b 48 89 ef e8 b6 29 f2 df b8 ea ff ff ff e9 43 ff ff ff
e9 78
[   15.376200] RSP: 0018:ffff888fc108bb30 EFLAGS: 00010202
[   15.376201] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   15.376201] RDX: ffff888fb39c0008 RSI: 0000000000000000 RDI: ffff888fb39c0300
[   15.376201] RBP: ffff888ff322b400 R08: 0000000000000004 R09: ffff888fb5dee014
[   15.376202] R10: 0000000000000017 R11: ffffffffa180f570 R12: ffff888fc108bb88
[   15.376202] R13: 0000000000000000 R14: ffff888fb5dee014 R15: ffff888fb39c0300
[   15.376203] FS:  00007fdb93e89840(0000) GS:ffff888ffc440000(0000)
knlGS:0000000000000000
[   15.376203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.376204] CR2: 000055cfb6f62008 CR3: 0000000fbad30001 CR4: 00000000003606e0
[   15.376204] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   15.376204] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   15.376205] Call Trace:
[   15.376208]  ? _cond_resched+0x10/0x20
[   15.376209]  ? mutex_lock+0x9/0x30
[   15.376211]  genl_rcv_msg+0x183/0x3e0
[   15.376213]  ? genl_family_rcv_msg_attrs_parse+0x100/0x100
[   15.376213]  netlink_rcv_skb+0x32/0xf0
[   15.376214]  genl_rcv+0x1f/0x30
[   15.376215]  netlink_unicast+0x162/0x210
[   15.376216]  netlink_sendmsg+0x200/0x410
[   15.376217]  ? netlink_unicast+0x210/0x210
[   15.376218]  ____sys_sendmsg+0x1cb/0x1f0
[   15.376219]  ___sys_sendmsg+0x64/0x90
[   15.376220]  ? ___sys_recvmsg+0x71/0x90
[   15.376222]  ? __cgroup_bpf_run_filter_setsockopt+0x8a/0x270
[   15.376223]  __sys_sendmsg+0x44/0x80
[   15.376224]  do_syscall_64+0x3d/0x140
[   15.376225]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   15.376226] RIP: 0033:0x7fdb94686fa7
[   15.376227] Code: ff ff 90 48 83 ec 38 64 48 8b 04 25 28 00 00 00
48 89 44 24 28 31 c0 64 8b 04 25 18 00 00 00 85 c0 75 28 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 61 48 8b 4c 24 28 64 48 33 0c 25 28 00
00 00
[   15.376227] RSP: 002b:00007ffd6d95c0c0 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[   15.376228] RAX: ffffffffffffffda RBX: 000055cfb6ef4240 RCX: 00007fdb94686fa7
[   15.376228] RDX: 0000000000000000 RSI: 00007ffd6d95c130 RDI: 0000000000000004
[   15.376228] RBP: 000055cfb6ef4150 R08: 0000000000000004 R09: 000055cfb6ef0010
[   15.376229] R10: 00007ffd6d95c204 R11: 0000000000000246 R12: 000055cfb6f40da0
[   15.376229] R13: 00007ffd6d95c130 R14: 00007ffd6d95c204 R15: 000055cfb6f5fd20
[   15.376230] ---[ end trace deafa665c63b9280 ]---

2) Random crash after sending lots of data:

[86366.861713] iwlwifi 0000:52:00.0: Microcode SW error detected.
Restarting 0x0.
[86366.861800] iwlwifi 0000:52:00.0: Start IWL Error Log Dump:
[86366.861801] iwlwifi 0000:52:00.0: Status: 0x00000040, count: 6
[86366.861801] iwlwifi 0000:52:00.0: Loaded firmware version: 48.4fa0041f.0
[86366.861802] iwlwifi 0000:52:00.0: 0x00001043 | ADVANCED_SYSASSERT
[86366.861802] iwlwifi 0000:52:00.0: 0x05B0A2F0 | trm_hw_status0
[86366.861803] iwlwifi 0000:52:00.0: 0x00000000 | trm_hw_status1
[86366.861803] iwlwifi 0000:52:00.0: 0x004F8E3C | branchlink2
[86366.861804] iwlwifi 0000:52:00.0: 0x00000E26 | interruptlink1
[86366.861804] iwlwifi 0000:52:00.0: 0x00000E26 | interruptlink2
[86366.861804] iwlwifi 0000:52:00.0: 0x0000273C | data1
[86366.861805] iwlwifi 0000:52:00.0: 0x00004614 | data2
[86366.861805] iwlwifi 0000:52:00.0: 0x000000E0 | data3
[86366.861806] iwlwifi 0000:52:00.0: 0x3D00F541 | beacon time
[86366.861806] iwlwifi 0000:52:00.0: 0xE1F04AC4 | tsf low
[86366.861807] iwlwifi 0000:52:00.0: 0x000001EA | tsf hi
[86366.861807] iwlwifi 0000:52:00.0: 0x0000F4DE | time gp1
[86366.861807] iwlwifi 0000:52:00.0: 0x0E39EEB9 | time gp2
[86366.861808] iwlwifi 0000:52:00.0: 0x00000001 | uCode revision type
[86366.861808] iwlwifi 0000:52:00.0: 0x00000030 | uCode version major
[86366.861809] iwlwifi 0000:52:00.0: 0x4FA0041F | uCode version minor
[86366.861809] iwlwifi 0000:52:00.0: 0x00000340 | hw version
[86366.861809] iwlwifi 0000:52:00.0: 0x00489000 | board version
[86366.861810] iwlwifi 0000:52:00.0: 0x0526001C | hcmd
[86366.861810] iwlwifi 0000:52:00.0: 0xE7F23800 | isr0
[86366.861811] iwlwifi 0000:52:00.0: 0x01440000 | isr1
[86366.861811] iwlwifi 0000:52:00.0: 0x08F00112 | isr2
[86366.861811] iwlwifi 0000:52:00.0: 0x04C1FFDF | isr3
[86366.861812] iwlwifi 0000:52:00.0: 0x00000000 | isr4
[86366.861812] iwlwifi 0000:52:00.0: 0x0524001C | last cmd Id
[86366.861812] iwlwifi 0000:52:00.0: 0x00016CE0 | wait_event
[86366.861813] iwlwifi 0000:52:00.0: 0x000000C4 | l2p_control
[86366.861813] iwlwifi 0000:52:00.0: 0x00000020 | l2p_duration
[86366.861814] iwlwifi 0000:52:00.0: 0x00000007 | l2p_mhvalid
[86366.861814] iwlwifi 0000:52:00.0: 0x00000081 | l2p_addr_match
[86366.861814] iwlwifi 0000:52:00.0: 0x00000009 | lmpm_pmg_sel
[86366.861815] iwlwifi 0000:52:00.0: 0x00000000 | timestamp
[86366.861815] iwlwifi 0000:52:00.0: 0x0000B008 | flow_handler
[86366.861863] iwlwifi 0000:52:00.0: Start IWL Error Log Dump:
[86366.861863] iwlwifi 0000:52:00.0: Status: 0x00000040, count: 7
[86366.861864] iwlwifi 0000:52:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[86366.861864] iwlwifi 0000:52:00.0: 0x00000000 | umac branchlink1
[86366.861865] iwlwifi 0000:52:00.0: 0xC008CC3C | umac branchlink2
[86366.861865] iwlwifi 0000:52:00.0: 0x8048D0E6 | umac interruptlink1
[86366.861865] iwlwifi 0000:52:00.0: 0x8048D0E6 | umac interruptlink2
[86366.861866] iwlwifi 0000:52:00.0: 0x00000400 | umac data1
[86366.861866] iwlwifi 0000:52:00.0: 0x8048D0E6 | umac data2
[86366.861867] iwlwifi 0000:52:00.0: 0x00000000 | umac data3
[86366.861867] iwlwifi 0000:52:00.0: 0x00000030 | umac major
[86366.861867] iwlwifi 0000:52:00.0: 0x4FA0041F | umac minor
[86366.861868] iwlwifi 0000:52:00.0: 0x0E39EECF | frame pointer
[86366.861868] iwlwifi 0000:52:00.0: 0xC0886284 | stack pointer
[86366.861869] iwlwifi 0000:52:00.0: 0x00B0010C | last host cmd
[86366.861869] iwlwifi 0000:52:00.0: 0x00000000 | isr status reg
[86366.861883] iwlwifi 0000:52:00.0: Fseq Registers:
[86366.861885] iwlwifi 0000:52:00.0: 0xE0000101 | FSEQ_ERROR_CODE
[86366.861888] iwlwifi 0000:52:00.0: 0x00290008 | FSEQ_TOP_INIT_VERSION
[86366.861891] iwlwifi 0000:52:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
[86366.861893] iwlwifi 0000:52:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[86366.861896] iwlwifi 0000:52:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[86366.861899] iwlwifi 0000:52:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[86366.861901] iwlwifi 0000:52:00.0: 0x00100530 | FSEQ_CNVI_ID
[86366.861904] iwlwifi 0000:52:00.0: 0x00000532 | FSEQ_CNVR_ID
[86366.861907] iwlwifi 0000:52:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[86366.861911] iwlwifi 0000:52:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[86366.861916] iwlwifi 0000:52:00.0: 0x05B0905B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[86366.861921] iwlwifi 0000:52:00.0: 0x0000025B |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[86366.862044] iwlwifi 0000:52:00.0: Collecting data: trigger 2 fired.
[86366.862046] ieee80211 phy0: Hardware restart was requested
[86367.520284] iwlwifi 0000:52:00.0: Applying debug destination EXTERNAL_DRAM
[86367.688600] iwlwifi 0000:52:00.0: FW already configured (0) - re-configuring
[86367.699198] iwlwifi 0000:52:00.0: BIOS contains WGDS but no WRDS

3) Tethering to Android 10 Pixel 3 XL eventually stops working and
does the following. Only way of fixing is to unload/reload module:

Dec 31 09:39:36 thinkpad kernel: wlan0: authenticate with
mac-address-of-my-phone
Dec 31 09:39:36 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 1/3)
Dec 31 09:39:36 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:36 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:37 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 2/3)
Dec 31 09:39:37 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:37 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:38 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 3/3)
Dec 31 09:39:38 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:38 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:39 thinkpad kernel: wlan0: authentication with
mac-address-of-my-phone timed out
Dec 31 09:39:41 thinkpad wpa_supplicant[693981]: wlan0: SME: Trying to
authenticate with mac-address-of-my-phone (SSID='Vand>
Dec 31 09:39:41 thinkpad kernel: wlan0: authenticate with
mac-address-of-my-phone
Dec 31 09:39:41 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 1/3)
Dec 31 09:39:42 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:42 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:42 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 2/3)
Dec 31 09:39:42 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:42 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:43 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 3/3)
Dec 31 09:39:43 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:43 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:44 thinkpad kernel: wlan0: authentication with
mac-address-of-my-phone timed out
Dec 31 09:39:46 thinkpad wpa_supplicant[693981]: wlan0: SME: Trying to
authenticate with mac-address-of-my-phone (SSID='Vand>
Dec 31 09:39:46 thinkpad kernel: wlan0: authenticate with
mac-address-of-my-phone
Dec 31 09:39:46 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 1/3)
Dec 31 09:39:47 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:47 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:47 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 2/3)
Dec 31 09:39:47 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:47 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:48 thinkpad kernel: wlan0: send auth to
mac-address-of-my-phone (try 3/3)
Dec 31 09:39:48 thinkpad kernel: iwlwifi 0000:52:00.0: No beacon heard
and the time event is over already...
Dec 31 09:39:48 thinkpad kernel: wlan0: Connection to AP
mac-address-of-my-phone lost
Dec 31 09:39:49 thinkpad kernel: wlan0: authentication with
mac-address-of-my-phone timed out

4) Rebooting the system results in the wifi card not coming up.
Required to shutdown fully and then start.
