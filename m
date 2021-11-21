Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCBF4583DC
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhKUNlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 08:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbhKUNlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 08:41:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B3C061574
        for <linux-wireless@vger.kernel.org>; Sun, 21 Nov 2021 05:38:08 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mon2k-0002Gr-1R; Sun, 21 Nov 2021 14:38:06 +0100
Message-ID: <60b9dbe3-852b-9e63-2857-0264d7093930@leemhuis.info>
Date:   Sun, 21 Nov 2021 14:38:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Bug/Regression - Ralink RT2800 kernel deference issue since
 kernel 5.14
Content-Language: en-BS
To:     Robert W <rwbugreport@lost-in-the-void.net>, xl@wp.pl,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     linux-wireless@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637501888;d5ad771c;
X-HE-SMSGID: 1mon2k-0002Gr-1R
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

CCing regression mailing list, which should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Also adding Helmut and Stanislaw (or just a different of his
addresses?), as afaics nothing happened since the report.

On 12.11.21 22:21, Robert W wrote:
> 
> I have recently tried to upgrade a system to run the 5.14 kernel and
> noticed that I was getting hangs on the system which seem to relate to
> this wireless dongle which I am running hostapd against to provide a
> small AP. Since that time kernel 5.15 was released and I have tested
> that kernel as well and the problem persists.  The issue sometimes
> occurs within an hour and other times it takes a few hours. I have tried
> to narrow down what is causing the issue.  I thought it might be a
> change elsewhere outside the mac80211/driver area so I tried to run the
> wireless backports 5.15-rc6 on top of the last stable kernel of 5.13 so
> as to have the smallest number of changes on the system. The backports
> crashes with the same error.  I have included below the netconsole
> output and the gdb of the kernel module in question. The capture was
> from when I was using the backports, but the error  is the same.  I hope
> the pastebins are okay to use on the list.  I did try to get some
> assistance on linux-wireless IRC and some one asked for the outputs I
> had for the information so I am reusing them here.
> 
> The following pastebin is the data sent to a netconsole instance.
> 
> https://pastebin.com/UxRrTtUh

FWIW, it's better to have these things inline, that makes them easier
accessible and makes sure they are archived properly (and thus are found
by a search). Hence quoting from there:

