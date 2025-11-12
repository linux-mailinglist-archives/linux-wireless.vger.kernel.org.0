Return-Path: <linux-wireless+bounces-28878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B1C540E0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 20:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD897345EC4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BA34405F;
	Wed, 12 Nov 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Qfl4MOlW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B0221275
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974217; cv=none; b=HfgdZ1HC2o41gjwuHoYMtrw52Ti10vX1vLeay3PHXWHqNGRaPM3FVQr266pS49zP1MSRcvWh3RICMjBmERLwKl3CWFDqhNEQ3XVXk2L7x8Tcj1r9V3ZOfcD2pqbtmV/KsS1C23UY5nMXKd5f79SBghFIzfbvF0qVENbgxjy1MAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974217; c=relaxed/simple;
	bh=AxBdILJdBWKE5FRabIFR2yP1uqxzkTIr2SwfpZn8Ggk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j9KCjqX+ybDU8VCC9WEYKSn9Z5IIb7/BrFkbWmVEkBy3y36IG49lZ81QeHUnq4zEfkBtAS8IgWx3JyvdP2piUOoFZ1nkltFydzr+pWB1wiRSByYp3NxAJEJQ4NClOq5CO34q95Af2OI0Qx6xEZLkvCZbbkGi0pMcz/Xxip3Fa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Qfl4MOlW; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 95E7A3097BD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 19:03:34 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5F9CE440082;
	Wed, 12 Nov 2025 19:03:26 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9FF8213C2B0;
	Wed, 12 Nov 2025 11:03:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9FF8213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1762974199;
	bh=AxBdILJdBWKE5FRabIFR2yP1uqxzkTIr2SwfpZn8Ggk=;
	h=Date:To:Cc:From:Subject:From;
	b=Qfl4MOlWHa3moyDHKQGOUgsacq17oI22WbXRlzpod3fKnqZ02+VB7cLZXWeJqudfF
	 35y4DHy55VPl+3tfyIelbxUdvfYEZnLbZJw7Y5360STqb5M4OGJe31q1MRYpys+Gga
	 ScqauzlBL6RQVcIcZ1HurcsYk39w1rwXbx1U9BZs=
Message-ID: <b0218060-3987-ed7d-55f3-43d1978579ea@candelatech.com>
Date: Wed, 12 Nov 2025 11:03:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: mtk7996 lockdep & rcu splat in upstream kernel.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1762974207-joEEtRpuXNJH
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1762974207;joEEtRpuXNJH;<greearb@candelatech.com>;d07cbf78db220dce000d227a927b0a59
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello Lorenzo & Felix,

With the hack to fix the crash I just posted, the kernel can get far enough to
show this lockdep splat.  I cannot find any code that grabs the wiphy mtx
in this path, and yet if I try to add an explicit mutex_lock lock in the scan code, then
I get kernel deadlocks.  Maybe I'm just putting the lock in the wrong place.

Any idea how this is supposed to work with regards to wiphy locking?

And in addition, there is RCU splat immediately after the key.c related
splat.

    315 Nov 12 10:40:51 ct523c-a0af kernel: ------------[ cut here ]------------
    316 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: CPU: 1 PID: 115 at net/mac80211/key.c:1029 ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
    317 Nov 12 10:40:51 ct523c-a0af kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q 
garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep snd_hda_codec_intelhdmi intel_rapl_msr snd_hda_codec_hdmi              iTCO_wdt 
coretemp ee1004 intel_pmc_bxt iTCO_vendor_support intel_rapl_common snd_hda_codec_alc662 intel_uncore_frequency 
snd_hda_codec_realtek_lib intel_uncore_frequency_common snd_hda_codec_generic iwlmld mt7996e intel_tcc_cooling snd_hda_intel mt76_connac_lib         mt76 
x86_pkg_temp_thermal snd_intel_dspcfg snd_hda_codec intel_powerclamp pcspkr snd_hda_core mac80211 intel_wmi_thunderbolt iwlwifi                 snd_hwdep btusb 
snd_seq btbcm snd_seq_device btmtk btrtl btintel joydev bluetooth snd_pcm cfg80211 i2c_i801 snd_timer i2c_smbus bfq snd              i2c_mux soundcore 
intel_pmc_core mei_pxp mei_hdcp intel_pch_thermal pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry                  intel_vsec acpi_pad nfsd 
auth_rpcgss nfs_acl lockd grace nfs_localio sch_fq_codel sunrpc fuse zram raid1 dm_raid
    318 Nov 12 10:40:51 ct523c-a0af kernel:  raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt 
drm_client_lib drm_display_helper drm_kms_helper cec rc_core igb ttm intel_oc_wdt agpgart i2c_algo_bit ixgbe mdio libie_fwlog dca drm hwmon          mei_wdt 
i2c_core video wmi [last unloaded: nfnetlink]
    319 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm: kworker/u32:4 Tainted: G S                  6.18.0-rc5+ #25 PREEMPT(full)
    320 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=CPU_OUT_OF_SPEC
    321 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
    322 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work [mt76]
    323 Nov 12 10:40:51 ct523c-a0af kernel: RIP: 0010:ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
    324 Nov 12 10:40:51 ct523c-a0af kernel: Code: 4c 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 47 48 be ff ff ff ff 48 8d 78 68 e8 04 ec fe         e0 
