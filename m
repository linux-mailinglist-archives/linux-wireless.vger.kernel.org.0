Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF83000C6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbhAVKxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 05:53:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbhAVKvi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 05:51:38 -0500
Received: from zn.tnic (p200300ec2f0c15009cec292803b5869f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1500:9cec:2928:3b5:869f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 218F61EC038E;
        Fri, 22 Jan 2021 11:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611312640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ANmG7SPY4D/B2yi0Pz6cCX7HbLTLX/WnobNHKajpG84=;
        b=mEdhOxZclbejvk070HcKTwvoP30O0/f1HrxRheV1SjmAtV5/U0wqVGJ7RJw6bSEpPPga+/
        dqTJ+YLrjdOLPSob3ro6zc064zpoeM1BbUALQzKO7OYnNHBWcmiEn2rb5WTgLNG+BRWulT
        5kfIt+yqjc4QmuGMmjO3Yll1vDQOLok=
Date:   Fri, 22 Jan 2021 11:50:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
Message-ID: <20210122105034.GF4867@zn.tnic>
References: <20210122101124.GE4867@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122101124.GE4867@zn.tnic>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 22, 2021 at 11:11:24AM +0100, Borislav Petkov wrote:
> Hi,
> 
> this triggers is on 5.11-rc3 + tip/x86/urgent (shouldn't matter tho),
> 32-bit kernel:

This looks like a multiple wireless drivers issue, this is on another
32-bit machine with ath5k this time:

[   23.810222] ath5k 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   23.847597] ath5k 0000:03:00.0: registered as 'phy0'
[   24.504999] ath: EEPROM regdomain: 0x65
[   24.516125] ath: EEPROM indicates we should expect a direct regpair map
[   24.527286] ath: Country alpha2 being used: 00
[   24.535435] ath: Regpair used: 0x65

[   24.551461] =============================
[   24.561941] WARNING: suspicious RCU usage
[   24.572030] 5.11.0-rc3+ #1 Not tainted
[   24.580276] -----------------------------
[   24.590764] net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
[   24.601730] 
               other info that might help us debug this:

[   24.625866] 
               rcu_scheduler_active = 2, debug_locks = 1
[   24.640870] 1 lock held by systemd-udevd/1134:
[   24.648773]  #0: c333e160 (&dev->mutex){....}-{3:3}, at: device_driver_attach+0x36/0xb0
[   24.656906] 
               stack backtrace:
[   24.671108] CPU: 0 PID: 1134 Comm: systemd-udevd Not tainted 5.11.0-rc3+ #1
[   24.671762] Hardware name: Acer AOA150/, BIOS v0.3309 10/06/2008
[   24.671762] Call Trace:
[   24.671762]  dump_stack+0x6d/0x8b
[   24.671762]  lockdep_rcu_suspicious+0xbb/0xc4
[   24.671762]  get_wiphy_regdom+0x5d/0x60 [cfg80211]
[   24.671762]  wiphy_apply_custom_regulatory+0xa0/0xe0 [cfg80211]
[   24.716225]  ath_regd_init.cold+0x7f/0xb0b [ath]
[   24.716225]  ? ath5k_ioread32+0x20/0x20 [ath5k]
[   24.716225]  ath5k_init_ah+0x953/0xbb0 [ath5k]
[   24.716225]  ath5k_pci_probe.cold+0x8f/0x10a [ath5k]
[   24.716225]  pci_device_probe+0x9c/0x110
[   24.716225]  really_probe+0xc6/0x300
[   24.716225]  driver_probe_device+0x49/0xa0
[   24.716225]  device_driver_attach+0xa9/0xb0
[   24.716225]  __driver_attach+0x46/0xb0
[   24.728122]  ? device_driver_attach+0xb0/0xb0
[   24.728122]  bus_for_each_dev+0x51/0x90
[   24.728122]  driver_attach+0x19/0x20
[   24.728122]  ? device_driver_attach+0xb0/0xb0
[   24.728122]  bus_add_driver+0xf0/0x1b0
[   24.728122]  driver_register+0x7c/0xd0
[   24.728122]  ? 0xf80af000
[   24.728122]  __pci_register_driver+0x52/0x60
[   24.728122]  ath5k_pci_driver_init+0x1c/0x1000 [ath5k]
[   24.728122]  do_one_initcall+0x5c/0x2e0
[   24.728122]  ? rcu_read_lock_sched_held+0x41/0x80
[   24.728122]  ? trace_kmalloc+0x53/0xe0
[   24.728122]  ? kmem_cache_alloc_trace+0xc8/0x170
[   24.728122]  ? do_init_module+0x21/0x250
[   24.774047]  do_init_module+0x50/0x250
[   24.774047]  load_module+0x2509/0x27b0
[   24.774047]  __ia32_sys_finit_module+0x85/0xb0
[   24.774047]  __do_fast_syscall_32+0x54/0x90
[   24.774047]  do_fast_syscall_32+0x29/0x60
[   24.774047]  do_SYSENTER_32+0x15/0x20
[   24.774047]  entry_SYSENTER_32+0x9f/0xf2
[   24.774047] EIP: 0xb7fc1549
[   24.774047] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   24.774047] EAX: ffffffda EBX: 00000010 ECX: b7da3bdd EDX: 00000000
[   24.774047] ESI: 01e757b0 EDI: 01e66420 EBP: 01e69590 ESP: bfc16fec
[   24.774047] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   24.891505] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   24.913211] ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