"""
> [36666.334518] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [36666.337718]  __ieee80211_tx+0x76/0x140 [mac80211]
> [36666.337718]  ieee80211_tx+0x105/0x150 [mac80211]
> [36666.337718]  ieee80211_tx_pending+0xbb/0x2d0 [mac80211]
> [36666.337718]  tasklet_action_common.constprop.0+0xbf/0x140
> [36666.337718]  __do_softirq+0xcd/0x2c1
> [36666.337718]  do_softirq+0x78/0x90
> [36666.337718]  </IRQ>
> [36666.337718]  __local_bh_enable_ip+0x56/0x60
> [36666.337718]  rt2x00lib_rxdone+0x2ea/0x5a0 [rt2x00lib]
> [36666.337718]  rt2x00usb_work_rxdone+0x6d/0xb0 [rt2x00usb]
> [36666.337718]  process_one_work+0x1e0/0x3b0
> [36666.337718]  worker_thread+0x50/0x3b0
> [36666.337718]  ? process_one_work+0x3b0/0x3b0
> [36666.337718]  kthread+0x130/0x160
> [36666.337718]  ? set_kthread_struct+0x40/0x40
> [36666.337718]  ret_from_fork+0x1f/0x30
> [36666.337718] Modules linked in: tcp_veno rt2800usb(OE) rt2800mmio(OE) rt2800lib(OE) rt
> 2500usb(OE) rt2x00usb(OE) rt2x00pci(OE) rt2x00mmio(OE) rt2x00lib(OE) mac80211(OE) cfg802
> 11(OE) compat(OE) netconsole ccm rfkill libarc4 xt_MASQUERADE iptable_nat nf_nat xt_tcpu
> dp xt_multiport xt_dscp xt_DSCP iptable_mangle xt_state xt_conntrack nf_conntrack sch_ca
> ke nf_defrag_ipv6 nf_defrag_ipv4 cls_u32 sch_ingress iptable_filter ip_set_hash_ip act_m
> irred ip_set ifb nfnetlink at24 iTCO_wdt gpio_ich intel_pmc_bxt iTCO_vendor_support snd_
> hda_codec_via snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_int
> el_sdw_acpi snd_hda_codec coretemp snd_hda_core i2c_i801 pcspkr i2c_smbus snd_hwdep snd_
> pcm snd_timer lpc_ich e1000 e1000e snd soundcore intel_agp mac_hid f71882fg fuse ip_tabl
> es x_tables xfs serio_raw atkbd libps2 xhci_pci i8042 serio i915 i2c_algo_bit intel_gtt 
> video drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm agpgart raid1
> 0 raid1 raid0 dm_raid raid456
> [36666.337718]  async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq 
> dm_mod md_mod libcrc32c crc32c_generic [last unloaded: cfg80211]
> [36666.337718] CR2: 0000000000000008
> [36666.337718] ---[ end trace 73629cbca2cb5f49 ]---
> [36666.337718] RIP: 0010:rt2x00queue_create_tx_descriptor+0x176/0x490 [rt2x00lib]
> 36666.337718] Code: 8b 8b c8 00 00 00 4d 85 e4 0f 84 cf 02 00 00 41 8b 84 24 58 01 00 0
> 0 89 45 18 41 0f b6 74 24 20 f6 43 32 01 0f 85 1e 02 00 00 <41> 0f b6 56 08 89 d0 66 89 
> 55 0c 83 c8 08 f6 43 31 80 0f 44 c2 66
> [36666.337718] RSP: 0018:ffffa95f80140ce0 EFLAGS: 00010246
> [36666.337718] RAX: 0000000000000021 RBX: ffff8f97b7828600 RCX: ffff8f981955045c
> [36666.337718] RDX: 0000000000013860 RSI: 0000000000000005 RDI: ffff8f98193d67e0
> [36666.337718] RBP: ffffa95f80140d20 R08: 0000000000000001 R09: 0000000000000000
> [36666.337718] R10: ffff8f9801ed5000 R11: ffffffff9b4060c0 R12: ffff8f9801ed5a58
> [36666.337718] R13: ffff8f98193d67e0 R14: 0000000000000000 R15: ffff8f9802890878
> [36666.337718] FS:  0000000000000000(0000) GS:ffff8f983bd00000(0000) knlGS:0000000000000
> 000
> [36666.337718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [36666.337718] CR2: 0000000000000008 CR3: 0000000101faa000 CR4: 00000000000006e0
> [36666.337718] Kernel panic - not syncing: Fatal exception in interrupt
> [36666.337718] Kernel Offset: 0x18a00000 from 0xffffffff81000000 (relocation range: 0xff
> ffffff80000000-0xffffffffbfffffff)
> [36666.337718] Rebooting in 5 seconds..
"""

> The gdb debug of the kernel module suggests this section of code.
> 
> https://pastebin.com/iMzxWEVU

To quote:
"""
> (gdb) list *(rt2x00queue_create_tx_descriptor+0x176)
> 0x37e6 is in rt2x00queue_create_tx_descriptor (/home/robert/backport/backports-5.15-rc6-1/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c:324).
> 319                      */
> 320                     if (sta && txdesc->u.ht.mcs > 7 &&
> 321                         sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
> 322                             __set_bit(ENTRY_TXD_HT_MIMO_PS, &txdesc->flags);
> 323             } else {
> 324                     txdesc->u.ht.mcs = rt2x00_get_rate_mcs(hwrate->mcs);
> 325                     if (txrate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
> 326                             txdesc->u.ht.mcs |= 0x08;
> 327             }
> 328
"""

> I am able to run further tests if required.  I am not a programmer, but
> I can usually apply code patches and build the resulting code. Please
> let me know if require any further information.

TWIMC: To be sure this issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.13..v5.14
#regzbot title Ralink RT2800 kernel deference issue since kernel 5.14
#regzbot ignore-activity

Ciao, Thorsten, your Linux kernel regression tracker.

P.S.: If you want to know more about regzbot, check out its
web-interface, the getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for the reporter: when reporting a regression it's in your interest
to tell #regzbot about it in the report, as that will ensure the
regression gets on the radar of regzbot and the regression tracker.
That's in your interest, as they will make sure the report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot, just
fix the issue as you normally would. Just remember to include a 'Link:'
tag to the report in the commit message, as explained in
Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c


P.P.S.: As a Linux kernel regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them.
Unfortunately therefore I sometimes will get things wrong or miss
something important. I hope that's not the case here; if you think it
is, don't hesitate to tell me about it in a public reply. That's in
everyone's interest, as what I wrote above might be misleading to
everyone reading this; any suggestion I gave they thus might sent
someone reading this down the wrong rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.