85 c0 0f 85 49 ff ff ff <0f> 0b 4d 85 ed 0f 85 47 ff ff ff 4c 8b ab 90 1a 00 00 48 8d 83 90
    325 Nov 12 10:40:51 ct523c-a0af kernel: RSP: 0018:ffffc90000f1fcb0 EFLAGS: 00010246
    326 Nov 12 10:40:51 ct523c-a0af kernel: RAX: 0000000000000000 RBX: ffff888132710ee0 RCX: 0000000000000000
    327 Nov 12 10:40:51 ct523c-a0af kernel: RDX: 0000000000000000 RSI: ffff888132710788 RDI: ffff8881158435c8
    328 Nov 12 10:40:51 ct523c-a0af kernel: RBP: ffffffffa0de5400 R08: 0000000000000001 R09: 00000000f9936176
    329 Nov 12 10:40:51 ct523c-a0af kernel: R10: 0000000000000001 R11: ffff8881158435a0 R12: ffffc90000f1fd00
    330 Nov 12 10:40:51 ct523c-a0af kernel: R13: ffff88811642aa80 R14: ffff88813271afc8 R15: 000000000000043f
    331 Nov 12 10:40:51 ct523c-a0af kernel: FS:  0000000000000000(0000) GS:ffff8884da4c6000(0000) knlGS:0000000000000000
    332 Nov 12 10:40:51 ct523c-a0af kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    333 Nov 12 10:40:51 ct523c-a0af kernel: CR2: 0000000000422bcc CR3: 0000000002c52004 CR4: 00000000003706f0
    334 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
    335 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
    336 Nov 12 10:40:51 ct523c-a0af kernel:  ? lock_acquire+0xc2/0x2c0
    337 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x66/0x290 [mt7996e]
    338 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x50 [mt76]
    339 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100 [mt76]
    340 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 [mt76]
    341 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
    342 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
    343 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
    344 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
    345 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
    346 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
    347 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
    348 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
    349 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
    350 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
    351 Nov 12 10:40:51 ct523c-a0af kernel: irq event stamp: 27647
    352 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last  enabled at (27653): [<ffffffff813d447e>] __up_console_sem+0x5e/0x70
    353 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last disabled at (27658): [<ffffffff813d4463>] __up_console_sem+0x43/0x70
    354 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last  enabled at (26676): [<ffffffff81f2ad9c>] napi_pp_put_page+0xac/0xd0
355 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last disabled at (26674): [<ffffffff81fa3230>] page_pool_put_unrefed_netmem+0x290/0x3d0
    356 Nov 12 10:40:51 ct523c-a0af kernel: ---[ end trace 0000000000000000 ]---
    357 Nov 12 10:40:51 ct523c-a0af kernel:
    358 Nov 12 10:40:51 ct523c-a0af kernel: =============================
    359 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: suspicious RCU usage
    360 Nov 12 10:40:51 ct523c-a0af kernel: 6.18.0-rc5+ #25 Tainted: G S      W
    361 Nov 12 10:40:51 ct523c-a0af kernel: -----------------------------
    362 Nov 12 10:40:51 ct523c-a0af kernel: drivers/net/wireless/mediatek/mt76/mt7996/main.c:415 suspicious rcu_dereference_check() usage!
    363 Nov 12 10:40:51 ct523c-a0af kernel:
    364                                     other info that might help us debug this:
    365 Nov 12 10:40:51 ct523c-a0af kernel:
    366                                     rcu_scheduler_active = 2, debug_locks = 1
    367 Nov 12 10:40:51 ct523c-a0af kernel: 2 locks held by kworker/u32:4/115:
    368 Nov 12 10:40:51 ct523c-a0af kernel:  #0: ffff888118ebdd48 ((wq_completion)phy2){+.+.}-{0:0}, at: process_one_work+0x41c/0x6d0
    369 Nov 12 10:40:51 ct523c-a0af kernel:  #1: ffffc90000f1fe38 ((work_completion)(&(&dev->scan_work)->work)){+.+.}-{0:0}, at: process_one_work+ 
0x1e5/0x6d0
    370 Nov 12 10:40:51 ct523c-a0af kernel:
    371                                     stack backtrace:
    372 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm: kworker/u32:4 Tainted: G S      W           6.18.0-rc5+ #25 PREEMPT(full)
    373 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
    374 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
    375 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work [mt76]
    376 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
    377 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
    378 Nov 12 10:40:51 ct523c-a0af kernel:  dump_stack_lvl+0x8d/0xa0
    379 Nov 12 10:40:51 ct523c-a0af kernel:  lockdep_rcu_suspicious+0x146/0x1a0
    380 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x279/0x290 [mt7996e]
    381 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x50 [mt76]
    382 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100 [mt76]
    383 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 [mt76]
    384 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
    385 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
    386 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
    387 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
    388 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
    389 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
    390 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
    391 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
    392 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
    393 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
    394 Nov 12 10:40:54 ct523c-a0af kernel: ixgbe 0000:01:00.0 eth2: NIC Link is Up 10 Gbps, Flow Control: RX/TX
    395 Nov 12 10:40:54 ct523c-a0af kernel: ------------[ cut here ]------------

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


