Return-Path: <linux-wireless+bounces-8187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E15F88D18CA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A85DB22488
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAD16B72D;
	Tue, 28 May 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhxWmjdn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F881139D11;
	Tue, 28 May 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892949; cv=none; b=LCJvK2y9oXgVbd04rt9j/of+Mgqlg3zuv/1QQEdfxyCgwoPWiP2uYJ4DCWAwXvq9MTY2fsugmFHXm+ZNi7rvz64bguz27qegkyCCHXJmEybm8QR2mCkNE9IjbBlrXu4/NMrpv8yHILhHzTVBo11hTDZQ+dGfoDjtcODrf35dU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892949; c=relaxed/simple;
	bh=8J9hQm3ZFvkpqFo6mwiD3UURQa/kcfAyc7iT/eX3KR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cxAw5dTGB8XEWqvkfT1QfteAs5OdL4A8A9++YCuljzE/Xwc5RXjOmAREuFTKPMCdUdxvfOTxnBhmZE9yyzijJS1olvJPhKRrGw0oB+ou/cF0rgAWcKFVmQgNkUJ3IN3IWV/MTTSu1RQZ5V9delCESfHk4irnb3oZn8jIthScAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhxWmjdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A68DC3277B;
	Tue, 28 May 2024 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716892948;
	bh=8J9hQm3ZFvkpqFo6mwiD3UURQa/kcfAyc7iT/eX3KR4=;
	h=From:To:Cc:Subject:Date:From;
	b=MhxWmjdnylL9/vP4QuTzEUq82dpWyQzJhZi4fFmEm5bL+kAb39HNze8i2SZDMBdQY
	 eD5CgF4w1bJvaL7nVL8i3iBV+uxYHLHhZGGfECQeObZWBVSUw9abMTp1uhMiw6oELw
	 GhtZYNHbY5QFbwzUAWD1tfcqoQ8T5STzSYY3rEAUa6kxm1SOiGKUtGpPy+FdOYZuA9
	 h7CQu1Et2bt4ruFKXj7n6wnJxtebgpOXawfziTVX/VGFclFqoICYtDeKWxUQu2ythN
	 JOB2yJAMcDZXqq3uHuwLtFSL7Yv/SRrwwdKKSQidtECq6IP+Z+DQPFHHCLa4/zXIHR
	 3nTpzhhwxaejw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
    regressions@lists.linux.dev,
    Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
Date: Tue, 28 May 2024 13:42:25 +0300
Message-ID: <87v82y6wvi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Yesterday I run our ath11k regression tests with v6.10-rc1 and our
simple ath11k module reload stress started failing reliably with various
KASAN errors. The test removes and inserts ath11k and other wireless
modules in a loop. Usually I run it at least 100 times, some times even
more, and no issues until yesterday.

I have verified that the last wireless-next pull request (tag
wireless-next-2024-05-08) works without issues and v6.10-rc1 fails
always, usually within 50 module reload loops. From this I'm _guessing_
that we have a regression outside wireless, most probably introduced
between v6.9 and v6.10-rc1. But of course I cannot be sure of anything
yet.

I see different KASAN warnings and lockdep seems to be always visible in
the stack traces. I think I can reproduce the issue within 15 minutes or
so. Before I start bisecting has anyone else seen anything similar? Or
any suggestions how to debug this further?

I have included some crash logs below, they are retrieved using
netconsole. Here's a summary of the errors:

[  159.970765] KASAN: maybe wild-memory-access in range [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
[  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
[  224.695821] BUG: KASAN: slab-out-of-bounds in lockdep_register_key+0x755/0x8f0
[  259.666542] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x755/0x8f0

Kalle

Crash 1:

[  159.952138] ath11k_pci 0000:06:00.0: wcn6855 hw2.0
[  159.970683] Oops: general protection fault, probably for non-canonical address 0xf777737777777777: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  159.970765] KASAN: maybe wild-memory-access in range [0xbbbbbbbbbbbbbbb8-0xbbbbbbbbbbbbbbbf]
[  159.970839] CPU: 0 PID: 1182 Comm: insmod Not tainted 6.10.0-rc1 #1547
[  159.970909] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  159.971000] RIP: 0010:lockdep_register_key+0x1c8/0x8f0
[  159.971082] Code: 05 00 00 48 8b 1c cd 60 45 3c af 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 <80> 3c 30 00 0f 85 74 05 00 00 48 8b 1b 48 85 db 0f 84 ff 01 00 00
[  159.971199] RSP: 0018:ffffc900013d74e0 EFLAGS: 00010806
[  159.971263] RAX: 1777777777777777 RBX: bbbbbbbbbbbbbbbb RCX: 00000000000009f2
[  159.971318] RDX: ffffffff9ea1ceb8 RSI: dffffc0000000000 RDI: ffffc900013d7518
[  159.971370] RBP: ffffc900013d7580 R08: 0000000000000001 R09: fffff5200027aea3
[  159.971421] R10: 0000000000000003 R11: 0000000000000000 R12: ffff888138b8c438
[  159.971471] R13: 1ffff9200027ae9f R14: dffffc0000000000 R15: ffffffffaf5cf9c0
[  159.971523] FS:  00007f1f2ed81740(0000) GS:ffff888231800000(0000) knlGS:0000000000000000
[  159.971577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  159.971624] CR2: 0000558d3b24e308 CR3: 000000012eb03002 CR4: 00000000003706f0
[  159.971674] Call Trace:
[  159.971712]  <TASK>
[  159.971748]  ? show_regs+0x5b/0x70
[  159.971791]  ? die_addr+0x3c/0xa0
[  159.971832]  ? exc_general_protection+0x150/0x230
[  159.971879]  ? asm_exc_general_protection+0x27/0x30
[  159.971971]  ? lockdep_register_key+0x1c8/0x8f0
[  159.972018]  ? save_trace+0x720/0x720
[  159.972059]  ? dma_alloc_attrs+0x145/0x1d0
[  159.972102]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  159.972173]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  159.972224]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  159.972272]  ? __this_cpu_preempt_check+0x13/0x20
[  159.972320]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  159.972367]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  159.972415]  local_pci_probe+0xd6/0x180
[  159.972458]  pci_call_probe+0x152/0x3f0
[  159.972500]  ? __kasan_check_read+0x11/0x20
[  159.972544]  ? pci_pm_suspend_late+0x40/0x40
[  159.972589]  ? pci_match_device+0x380/0x660
[  159.972634]  pci_device_probe+0xa6/0x100
[  159.972675]  really_probe+0x1d5/0x920
[  159.972717]  __driver_probe_device+0x2e8/0x3f0
[  159.972761]  driver_probe_device+0x4a/0x140
[  159.972803]  __driver_attach+0x1ed/0x4c0
[  159.972844]  ? __device_attach_driver+0x290/0x290
[  159.972906]  bus_for_each_dev+0xf5/0x180
[  159.972961]  ? bus_remove_file+0x40/0x40
[  159.973002]  ? _raw_spin_unlock+0x27/0x50
[  159.973044]  driver_attach+0x38/0x50
[  159.973084]  bus_add_driver+0x29b/0x5e0
[  159.973137]  driver_register+0x130/0x450
[  159.973182]  __pci_register_driver+0x1d2/0x270
[  159.973226]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  159.973276]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  159.973325]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  159.973373]  do_one_initcall+0xdf/0x500
[  159.974122]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  159.974832]  ? kasan_save_alloc_info+0x37/0x40
[  159.975560]  ? __kasan_kmalloc+0x90/0xa0
[  159.976287]  ? kasan_unpoison+0x45/0x70
[  159.977027]  ? kasan_poison+0x3a/0x50
[  159.977713]  ? __asan_register_globals+0x5e/0x70
[  159.978436]  do_init_module+0x23f/0x6c0
[  159.979160]  load_module+0x11e3/0x1aa0
[  159.979833]  init_module_from_file+0xe4/0x140
[  159.980539]  ? __ia32_sys_init_module+0xa0/0xa0
[  159.981260]  ? __kasan_check_read+0x11/0x20
[  159.982011]  ? do_raw_spin_unlock+0x54/0x220
[  159.982653]  idempotent_init_module+0x265/0x750
[  159.983322]  ? init_module_from_file+0x140/0x140
[  159.983987]  ? __kasan_check_read+0x11/0x20
[  159.984593]  __x64_sys_finit_module+0xbb/0x130
[  159.985221]  x64_sys_call+0x1c5/0x9e0
[  159.985784]  do_syscall_64+0x64/0x130
[  159.986375]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  159.986974] RIP: 0033:0x7f1f2eec795d
[  159.987558] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  159.988707] RSP: 002b:00007fff06ddf4d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  159.989325] RAX: ffffffffffffffda RBX: 000055f0e42647c0 RCX: 00007f1f2eec795d
[  159.989921] RDX: 0000000000000000 RSI: 000055f0ba5e2358 RDI: 0000000000000003
[  159.990521] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f1f2ef9e580
[  159.991138] R10: 0000000000000003 R11: 0000000000000246 R12: 000055f0ba5e2358
[  159.991699] R13: 0000000000000000 R14: 000055f0e4264790 R15: 0000000000000000
[  159.992317]  </TASK>
[  159.992876] Modules linked in: ath11k_pci(+) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
[  159.993568] ---[ end trace 0000000000000000 ]---
[  160.131323] RIP: 0010:lockdep_register_key+0x1c8/0x8f0
[  160.131999] Code: 05 00 00 48 8b 1c cd 60 45 3c af 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 <80> 3c 30 00 0f 85 74 05 00 00 48 8b 1b 48 85 db 0f 84 ff 01 00 00
[  160.133318] RSP: 0018:ffffc900013d74e0 EFLAGS: 00010806
[  160.134034] RAX: 1777777777777777 RBX: bbbbbbbbbbbbbbbb RCX: 00000000000009f2
[  160.134705] RDX: ffffffff9ea1ceb8 RSI: dffffc0000000000 RDI: ffffc900013d7518
[  160.135417] RBP: ffffc900013d7580 R08: 0000000000000001 R09: fffff5200027aea3
[  160.136136] R10: 0000000000000003 R11: 0000000000000000 R12: ffff888138b8c438
[  160.136809] R13: 1ffff9200027ae9f R14: dffffc0000000000 R15: ffffffffaf5cf9c0
[  160.137519] FS:  00007f1f2ed81740(0000) GS:ffff888231800000(0000) knlGS:0000000000000000
[  160.138248] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  160.138954] CR2: 0000558d3b24e308 CR3: 000000012eb03002 CR4: 00000000003706f0
[  160.139671] Kernel panic - not syncing: Fatal exception
[  160.140435] Kernel Offset: 0x18e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Crash 2:

