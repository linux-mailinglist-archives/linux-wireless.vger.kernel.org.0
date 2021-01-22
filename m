Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2272FFFE5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 11:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbhAVKMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 05:12:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54206 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbhAVKMK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 05:12:10 -0500
Received: from zn.tnic (p200300ec2f0c15009cec292803b5869f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1500:9cec:2928:3b5:869f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 380D21EC038E;
        Fri, 22 Jan 2021 11:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611310284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=KuR0JurgNLCRWZSDf2ICjGFU2nk9ZxAvoGYKGcS2z4o=;
        b=hJ6Hao82E1jmUL00V0uxO8wgpqwafN46J+BfC4wvtehuU2k8ozAyZDOk/0KaJzczlhK7YD
        b7wGlDQqKggRjtZp5MJ1gRHQysWzbIgx/7tpnIkmYMc46uAuUO6jAKgn1fT9F+DcyhWcdg
        9LpYYlQXLkyZIW1BgW9mrLrvP5xNPk8=
Date:   Fri, 22 Jan 2021 11:11:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
Message-ID: <20210122101124.GE4867@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

this triggers is on 5.11-rc3 + tip/x86/urgent (shouldn't matter tho),
32-bit kernel:

[   10.019444] rtl8192ce: Chip Version ID: B_CHIP_88C
[   10.042810] rtl8192ce: Using firmware rtlwifi/rtl8192cfw.bin

[   10.044258] =============================
[   10.044337] WARNING: suspicious RCU usage
[   10.044417] 5.11.0-rc3+ #1 Not tainted
[   10.044494] -----------------------------
[   10.044572] net/wireless/reg.c:144 suspicious rcu_dereference_check() usage!
[   10.044696] 
               other info that might help us debug this:

[   10.044833] 
               rcu_scheduler_active = 2, debug_locks = 1
[   10.044950] 1 lock held by udevd/301:
[   10.045025]  #0: c2ef8944 (&dev->mutex){....}-{3:3}, at: device_driver_attach+0x37/0xc0
[   10.045230] 
               stack backtrace:
[   10.045316] CPU: 0 PID: 301 Comm: udevd Not tainted 5.11.0-rc3+ #1
[   10.045428] Hardware name: LENOVO 30515QG/30515QG, BIOS 8RET30WW (1.12 ) 09/15/2011
[   10.045561] Call Trace:
[   10.045619]  dump_stack+0x6d/0x8b
[   10.045694]  lockdep_rcu_suspicious+0xbb/0xc4
[   10.045787]  get_wiphy_regdom+0x55/0x60 [cfg80211]
[   10.045995]  wiphy_apply_custom_regulatory+0xa4/0xe0 [cfg80211]
[   10.046191]  ? rtl_regd_init+0x180/0x180 [rtlwifi]
[   10.046299]  rtl_regd_init+0xd6/0x180 [rtlwifi]
[   10.046399]  rtl_init_core+0x1d7/0x910 [rtlwifi]
[   10.046500]  ? __const_udelay+0x35/0x40
[   10.046583]  rtl_pci_probe+0x776/0x1080 [rtl_pci]
[   10.046675]  ? _raw_spin_unlock_irqrestore+0x55/0x70
[   10.046770]  ? _raw_spin_unlock_irqrestore+0x38/0x70
[   10.046863]  ? __pm_runtime_resume+0x5a/0x90
[   10.046950]  ? trace_preempt_on+0x29/0xc0
[   10.047033]  ? __pm_runtime_resume+0x5a/0x90
[   10.047118]  ? preempt_count_sub+0xb9/0x110
[   10.047204]  ? _raw_spin_unlock_irqrestore+0x7/0x70
[   10.047297]  ? __pm_runtime_resume+0x5a/0x90
[   10.047383]  pci_device_probe+0xa4/0x110
[   10.047465]  ? sysfs_create_link+0x22/0x40
[   10.047551]  really_probe+0xd3/0x450
[   10.047625]  ? _raw_spin_unlock_irq+0x2d/0x50
[   10.047711]  driver_probe_device+0x5a/0x1b0
[   10.047793]  ? pci_match_device+0xbe/0xf0
[   10.047873]  ? preempt_count_sub+0xb9/0x110
[   10.047960]  device_driver_attach+0xb1/0xc0
[   10.048044]  __driver_attach+0x99/0x150
[   10.048122]  ? klist_next+0x93/0x140
[   10.048199]  ? device_driver_attach+0xc0/0xc0
[   10.048283]  bus_for_each_dev+0x5d/0xa0
[   10.048364]  driver_attach+0x1e/0x20
[   10.048437]  ? device_driver_attach+0xc0/0xc0
[   10.048521]  bus_add_driver+0x11f/0x1f0
[   10.048602]  driver_register+0x7f/0xd0
[   10.048681]  ? 0xf7f04000
[   10.048741]  __pci_register_driver+0x5c/0x70
[   10.048826]  rtl92ce_driver_init+0x1c/0x1000 [rtl8192ce]
[   10.048933]  do_one_initcall+0x5c/0x2f0
[   10.049012]  ? rcu_read_lock_sched_held+0x41/0x80
[   10.049105]  ? trace_kmalloc+0x53/0xf0
[   10.049184]  ? kmem_cache_alloc_trace+0xdf/0x1b0
[   10.049273]  ? do_init_module+0x24/0x260
[   10.049354]  do_init_module+0x53/0x260
[   10.049433]  load_module+0x2525/0x2b10
[   10.049517]  ? kernel_read+0x3e/0x50
[   10.049600]  __ia32_sys_finit_module+0xbd/0x120
[   10.049698]  __do_fast_syscall_32+0x54/0x80
[   10.049781]  do_fast_syscall_32+0x30/0x70
[   10.049861]  do_SYSENTER_32+0x15/0x20
[   10.049936]  entry_SYSENTER_32+0x9f/0xf2
[   10.050016] EIP: 0xb7f46549
[   10.050079] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   10.050376] EAX: ffffffda EBX: 0000000f ECX: b7ce5e63 EDX: 00000000
[   10.050486] ESI: 00bf8ed0 EDI: 00beb080 EBP: 00bf7f50 ESP: bfef492c
[   10.050596] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   10.060833] ieee80211 phy0: Selected rate control algorithm 'rtl_rc'
[   10.066096] rtlwifi: rtlwifi: wireless switch is on

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