[  699.996725] ath11k_pci 0000:06:00.0: wcn6855 hw2.0
[  700.016765] ==================================================================
[  700.017632] BUG: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
[  700.018501] Read of size 8 at addr ffff88810fe71870 by task insmod/9675
[  700.019375] 
[  700.020249] CPU: 3 PID: 9675 Comm: insmod Not tainted 6.10.0-rc1 #1543
[  700.021138] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  700.022040] Call Trace:
[  700.022878]  <TASK>
[  700.023696]  dump_stack_lvl+0x7d/0xe0
[  700.024549]  print_address_description.constprop.0+0x33/0x3a0
[  700.025412]  print_report+0xb5/0x260
[  700.026258]  ? kasan_addr_to_slab+0x24/0x80
[  700.027108]  kasan_report+0xd8/0x110
[  700.027950]  ? lockdep_register_key+0x755/0x8f0
[  700.028748]  ? lockdep_register_key+0x755/0x8f0
[  700.029585]  __asan_report_load8_noabort+0x14/0x20
[  700.030427]  lockdep_register_key+0x755/0x8f0
[  700.031239]  ? save_trace+0x720/0x720
[  700.032027]  ? dma_alloc_attrs+0x145/0x1d0
[  700.032780]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  700.033601]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  700.034399]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  700.035223]  ? __this_cpu_preempt_check+0x13/0x20
[  700.036029]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  700.036782]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  700.037570]  local_pci_probe+0xd6/0x180
[  700.038351]  pci_call_probe+0x152/0x3f0
[  700.039402]  ? __kasan_check_read+0x11/0x20
[  700.040800]  ? pci_pm_suspend_late+0x40/0x40
[  700.041576]  ? pci_match_device+0x380/0x660
[  700.042352]  pci_device_probe+0xa6/0x100
[  700.043127]  really_probe+0x1d5/0x920
[  700.043878]  __driver_probe_device+0x2e8/0x3f0
[  700.044609]  driver_probe_device+0x4a/0x140
[  700.045356]  __driver_attach+0x1ed/0x4c0
[  700.046082]  ? __device_attach_driver+0x290/0x290
[  700.046745]  bus_for_each_dev+0xf5/0x180
[  700.047472]  ? bus_remove_file+0x40/0x40
[  700.048198]  ? _raw_spin_unlock+0x27/0x50
[  700.048911]  driver_attach+0x38/0x50
[  700.050381]  bus_add_driver+0x29b/0x5e0
[  700.051097]  driver_register+0x130/0x450
[  700.051746]  __pci_register_driver+0x1d2/0x270
[  700.052450]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  700.053159]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  700.053789]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  700.054488]  do_one_initcall+0xdf/0x500
[  700.055183]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  700.055829]  ? kasan_save_alloc_info+0x37/0x40
[  700.056534]  ? __kasan_kmalloc+0x90/0xa0
[  700.057218]  ? kasan_unpoison+0x45/0x70
[  700.057834]  ? kasan_poison+0x3a/0x50
[  700.058465]  ? __asan_register_globals+0x5e/0x70
[  700.059115]  do_init_module+0x23f/0x6c0
[  700.059717]  load_module+0x11e3/0x1aa0
[  700.060373]  init_module_from_file+0xe4/0x140
[  700.061034]  ? __ia32_sys_init_module+0xa0/0xa0
[  700.061631]  ? __kasan_check_read+0x11/0x20
[  700.062277]  ? do_raw_spin_unlock+0x54/0x220
[  700.062882]  idempotent_init_module+0x265/0x750
[  700.063486]  ? init_module_from_file+0x140/0x140
[  700.064116]  ? __kasan_check_read+0x11/0x20
[  700.064671]  __x64_sys_finit_module+0xbb/0x130
[  700.065294]  x64_sys_call+0x1c5/0x9e0
[  700.065878]  do_syscall_64+0x64/0x130
[  700.066450]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  700.067059] RIP: 0033:0x7f1039e4195d
[  700.067603] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  700.068785] RSP: 002b:00007ffc40b5d918 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  700.069418] RAX: ffffffffffffffda RBX: 00005609ae2a57c0 RCX: 00007f1039e4195d
[  700.070063] RDX: 0000000000000000 RSI: 00005609a145c358 RDI: 0000000000000003
[  700.070643] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f1039f18580
[  700.071282] R10: 0000000000000003 R11: 0000000000000246 R12: 00005609a145c358
[  700.071885] R13: 0000000000000000 R14: 00005609ae2a5790 R15: 0000000000000000
[  700.072492]  </TASK>
[  700.073129] 
[  700.073695] The buggy address belongs to the physical page:
[  700.074336] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x8 pfn:0x10fe71
[  700.074997] flags: 0x200000000000000(node=0|zone=2)
[  700.075591] raw: 0200000000000000 dead000000000100 dead000000000122 0000000000000000
[  700.076256] raw: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  700.076889] page dumped because: kasan: bad access detected
[  700.077521] 
[  700.078177] Memory state around the buggy address:
[  700.078782]  ffff88810fe71700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  700.079458]  ffff88810fe71780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  700.080129] >ffff88810fe71800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  700.080730]                                                              ^
[  700.081393]  ffff88810fe71880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  700.082069]  ffff88810fe71900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  700.082675] ==================================================================
[  700.083351] Disabling lock debugging due to kernel taint
[  700.084030] BUG: unable to handle page fault for address: ffff88810fe71870
[  700.084657] #PF: supervisor read access in kernel mode
[  700.085341] #PF: error_code(0x0000) - not-present page
[  700.086027] PGD 24be01067 P4D 24be01067 PUD 27ea1a067 PMD 27e99a067 PTE 800ffffef018e060
[  700.086677] Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  700.087380] CPU: 3 PID: 9675 Comm: insmod Tainted: G    B              6.10.0-rc1 #1543
[  700.088094] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  700.088777] RIP: 0010:lockdep_register_key+0x1d2/0x8f0
[  700.089511] Code: a6 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 80 3c 30 00 0f 85 74 05 00 00 <48> 8b 1b 48 85 db 0f 84 ff 01 00 00 49 39 dc 75 de 0f 0b 48 b8 00
[  700.091027] RSP: 0018:ffffc90001f974e0 EFLAGS: 00010082
[  700.091752] RAX: 0000000000000001 RBX: ffff88810fe71870 RCX: 0000000000000a51
[  700.092539] RDX: ffffffff9601ceb8 RSI: dffffc0000000000 RDI: ffffffff96498420
[  700.093360] RBP: ffffc90001f97580 R08: 0000000000000001 R09: fffffbfff2c93084
[  700.094152] R10: ffffffff96498427 R11: 0000000000000001 R12: ffff88812ef4bf58
[  700.094957] R13: 1ffff920003f2e9f R14: dffffc0000000000 R15: ffffffffa6bcf9c0
[  700.096987] FS:  00007f1039cfb740(0000) GS:ffff88821c400000(0000) knlGS:0000000000000000
[  700.097743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  700.098533] CR2: ffff88810fe71870 CR3: 000000011139b001 CR4: 00000000003706f0
[  700.099351] Call Trace:
[  700.100155]  <TASK>
[  700.100984]  ? show_regs+0x5b/0x70
[  700.101742]  ? __die+0x1f/0x60
[  700.102546]  ? page_fault_oops+0x121/0x260
[  700.103351]  ? show_fault_oops+0x6e0/0x6e0
[  700.104153]  ? search_module_extables+0xb5/0xf0
[  700.104942]  ? lockdep_register_key+0x1d2/0x8f0
[  700.105686]  ? search_exception_tables+0x4a/0x50
[  700.106490]  ? fixup_exception+0x48/0x8e0
[  700.107292]  ? vprintk+0x29/0x30
[  700.108092]  ? kernelmode_fixup_or_oops.isra.0+0x7a/0x90
[  700.108864]  ? __bad_area_nosemaphore+0x256/0x580
[  700.109628]  ? trace_irq_disable+0x3d/0x140
[  700.110438]  ? bad_area_nosemaphore+0x11/0x20
[  700.111240]  ? do_kern_addr_fault+0xa7/0xc0
[  700.112052]  ? exc_page_fault+0xbc/0xc0
[  700.112798]  ? asm_exc_page_fault+0x27/0x30
[  700.113602]  ? lockdep_register_key+0x1d2/0x8f0
[  700.114386]  ? save_trace+0x720/0x720
[  700.115146]  ? dma_alloc_attrs+0x145/0x1d0
[  700.115914]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  700.116630]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  700.117366]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  700.118119]  ? __this_cpu_preempt_check+0x13/0x20
[  700.118816]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  700.119565]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  700.120315]  local_pci_probe+0xd6/0x180
[  700.121055]  pci_call_probe+0x152/0x3f0
[  700.121742]  ? __kasan_check_read+0x11/0x20
[  700.122482]  ? pci_pm_suspend_late+0x40/0x40
[  700.123216]  ? pci_match_device+0x380/0x660
[  700.123944]  pci_device_probe+0xa6/0x100
[  700.124613]  really_probe+0x1d5/0x920
[  700.125332]  __driver_probe_device+0x2e8/0x3f0
[  700.126047]  driver_probe_device+0x4a/0x140
[  700.126705]  __driver_attach+0x1ed/0x4c0
[  700.127412]  ? __device_attach_driver+0x290/0x290
[  700.128126]  bus_for_each_dev+0xf5/0x180
[  700.128789]  ? bus_remove_file+0x40/0x40
[  700.129499]  ? _raw_spin_unlock+0x27/0x50
[  700.130204]  driver_attach+0x38/0x50
[  700.130895]  bus_add_driver+0x29b/0x5e0
[  700.131556]  driver_register+0x130/0x450
[  700.132252]  __pci_register_driver+0x1d2/0x270
[  700.132943]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  700.133581]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  700.134269]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  700.134949]  do_one_initcall+0xdf/0x500
[  700.135562]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  700.136235]  ? kasan_save_alloc_info+0x37/0x40
[  700.136874]  ? __kasan_kmalloc+0x90/0xa0
[  700.137483]  ? kasan_unpoison+0x45/0x70
[  700.138102]  ? kasan_poison+0x3a/0x50
[  700.138647]  ? __asan_register_globals+0x5e/0x70
[  700.139241]  do_init_module+0x23f/0x6c0
[  700.139782]  load_module+0x11e3/0x1aa0
[  700.140371]  init_module_from_file+0xe4/0x140
[  700.140953]  ? __ia32_sys_init_module+0xa0/0xa0
[  700.141479]  ? __kasan_check_read+0x11/0x20
[  700.142057]  ? do_raw_spin_unlock+0x54/0x220
[  700.142572]  idempotent_init_module+0x265/0x750
[  700.143137]  ? init_module_from_file+0x140/0x140
[  700.143647]  ? __kasan_check_read+0x11/0x20
[  700.144198]  __x64_sys_finit_module+0xbb/0x130
[  700.144699]  x64_sys_call+0x1c5/0x9e0
[  700.145254]  do_syscall_64+0x64/0x130
[  700.145754]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  700.146319] RIP: 0033:0x7f1039e4195d
[  700.146831] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  700.148018] RSP: 002b:00007ffc40b5d918 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  700.148592] RAX: ffffffffffffffda RBX: 00005609ae2a57c0 RCX: 00007f1039e4195d
[  700.149210] RDX: 0000000000000000 RSI: 00005609a145c358 RDI: 0000000000000003
[  700.149789] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f1039f18580
[  700.150421] R10: 0000000000000003 R11: 0000000000000246 R12: 00005609a145c358
[  700.151053] R13: 0000000000000000 R14: 00005609ae2a5790 R15: 0000000000000000
[  700.151632]  </TASK>
[  700.152261] Modules linked in: ath11k_pci(+) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core [last unloaded: mhi]
[  700.152949] CR2: ffff88810fe71870
[  700.153555] ---[ end trace 0000000000000000 ]---
[  700.288393] RIP: 0010:lockdep_register_key+0x1d2/0x8f0
[  700.289147] Code: a6 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 80 3c 30 00 0f 85 74 05 00 00 <48> 8b 1b 48 85 db 0f 84 ff 01 00 00 49 39 dc 75 de 0f 0b 48 b8 00
[  700.290484] RSP: 0018:ffffc90001f974e0 EFLAGS: 00010082
[  700.291200] RAX: 0000000000000001 RBX: ffff88810fe71870 RCX: 0000000000000a51
[  700.291909] RDX: ffffffff9601ceb8 RSI: dffffc0000000000 RDI: ffffffff96498420
[  700.292591] RBP: ffffc90001f97580 R08: 0000000000000001 R09: fffffbfff2c93084
[  700.293315] R10: ffffffff96498427 R11: 0000000000000001 R12: ffff88812ef4bf58
[  700.294029] R13: 1ffff920003f2e9f R14: dffffc0000000000 R15: ffffffffa6bcf9c0
[  700.294698] FS:  00007f1039cfb740(0000) GS:ffff88821c400000(0000) knlGS:0000000000000000
[  700.295430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  700.296162] CR2: ffff88810fe71870 CR3: 000000011139b001 CR4: 00000000003706f0
[  700.296877] Kernel panic - not syncing: Fatal exception
[  700.297623] Kernel Offset: 0x10400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Crash 3:

[  224.681700] ath11k_pci 0000:06:00.0: wcn6855 hw2.0
[  224.695019] ==================================================================
[  224.695821] BUG: KASAN: slab-out-of-bounds in lockdep_register_key+0x755/0x8f0
[  224.696644] Read of size 8 at addr ffff88810d771870 by task insmod/3533
[  224.697486] 
[  224.698323] CPU: 5 PID: 3533 Comm: insmod Not tainted 6.10.0-rc1 #1543
[  224.699188] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  224.700074] Call Trace:
[  224.700962]  <TASK>
[  224.701776]  dump_stack_lvl+0x7d/0xe0
[  224.702620]  print_address_description.constprop.0+0x33/0x3a0
[  224.703468]  print_report+0xb5/0x260
[  224.704363]  ? kasan_complete_mode_report_info+0x64/0x1a0
[  224.705205]  kasan_report+0xd8/0x110
[  224.706077]  ? lockdep_register_key+0x755/0x8f0
[  224.706929]  ? lockdep_register_key+0x755/0x8f0
[  224.707736]  __asan_report_load8_noabort+0x14/0x20
[  224.708576]  lockdep_register_key+0x755/0x8f0
[  224.709397]  ? save_trace+0x720/0x720
[  224.710199]  ? dma_alloc_attrs+0x145/0x1d0
[  224.711034]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  224.711848]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  224.712649]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.713461]  ? __this_cpu_preempt_check+0x13/0x20
[  224.714270]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  224.715078]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.715900]  local_pci_probe+0xd6/0x180
[  224.716658]  pci_call_probe+0x152/0x3f0
[  224.717437]  ? __kasan_check_read+0x11/0x20
[  224.718216]  ? pci_pm_suspend_late+0x40/0x40
[  224.719007]  ? pci_match_device+0x380/0x660
[  224.719749]  pci_device_probe+0xa6/0x100
[  224.720553]  really_probe+0x1d5/0x920
[  224.721309]  __driver_probe_device+0x2e8/0x3f0
[  224.722059]  driver_probe_device+0x4a/0x140
[  224.722741]  __driver_attach+0x1ed/0x4c0
[  224.723461]  ? __device_attach_driver+0x290/0x290
[  224.724177]  bus_for_each_dev+0xf5/0x180
[  224.724878]  ? bus_remove_file+0x40/0x40
[  224.725542]  ? _raw_spin_unlock+0x27/0x50
[  224.726258]  driver_attach+0x38/0x50
[  224.726966]  bus_add_driver+0x29b/0x5e0
[  224.727616]  driver_register+0x130/0x450
[  224.728314]  __pci_register_driver+0x1d2/0x270
[  224.729009]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.729651]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.730334]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  224.731019]  do_one_initcall+0xdf/0x500
[  224.731649]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  224.732338]  ? kasan_save_alloc_info+0x37/0x40
[  224.733025]  ? __kasan_kmalloc+0x90/0xa0
[  224.733652]  ? kasan_unpoison+0x45/0x70
[  224.734312]  ? kasan_poison+0x3a/0x50
[  224.734946]  ? __asan_register_globals+0x5e/0x70
[  224.735535]  do_init_module+0x23f/0x6c0
[  224.736174]  load_module+0x11e3/0x1aa0
[  224.736764]  init_module_from_file+0xe4/0x140
[  224.737408]  ? __ia32_sys_init_module+0xa0/0xa0
[  224.738045]  ? __kasan_check_read+0x11/0x20
[  224.738621]  ? do_raw_spin_unlock+0x54/0x220
[  224.739246]  idempotent_init_module+0x265/0x750
[  224.739848]  ? init_module_from_file+0x140/0x140
[  224.740425]  ? __kasan_check_read+0x11/0x20
[  224.741031]  __x64_sys_finit_module+0xbb/0x130
[  224.741592]  x64_sys_call+0x1c5/0x9e0
[  224.742195]  do_syscall_64+0x64/0x130
[  224.742739]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  224.743334] RIP: 0033:0x7f0b4a71895d
[  224.743924] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  224.745095] RSP: 002b:00007ffd47fdbb88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  224.745666] RAX: ffffffffffffffda RBX: 0000562da1c5e7c0 RCX: 00007f0b4a71895d
[  224.746291] RDX: 0000000000000000 RSI: 0000562d7e0c8358 RDI: 0000000000000003
[  224.746925] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f0b4a7ef580
[  224.747504] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562d7e0c8358
[  224.748130] R13: 0000000000000000 R14: 0000562da1c5e790 R15: 0000000000000000
[  224.748705]  </TASK>
[  224.749318] 
[  224.749927] Allocated by task 796 on cpu 5 at 29.132818s:
[  224.750502]  kasan_save_stack+0x26/0x50
[  224.751128]  kasan_save_track+0x18/0x60
[  224.751696]  kasan_save_alloc_info+0x37/0x40
[  224.752311]  __kasan_slab_alloc+0x6a/0x70
[  224.752925]  kmem_cache_alloc_noprof+0x108/0x290
[  224.753491]  key_alloc+0x305/0x12b0
[  224.754104]  keyring_alloc+0x25/0x70
[  224.754662]  install_session_keyring_to_cred+0x13d/0x1c0
[  224.755275]  join_session_keyring+0x162/0x2c0
[  224.755870]  __do_sys_keyctl+0x1ce/0x2e0
[  224.756474]  __x64_sys_keyctl+0xb8/0x140
[  224.757078]  x64_sys_call+0x37e/0x9e0
[  224.757631]  do_syscall_64+0x64/0x130
[  224.758233]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  224.758811] 
[  224.759376] Freed by task 1802201963 on cpu 748395 at 3779491.451988s:
[  224.759998] ------------[ cut here ]------------
[  224.760567] pool index 93034 out of bounds (1296) for stack id 6b6b6b6b
[  224.761212] WARNING: CPU: 5 PID: 3533 at lib/stackdepot.c:451 depot_fetch_stack+0x97/0xc0
[  224.761829] Modules linked in: ath11k_pci(+) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core [last unloaded: mhi]
[  224.762499] CPU: 5 PID: 3533 Comm: insmod Not tainted 6.10.0-rc1 #1543
[  224.763174] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  224.763842] RIP: 0010:depot_fetch_stack+0x97/0xc0
[  224.764517] Code: ff 48 c7 c7 18 01 e6 94 e8 46 1f c7 01 83 f8 01 75 ba 0f 0b eb b6 44 89 e1 44 89 f2 89 de 48 c7 c7 98 bf 55 94 e8 59 95 f9 fe <0f> 0b 31 c0 eb c3 0f 0b 31 c0 eb bd 0f 0b 31 c0 eb b7 4c 89 e6 48
[  224.765966] RSP: 0018:ffffc900014272f8 EFLAGS: 00010086
[  224.766661] RAX: 0000000000000000 RBX: 0000000000016b6a RCX: 0000000000000000
[  224.767417] RDX: 0000000000000003 RSI: 0000000000000004 RDI: 0000000000000001
[  224.768170] RBP: ffffc90001427318 R08: 0000000000000001 R09: ffffed10439bdd19
[  224.768911] R10: ffff88821cdee8cb R11: 0000000000000001 R12: 000000006b6b6b6b
[  224.769618] R13: 0000000000001b50 R14: 0000000000000510 R15: 0000000000000082
[  224.770375] FS:  00007f0b4a5d2740(0000) GS:ffff88821cc00000(0000) knlGS:0000000000000000
[  224.771137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.771900] CR2: 000055cd5a072308 CR3: 000000014233d005 CR4: 00000000003706f0
[  224.772619] Call Trace:
[  224.773379]  <TASK>
[  224.774135]  ? show_regs+0x5b/0x70
[  224.774901]  ? __warn+0xc7/0x300
[  224.775609]  ? depot_fetch_stack+0x97/0xc0
[  224.776369]  ? report_bug+0x310/0x3f0
[  224.777137]  ? handle_bug+0x3e/0x90
[  224.777912]  ? exc_invalid_op+0x18/0x40
[  224.778633]  ? asm_exc_invalid_op+0x1b/0x20
[  224.779394]  ? depot_fetch_stack+0x97/0xc0
[  224.780159]  ? depot_fetch_stack+0x97/0xc0
[  224.780937]  stack_depot_print+0x31/0x60
[  224.781654]  print_track+0x66/0x80
[  224.782405]  print_address_description.constprop.0+0x367/0x3a0
[  224.783170]  print_report+0xb5/0x260
[  224.783935]  ? kasan_complete_mode_report_info+0x64/0x1a0
[  224.784660]  kasan_report+0xd8/0x110
[  224.785427]  ? lockdep_register_key+0x755/0x8f0
[  224.786223]  ? lockdep_register_key+0x755/0x8f0
[  224.786954]  __asan_report_load8_noabort+0x14/0x20
[  224.787612]  lockdep_register_key+0x755/0x8f0
[  224.788312]  ? save_trace+0x720/0x720
[  224.789005]  ? dma_alloc_attrs+0x145/0x1d0
[  224.789659]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  224.790375]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  224.791072]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.791736]  ? __this_cpu_preempt_check+0x13/0x20
[  224.792439]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  224.793139]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.793789]  local_pci_probe+0xd6/0x180
[  224.794485]  pci_call_probe+0x152/0x3f0
[  224.795184]  ? __kasan_check_read+0x11/0x20
[  224.795858]  ? pci_pm_suspend_late+0x40/0x40
[  224.796566]  ? pci_match_device+0x380/0x660
[  224.797267]  pci_device_probe+0xa6/0x100
[  224.797964]  really_probe+0x1d5/0x920
[  224.798612]  __driver_probe_device+0x2e8/0x3f0
[  224.799311]  driver_probe_device+0x4a/0x140
[  224.800008]  __driver_attach+0x1ed/0x4c0
[  224.800653]  ? __device_attach_driver+0x290/0x290
[  224.801350]  bus_for_each_dev+0xf5/0x180
[  224.802049]  ? bus_remove_file+0x40/0x40
[  224.802699]  ? _raw_spin_unlock+0x27/0x50
[  224.803397]  driver_attach+0x38/0x50
[  224.804089]  bus_add_driver+0x29b/0x5e0
[  224.804729]  driver_register+0x130/0x450
[  224.805417]  __pci_register_driver+0x1d2/0x270
[  224.806096]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.806727]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.807385]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  224.808028]  do_one_initcall+0xdf/0x500
[  224.808602]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  224.809222]  ? kasan_save_alloc_info+0x37/0x40
[  224.809769]  ? __kasan_kmalloc+0x90/0xa0
[  224.810329]  ? kasan_unpoison+0x45/0x70
[  224.810884]  ? kasan_poison+0x3a/0x50
[  224.811408]  ? __asan_register_globals+0x5e/0x70
[  224.811976]  do_init_module+0x23f/0x6c0
[  224.812492]  load_module+0x11e3/0x1aa0
[  224.813057]  init_module_from_file+0xe4/0x140
[  224.813568]  ? __ia32_sys_init_module+0xa0/0xa0
[  224.814126]  ? __kasan_check_read+0x11/0x20
[  224.814624]  ? do_raw_spin_unlock+0x54/0x220
[  224.815168]  idempotent_init_module+0x265/0x750
[  224.815657]  ? init_module_from_file+0x140/0x140
[  224.816206]  ? __kasan_check_read+0x11/0x20
[  224.816717]  __x64_sys_finit_module+0xbb/0x130
[  224.817255]  x64_sys_call+0x1c5/0x9e0
[  224.817766]  do_syscall_64+0x64/0x130
[  224.818301]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  224.818881] RIP: 0033:0x7f0b4a71895d
[  224.819406] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  224.820527] RSP: 002b:00007ffd47fdbb88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  224.821175] RAX: ffffffffffffffda RBX: 0000562da1c5e7c0 RCX: 00007f0b4a71895d
[  224.821772] RDX: 0000000000000000 RSI: 0000562d7e0c8358 RDI: 0000000000000003
[  224.822392] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f0b4a7ef580
[  224.823053] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562d7e0c8358
[  224.823649] R13: 0000000000000000 R14: 0000562da1c5e790 R15: 0000000000000000
[  224.824282]  </TASK>
[  224.824911] irq event stamp: 31227
[  224.825496] hardirqs last  enabled at (31227): [<ffffffff93852291>] _raw_spin_unlock_irqrestore+0x51/0x80
[  224.826172] hardirqs last disabled at (31226): [<ffffffff93851fbd>] _raw_spin_lock_irqsave+0x6d/0x90
[  224.826786] softirqs last  enabled at (29008): [<ffffffff90b713a3>] handle_softirqs+0x573/0x890
[  224.827424] softirqs last disabled at (28595): [<ffffffff90b71ffc>] irq_exit_rcu+0xac/0x110
[  224.828087] ---[ end trace 0000000000000000 ]---
[  224.828705] ------------[ cut here ]------------
[  224.829359] corrupt handle or use after stack_depot_put()
[  224.829376] WARNING: CPU: 5 PID: 3533 at lib/stackdepot.c:711 stack_depot_print+0x5a/0x60
[  224.830668] Modules linked in: ath11k_pci(+) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core [last unloaded: mhi]
[  224.831396] CPU: 5 PID: 3533 Comm: insmod Tainted: G        W          6.10.0-rc1 #1543
[  224.832100] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  224.832780] RIP: 0010:stack_depot_print+0x5a/0x60
[  224.833474] Code: ff 48 85 c0 74 18 8b 70 14 48 8d 78 20 85 f6 74 e4 31 d2 e8 48 a5 1e ff 5b 41 5c 5d c3 c3 48 c7 c7 50 c0 55 94 e8 76 8c f9 fe <0f> 0b eb c7 66 90 85 ff 74 6d 55 48 89 e5 41 57 44 0f b6 3d 0e c8
[  224.834940] RSP: 0018:ffffc90001427328 EFLAGS: 00010086
[  224.835663] RAX: 0000000000000000 RBX: 000000006b6b6b6b RCX: 0000000000000000
[  224.836448] RDX: 0000000000000003 RSI: 0000000000000004 RDI: 0000000000000001
[  224.837218] RBP: ffffc90001427338 R08: 0000000000000001 R09: ffffed10439bdd19
[  224.838005] R10: ffff88821cdee8cb R11: 0000000000000001 R12: 0000000000000000
[  224.838739] R13: ffffc90001427428 R14: 0000000000000008 R15: 0000000000000082
[  224.839488] FS:  00007f0b4a5d2740(0000) GS:ffff88821cc00000(0000) knlGS:0000000000000000
[  224.840272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.841075] CR2: 000055cd5a072308 CR3: 000000014233d005 CR4: 00000000003706f0
[  224.841848] Call Trace:
[  224.842617]  <TASK>
[  224.843394]  ? show_regs+0x5b/0x70
[  224.844180]  ? __warn+0xc7/0x300
[  224.844964]  ? stack_depot_print+0x5a/0x60
[  224.845706]  ? report_bug+0x310/0x3f0
[  224.846501]  ? handle_bug+0x3e/0x90
[  224.847277]  ? exc_invalid_op+0x18/0x40
[  224.848063]  ? asm_exc_invalid_op+0x1b/0x20
[  224.848828]  ? stack_depot_print+0x5a/0x60
[  224.849595]  ? stack_depot_print+0x5a/0x60
[  224.850363]  print_track+0x66/0x80
[  224.851145]  print_address_description.constprop.0+0x367/0x3a0
[  224.851933]  print_report+0xb5/0x260
[  224.852662]  ? kasan_complete_mode_report_info+0x64/0x1a0
[  224.853438]  kasan_report+0xd8/0x110
[  224.854233]  ? lockdep_register_key+0x755/0x8f0
[  224.855017]  ? lockdep_register_key+0x755/0x8f0
[  224.855752]  __asan_report_load8_noabort+0x14/0x20
[  224.856543]  lockdep_register_key+0x755/0x8f0
[  224.857318]  ? save_trace+0x720/0x720
[  224.858097]  ? dma_alloc_attrs+0x145/0x1d0
[  224.858870]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  224.859646]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  224.860427]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.861232]  ? __this_cpu_preempt_check+0x13/0x20
[  224.862022]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  224.862766]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.863562]  local_pci_probe+0xd6/0x180
[  224.864347]  pci_call_probe+0x152/0x3f0
[  224.865136]  ? __kasan_check_read+0x11/0x20
[  224.865912]  ? pci_pm_suspend_late+0x40/0x40
[  224.866630]  ? pci_match_device+0x380/0x660
[  224.867356]  pci_device_probe+0xa6/0x100
[  224.868075]  really_probe+0x1d5/0x920
[  224.868738]  __driver_probe_device+0x2e8/0x3f0
[  224.869456]  driver_probe_device+0x4a/0x140
[  224.870172]  __driver_attach+0x1ed/0x4c0
[  224.870860]  ? __device_attach_driver+0x290/0x290
[  224.871579]  bus_for_each_dev+0xf5/0x180
[  224.872290]  ? bus_remove_file+0x40/0x40
[  224.872991]  ? _raw_spin_unlock+0x27/0x50
[  224.873640]  driver_attach+0x38/0x50
[  224.874333]  bus_add_driver+0x29b/0x5e0
[  224.875025]  driver_register+0x130/0x450
[  224.875667]  __pci_register_driver+0x1d2/0x270
[  224.876355]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.877045]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.877671]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  224.878329]  do_one_initcall+0xdf/0x500
[  224.878967]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  224.879550]  ? kasan_save_alloc_info+0x37/0x40
[  224.880169]  ? __kasan_kmalloc+0x90/0xa0
[  224.880717]  ? kasan_unpoison+0x45/0x70
[  224.881289]  ? kasan_poison+0x3a/0x50
[  224.881829]  ? __asan_register_globals+0x5e/0x70
[  224.882372]  do_init_module+0x23f/0x6c0
[  224.882940]  load_module+0x11e3/0x1aa0
[  224.883454]  init_module_from_file+0xe4/0x140
[  224.884029]  ? __ia32_sys_init_module+0xa0/0xa0
[  224.884548]  ? __kasan_check_read+0x11/0x20
[  224.885105]  ? do_raw_spin_unlock+0x54/0x220
[  224.885605]  idempotent_init_module+0x265/0x750
[  224.886152]  ? init_module_from_file+0x140/0x140
[  224.886644]  ? __kasan_check_read+0x11/0x20
[  224.887191]  __x64_sys_finit_module+0xbb/0x130
[  224.887687]  x64_sys_call+0x1c5/0x9e0
[  224.888231]  do_syscall_64+0x64/0x130
[  224.888725]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  224.889275] RIP: 0033:0x7f0b4a71895d
[  224.889775] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  224.890947] RSP: 002b:00007ffd47fdbb88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  224.891513] RAX: ffffffffffffffda RBX: 0000562da1c5e7c0 RCX: 00007f0b4a71895d
[  224.892137] RDX: 0000000000000000 RSI: 0000562d7e0c8358 RDI: 0000000000000003
[  224.892714] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f0b4a7ef580
[  224.893340] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562d7e0c8358
[  224.893962] R13: 0000000000000000 R14: 0000562da1c5e790 R15: 0000000000000000
[  224.894535]  </TASK>
[  224.895148] irq event stamp: 31227
[  224.895709] hardirqs last  enabled at (31227): [<ffffffff93852291>] _raw_spin_unlock_irqrestore+0x51/0x80
[  224.896354] hardirqs last disabled at (31226): [<ffffffff93851fbd>] _raw_spin_lock_irqsave+0x6d/0x90
[  224.897000] softirqs last  enabled at (29008): [<ffffffff90b713a3>] handle_softirqs+0x573/0x890
[  224.897596] softirqs last disabled at (28595): [<ffffffff90b71ffc>] irq_exit_rcu+0xac/0x110
[  224.898242] ---[ end trace 0000000000000000 ]---
[  224.898885] 
[  224.899470] The buggy address belongs to the object at ffff88810d7716c0#012[  224.899470]  which belongs to the cache key_jar of size 344
[  224.900697] The buggy address is located 88 bytes to the right of#012[  224.900697]  allocated 344-byte region [ffff88810d7716c0, ffff88810d771818)
[  224.901988] 
[  224.902588] The buggy address belongs to the physical page:
[  224.903251] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810d771000 pfn:0x10d770
[  224.903938] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  224.904581] flags: 0x200000000000240(workingset|head|node=0|zone=2)
[  224.905260] page_type: 0xffffefff(slab)
[  224.905963] raw: 0200000000000240 ffff8881018603c0 ffffea000440c210 ffffea0004378010
[  224.906642] raw: ffff88810d771000 00000000001c0010 00000001ffffefff 0000000000000000
[  224.907362] head: 0200000000000240 ffff8881018603c0 ffffea000440c210 ffffea0004378010
[  224.908097] head: ffff88810d771000 00000000001c0010 00000001ffffefff 0000000000000000
[  224.908791] head: 0200000000000002 ffffea000435dc01 ffffffffffffffff 0000000000000000
[  224.909523] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
[  224.910256] page dumped because: kasan: bad access detected
[  224.911015] 
[  224.911702] Memory state around the buggy address:
[  224.912461]  ffff88810d771700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  224.913215]  ffff88810d771780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  224.913970] >ffff88810d771800: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
[  224.914678]                                                              ^
[  224.915429]  ffff88810d771880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  224.916226]  ffff88810d771900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  224.916993] ==================================================================
[  224.917703] Disabling lock debugging due to kernel taint
[  224.918470] Oops: general protection fault, probably for non-canonical address 0xe00002c873880000: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  224.919267] KASAN: probably user-memory-access in range [0x000036439c400000-0x000036439c400007]
[  224.920064] CPU: 5 PID: 3533 Comm: insmod Tainted: G    B   W          6.10.0-rc1 #1543
[  224.920848] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  224.921653] RIP: 0010:lockdep_register_key+0x1c8/0x8f0
[  224.922482] Code: 05 00 00 48 8b 1c cd 60 45 fc a5 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 <80> 3c 30 00 0f 85 74 05 00 00 48 8b 1b 48 85 db 0f 84 ff 01 00 00
[  224.924193] RSP: 0018:ffffc900014274e0 EFLAGS: 00010007
[  224.925070] RAX: 000006c873880000 RBX: 000036439c400005 RCX: 0000000000000594
[  224.925957] RDX: ffffffff9561ceb8 RSI: dffffc0000000000 RDI: ffffffff95a98420
[  224.926794] RBP: ffffc90001427580 R08: 0000000000000001 R09: fffffbfff2b53084
[  224.927671] R10: ffffffff95a98427 R11: 0000000000000001 R12: ffff88813bb8c668
[  224.928561] R13: 1ffff92000284e9f R14: dffffc0000000000 R15: ffffffffa61cf9c0
[  224.929454] FS:  00007f0b4a5d2740(0000) GS:ffff88821cc00000(0000) knlGS:0000000000000000
[  224.930355] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.931259] CR2: 000055cd5a072308 CR3: 000000014233d005 CR4: 00000000003706f0
[  224.932171] Call Trace:
[  224.933061]  <TASK>
[  224.933964]  ? show_regs+0x5b/0x70
[  224.934841]  ? die_addr+0x3c/0xa0
[  224.935718]  ? exc_general_protection+0x150/0x230
[  224.936600]  ? asm_exc_general_protection+0x27/0x30
[  224.937465]  ? lockdep_register_key+0x1c8/0x8f0
[  224.938325]  ? save_trace+0x720/0x720
[  224.939178]  ? dma_alloc_attrs+0x145/0x1d0
[  224.940039]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  224.940927]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  224.941742]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.942612]  ? __this_cpu_preempt_check+0x13/0x20
[  224.943460]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  224.944316]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  224.945168]  local_pci_probe+0xd6/0x180
[  224.946041]  pci_call_probe+0x152/0x3f0
[  224.946860]  ? __kasan_check_read+0x11/0x20
[  224.947640]  ? pci_pm_suspend_late+0x40/0x40
[  224.948463]  ? pci_match_device+0x380/0x660
[  224.949284]  pci_device_probe+0xa6/0x100
[  224.950097]  really_probe+0x1d5/0x920
[  224.950910]  __driver_probe_device+0x2e8/0x3f0
[  224.951667]  driver_probe_device+0x4a/0x140
[  224.952472]  __driver_attach+0x1ed/0x4c0
[  224.953269]  ? __device_attach_driver+0x290/0x290
[  224.954067]  bus_for_each_dev+0xf5/0x180
[  224.954825]  ? bus_remove_file+0x40/0x40
[  224.955578]  ? _raw_spin_unlock+0x27/0x50
[  224.956349]  driver_attach+0x38/0x50
[  224.957121]  bus_add_driver+0x29b/0x5e0
[  224.957866]  driver_register+0x130/0x450
[  224.958610]  __pci_register_driver+0x1d2/0x270
[  224.959368]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.960126]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  224.960857]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  224.961593]  do_one_initcall+0xdf/0x500
[  224.962328]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  224.963075]  ? kasan_save_alloc_info+0x37/0x40
[  224.963775]  ? __kasan_kmalloc+0x90/0xa0
[  224.964488]  ? kasan_unpoison+0x45/0x70
[  224.965224]  ? kasan_poison+0x3a/0x50
[  224.965997]  ? __asan_register_globals+0x5e/0x70
[  224.966687]  do_init_module+0x23f/0x6c0
[  224.967405]  load_module+0x11e3/0x1aa0
[  224.968130]  init_module_from_file+0xe4/0x140
[  224.968829]  ? __ia32_sys_init_module+0xa0/0xa0
[  224.969532]  ? __kasan_check_read+0x11/0x20
[  224.970224]  ? do_raw_spin_unlock+0x54/0x220
[  224.970908]  idempotent_init_module+0x265/0x750
[  224.971519]  ? init_module_from_file+0x140/0x140
[  224.972185]  ? __kasan_check_read+0x11/0x20
[  224.972787]  __x64_sys_finit_module+0xbb/0x130
[  224.973406]  x64_sys_call+0x1c5/0x9e0
[  224.974007]  do_syscall_64+0x64/0x130
[  224.974562]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  224.975156] RIP: 0033:0x7f0b4a71895d
[  224.975705] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  224.976969] RSP: 002b:00007ffd47fdbb88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  224.977556] RAX: ffffffffffffffda RBX: 0000562da1c5e7c0 RCX: 00007f0b4a71895d
[  224.978188] RDX: 0000000000000000 RSI: 0000562d7e0c8358 RDI: 0000000000000003
[  224.978767] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f0b4a7ef580
[  224.979381] R10: 0000000000000003 R11: 0000000000000246 R12: 0000562d7e0c8358
[  224.979998] R13: 0000000000000000 R14: 0000562da1c5e790 R15: 0000000000000000
[  224.980572]  </TASK>
[  224.981186] Modules linked in: ath11k_pci(+) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core [last unloaded: mhi]
[  224.981843] ---[ end trace 0000000000000000 ]---
[  225.115543] RIP: 0010:lockdep_register_key+0x1c8/0x8f0
[  225.116200] Code: 05 00 00 48 8b 1c cd 60 45 fc a5 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 <80> 3c 30 00 0f 85 74 05 00 00 48 8b 1b 48 85 db 0f 84 ff 01 00 00
[  225.117542] RSP: 0018:ffffc900014274e0 EFLAGS: 00010007
[  225.118274] RAX: 000006c873880000 RBX: 000036439c400005 RCX: 0000000000000594
[  225.119009] RDX: ffffffff9561ceb8 RSI: dffffc0000000000 RDI: ffffffff95a98420
[  225.119694] RBP: ffffc90001427580 R08: 0000000000000001 R09: fffffbfff2b53084
[  225.120432] R10: ffffffff95a98427 R11: 0000000000000001 R12: ffff88813bb8c668
[  225.121199] R13: 1ffff92000284e9f R14: dffffc0000000000 R15: ffffffffa61cf9c0
[  225.121951] FS:  00007f0b4a5d2740(0000) GS:ffff88821cc00000(0000) knlGS:0000000000000000
[  225.122641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  225.123370] CR2: 000055cd5a072308 CR3: 000000014233d005 CR4: 00000000003706f0
[  225.124130] Kernel panic - not syncing: Fatal exception
[  225.124916] Kernel Offset: 0xfa00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Crash 4:

[  259.652506] ath11k_pci 0000:06:00.0: wcn6855 hw2.0
[  259.665664] ==================================================================
[  259.666542] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x755/0x8f0
[  259.667418] Read of size 8 at addr ffff88810fe49870 by task insmod/1944
[  259.668282] 
[  259.669132] CPU: 0 PID: 1944 Comm: insmod Not tainted 6.10.0-rc1 #1547
[  259.670001] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  259.670904] Call Trace:
[  259.671744]  <TASK>
[  259.672580]  dump_stack_lvl+0x7d/0xe0
[  259.673436]  print_address_description.constprop.0+0x33/0x3a0
[  259.674297]  print_report+0xb5/0x260
[  259.675158]  ? kasan_complete_mode_report_info+0x64/0x1a0
[  259.676033]  kasan_report+0xd8/0x110
[  259.676937]  ? lockdep_register_key+0x755/0x8f0
[  259.677843]  ? lockdep_register_key+0x755/0x8f0
[  259.678647]  __asan_report_load8_noabort+0x14/0x20
[  259.679486]  lockdep_register_key+0x755/0x8f0
[  259.680314]  ? save_trace+0x720/0x720
[  259.681124]  ? dma_alloc_attrs+0x145/0x1d0
[  259.681944]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  259.682762]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  259.683560]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  259.684380]  ? __this_cpu_preempt_check+0x13/0x20
[  259.685198]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  259.686014]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  259.686838]  local_pci_probe+0xd6/0x180
[  259.687595]  pci_call_probe+0x152/0x3f0
[  259.688387]  ? __kasan_check_read+0x11/0x20
[  259.689191]  ? pci_pm_suspend_late+0x40/0x40
[  259.689993]  ? pci_match_device+0x380/0x660
[  259.690763]  pci_device_probe+0xa6/0x100
[  259.691500]  really_probe+0x1d5/0x920
[  259.692284]  __driver_probe_device+0x2e8/0x3f0
[  259.693065]  driver_probe_device+0x4a/0x140
[  259.693778]  __driver_attach+0x1ed/0x4c0
[  259.694483]  ? __device_attach_driver+0x290/0x290
[  259.695207]  bus_for_each_dev+0xf5/0x180
[  259.695932]  ? bus_remove_file+0x40/0x40
[  259.696595]  ? _raw_spin_unlock+0x27/0x50
[  259.697323]  driver_attach+0x38/0x50
[  259.698039]  bus_add_driver+0x29b/0x5e0
[  259.698688]  driver_register+0x130/0x450
[  259.699392]  __pci_register_driver+0x1d2/0x270
[  259.700095]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  259.700767]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  259.701428]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  259.702123]  do_one_initcall+0xdf/0x500
[  259.702781]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  259.703435]  ? kasan_save_alloc_info+0x37/0x40
[  259.704134]  ? __kasan_kmalloc+0x90/0xa0
[  259.704811]  ? kasan_unpoison+0x45/0x70
[  259.705420]  ? kasan_poison+0x3a/0x50
[  259.706062]  ? __asan_register_globals+0x5e/0x70
[  259.706652]  do_init_module+0x23f/0x6c0
[  259.707300]  load_module+0x11e3/0x1aa0
[  259.707953]  init_module_from_file+0xe4/0x140
[  259.708546]  ? __ia32_sys_init_module+0xa0/0xa0
[  259.709199]  ? __kasan_check_read+0x11/0x20
[  259.709852]  ? do_raw_spin_unlock+0x54/0x220
[  259.710459]  idempotent_init_module+0x265/0x750
[  259.711113]  ? init_module_from_file+0x140/0x140
[  259.711695]  ? __kasan_check_read+0x11/0x20
[  259.712304]  __x64_sys_finit_module+0xbb/0x130
[  259.712954]  x64_sys_call+0x1c5/0x9e0
[  259.713528]  do_syscall_64+0x64/0x130
[  259.714144]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  259.714707] RIP: 0033:0x7ff1ed6c595d
[  259.715309] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  259.716503] RSP: 002b:00007ffe9970fe88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  259.717158] RAX: ffffffffffffffda RBX: 000056003aabc7c0 RCX: 00007ff1ed6c595d
[  259.717806] RDX: 0000000000000000 RSI: 000056000fddb358 RDI: 0000000000000003
[  259.718425] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ff1ed79c580
[  259.719090] R10: 0000000000000003 R11: 0000000000000246 R12: 000056000fddb358
[  259.719666] R13: 0000000000000000 R14: 000056003aabc790 R15: 0000000000000000
[  259.720301]  </TASK>
[  259.720926] 
[  259.721482] Allocated by task 1925 on cpu 0 at 258.277859s:
[  259.722120]  kasan_save_stack+0x26/0x50
[  259.722696]  kasan_save_track+0x18/0x60
[  259.723325]  kasan_save_alloc_info+0x37/0x40
[  259.723952]  __kasan_slab_alloc+0x6a/0x70
[  259.724517]  kmem_cache_alloc_noprof+0x108/0x290
[  259.725142]  __alloc_object+0x33/0x280
[  259.725707]  __create_object+0x24/0x90
[  259.726328]  kmemleak_alloc+0x45/0x80
[  259.726946]  kmem_cache_alloc_noprof+0x24a/0x290
[  259.727507]  vm_area_alloc+0x102/0x1e0
[  259.728126]  mmap_region+0x316/0x2390
[  259.728678]  do_mmap+0x756/0x1180
[  259.729294]  vm_mmap_pgoff+0x18f/0x320
[  259.729903]  ksys_mmap_pgoff+0x22b/0x520
[  259.730453]  __x64_sys_mmap+0xed/0x1a0
[  259.731061]  x64_sys_call+0x99e/0x9e0
[  259.731609]  do_syscall_64+0x64/0x130
[  259.732219]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  259.732826] 
[  259.733371] Freed by task 0 on cpu 0 at 258.306253s:
[  259.733985]  kasan_save_stack+0x26/0x50
[  259.734541]  kasan_save_track+0x18/0x60
[  259.735147]  kasan_save_free_info+0x3b/0x50
[  259.735693]  poison_slab_object+0xf4/0x160
[  259.736303]  __kasan_slab_free+0x15/0x30
[  259.736916]  kmem_cache_free+0xf0/0x410
[  259.737463]  free_object_rcu+0x11a/0x130
[  259.738069]  rcu_do_batch+0x43c/0x1090
[  259.738615]  rcu_core+0x2b5/0x500
[  259.739213]  rcu_core_si+0x9/0x10
[  259.739798]  handle_softirqs+0x28b/0x890
[  259.740354]  irq_exit_rcu+0xac/0x110
[  259.740950]  sysvec_apic_timer_interrupt+0x94/0xc0
[  259.741491]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  259.742089] 
[  259.742620] Last potentially related work creation:
[  259.743222]  kasan_save_stack+0x26/0x50
[  259.743830]  __kasan_record_aux_stack+0x93/0xa0
[  259.744378]  kasan_record_aux_stack_noalloc+0xb/0x10
[  259.744987]  __call_rcu_common.constprop.0+0x9e/0x750
[  259.745537]  call_rcu+0x9/0x10
[  259.746145]  put_object+0x30/0x40
[  259.746690]  __delete_object+0x37/0x50
[  259.747294]  delete_object_full+0x52/0x70
[  259.747901]  kmemleak_free+0x2c/0x60
[  259.748456]  kmem_cache_free+0x17d/0x410
[  259.749056]  vm_area_free_rcu_cb+0x7f/0xc0
[  259.749600]  rcu_do_batch+0x43c/0x1090
[  259.750198]  rcu_core+0x2b5/0x500
[  259.750765]  rcu_core_si+0x9/0x10
[  259.751327]  handle_softirqs+0x28b/0x890
[  259.751925]  run_ksoftirqd+0x37/0x60
[  259.752457]  smpboot_thread_fn+0x594/0x9b0
[  259.753031]  kthread+0x2fa/0x3f0
[  259.753519]  ret_from_fork+0x31/0x70
[  259.754058]  ret_from_fork_asm+0x11/0x20
[  259.754527] 
[  259.755045] The buggy address belongs to the object at ffff88810fe497c8#012[  259.755045]  which belongs to the cache kmemleak_object of size 240
[  259.756039] The buggy address is located 168 bytes inside of#012[  259.756039]  freed 240-byte region [ffff88810fe497c8, ffff88810fe498b8)
[  259.757049] 
[  259.757530] The buggy address belongs to the physical page:
[  259.758091] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10fe48
[  259.758611] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  259.759195] flags: 0x200000000000040(head|node=0|zone=2)
[  259.759751] page_type: 0xffffefff(slab)
[  259.760313] raw: 0200000000000040 ffff888100050900 dead000000000100 dead000000000122
[  259.760920] raw: 0000000000000000 0000000000190019 00000001ffffefff 0000000000000000
[  259.761466] head: 0200000000000040 ffff888100050900 dead000000000100 dead000000000122
[  259.762079] head: 0000000000000000 0000000000190019 00000001ffffefff 0000000000000000
[  259.762631] head: 0200000000000001 ffffea00043f9201 ffffffffffffffff 0000000000000000
[  259.763257] head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
[  259.763868] page dumped because: kasan: bad access detected
[  259.764422] 
[  259.765030] Memory state around the buggy address:
[  259.765590]  ffff88810fe49700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
[  259.766220]  ffff88810fe49780: fc fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb
[  259.766850] >ffff88810fe49800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  259.767429]                                                              ^
[  259.768074]  ffff88810fe49880: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
[  259.768661]  ffff88810fe49900: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  259.769319] ==================================================================
[  259.769972] Disabling lock debugging due to kernel taint
[  259.770574] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000015: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  259.771267] KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
[  259.771965] CPU: 0 PID: 1944 Comm: insmod Tainted: G    B              6.10.0-rc1 #1547
[  259.772619] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  259.773346] RIP: 0010:lockdep_register_key+0x1c8/0x8f0
[  259.774074] Code: 05 00 00 48 8b 1c cd 60 45 fc a5 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 <80> 3c 30 00 0f 85 74 05 00 00 48 8b 1b 48 85 db 0f 84 ff 01 00 00
[  259.775518] RSP: 0018:ffffc900015274e0 EFLAGS: 00010002
[  259.776295] RAX: 0000000000000015 RBX: 00000000000000a8 RCX: 0000000000000556
[  259.777081] RDX: ffffffff9561ceb8 RSI: dffffc0000000000 RDI: ffffffff95a98420
[  259.777868] RBP: ffffc90001527580 R08: 0000000000000001 R09: fffffbfff2b53084
[  259.778625] R10: ffffffff95a98427 R11: 0000000000000001 R12: ffff88814189c398
[  259.779410] R13: 1ffff920002a4e9f R14: dffffc0000000000 R15: ffffffffa61cf9c0
[  259.780194] FS:  00007ff1ed57f740(0000) GS:ffff88821b800000(0000) knlGS:0000000000000000
[  259.780985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  259.781722] CR2: 00007f08211a9e50 CR3: 00000001074ee005 CR4: 00000000003706f0
[  259.782517] Call Trace:
[  259.783306]  <TASK>
[  259.784089]  ? show_regs+0x5b/0x70
[  259.784879]  ? die_addr+0x3c/0xa0
[  259.785604]  ? exc_general_protection+0x150/0x230
[  259.786389]  ? asm_exc_general_protection+0x27/0x30
[  259.787180]  ? lockdep_register_key+0x1c8/0x8f0
[  259.787971]  ? save_trace+0x720/0x720
[  259.788704]  ? dma_alloc_attrs+0x145/0x1d0
[  259.789496]  ath11k_hal_srng_init+0x143/0x280 [ath11k]
[  259.790316]  ath11k_pci_probe+0x67a/0x1210 [ath11k_pci]
[  259.791116]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  259.791921]  ? __this_cpu_preempt_check+0x13/0x20
[  259.792672]  ? _raw_spin_unlock_irqrestore+0x3c/0x80
[  259.793481]  ? ath11k_pci_power_up+0x380/0x380 [ath11k_pci]
[  259.794295]  local_pci_probe+0xd6/0x180
[  259.795116]  pci_call_probe+0x152/0x3f0
[  259.795928]  ? __kasan_check_read+0x11/0x20
[  259.796683]  ? pci_pm_suspend_late+0x40/0x40
[  259.797507]  ? pci_match_device+0x380/0x660
[  259.798323]  pci_device_probe+0xa6/0x100
[  259.799129]  really_probe+0x1d5/0x920
[  259.799934]  __driver_probe_device+0x2e8/0x3f0
[  259.800680]  driver_probe_device+0x4a/0x140
[  259.801484]  __driver_attach+0x1ed/0x4c0
[  259.802273]  ? __device_attach_driver+0x290/0x290
[  259.803065]  bus_for_each_dev+0xf5/0x180
[  259.803847]  ? bus_remove_file+0x40/0x40
[  259.804568]  ? _raw_spin_unlock+0x27/0x50
[  259.805334]  driver_attach+0x38/0x50
[  259.806100]  bus_add_driver+0x29b/0x5e0
[  259.806858]  driver_register+0x130/0x450
[  259.807557]  __pci_register_driver+0x1d2/0x270
[  259.808308]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  259.809065]  ? ath11k_pci_get_msi_irq+0x50/0x50 [ath11k_pci]
[  259.809789]  ath11k_pci_init+0x1f/0x50 [ath11k_pci]
[  259.810514]  do_one_initcall+0xdf/0x500
[  259.811256]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  259.812003]  ? kasan_save_alloc_info+0x37/0x40
[  259.812693]  ? __kasan_kmalloc+0x90/0xa0
[  259.813434]  ? kasan_unpoison+0x45/0x70
[  259.814166]  ? kasan_poison+0x3a/0x50
[  259.814885]  ? __asan_register_globals+0x5e/0x70
[  259.815557]  do_init_module+0x23f/0x6c0
[  259.816287]  load_module+0x11e3/0x1aa0
[  259.817003]  init_module_from_file+0xe4/0x140
[  259.817658]  ? __ia32_sys_init_module+0xa0/0xa0
[  259.818364]  ? __kasan_check_read+0x11/0x20
[  259.819062]  ? do_raw_spin_unlock+0x54/0x220
[  259.819697]  idempotent_init_module+0x265/0x750
[  259.820402]  ? init_module_from_file+0x140/0x140
[  259.821067]  ? __kasan_check_read+0x11/0x20
[  259.821670]  __x64_sys_finit_module+0xbb/0x130
[  259.822293]  x64_sys_call+0x1c5/0x9e0
[  259.822901]  do_syscall_64+0x64/0x130
[  259.823456]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  259.824054] RIP: 0033:0x7ff1ed6c595d
[  259.824605] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 35 0d 00 f7 d8 64 89 01 48
[  259.825828] RSP: 002b:00007ffe9970fe88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  259.826445] RAX: ffffffffffffffda RBX: 000056003aabc7c0 RCX: 00007ff1ed6c595d
[  259.827096] RDX: 0000000000000000 RSI: 000056000fddb358 RDI: 0000000000000003
[  259.827697] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ff1ed79c580
[  259.828316] R10: 0000000000000003 R11: 0000000000000246 R12: 000056000fddb358
[  259.828953] R13: 0000000000000000 R14: 000056003aabc790 R15: 0000000000000000
[  259.829545]  </TASK>
[  259.830166] Modules linked in: ath11k_pci(+) ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core [last unloaded: mhi]
[  259.830859] ---[ end trace 0000000000000000 ]---
[  259.915081] RIP: 0010:lockdep_register_key+0x1c8/0x8f0
[  259.915719] Code: 05 00 00 48 8b 1c cd 60 45 fc a5 48 85 db 0f 84 2b 02 00 00 48 be 00 00 00 00 00 fc ff df 49 39 dc 74 22 48 89 d8 48 c1 e8 03 <80> 3c 30 00 0f 85 74 05 00 00 48 8b 1b 48 85 db 0f 84 ff 01 00 00
[  259.917080] RSP: 0018:ffffc900015274e0 EFLAGS: 00010002
[  259.917800] RAX: 0000000000000015 RBX: 00000000000000a8 RCX: 0000000000000556
[  259.918506] RDX: ffffffff9561ceb8 RSI: dffffc0000000000 RDI: ffffffff95a98420
[  259.919237] RBP: ffffc90001527580 R08: 0000000000000001 R09: fffffbfff2b53084
[  259.919970] R10: ffffffff95a98427 R11: 0000000000000001 R12: ffff88814189c398
[  259.920652] R13: 1ffff920002a4e9f R14: dffffc0000000000 R15: ffffffffa61cf9c0
[  259.921374] FS:  00007ff1ed57f740(0000) GS:ffff88821b800000(0000) knlGS:0000000000000000
[  259.922111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  259.922855] CR2: 00007f08211a9e50 CR3: 00000001074ee005 CR4: 00000000003706f0
[  259.923554] Kernel panic - not syncing: Fatal exception
[  259.924332] Kernel Offset: 0xfa00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

