Return-Path: <linux-wireless+bounces-13378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAC98BD79
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F63E2854F3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D81C579E;
	Tue,  1 Oct 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WI3og/fx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDD1C3F0B
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789240; cv=none; b=ZqDNSOsxvOIYXO22jrjPqHp7RvZeK2knxtq1yd3rVuTcP+A/WLm5R7BxmMNjV/RFtOxXdjMIQDcxq/ZcLaebNqrHwk3oiyy+AxGwguqpvuAUTgF93812nPdDrCJ5bnAthHmzDpL/UFoPVvn8Y5eXOz4OjKWGUbJ4iT2QgJvFsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789240; c=relaxed/simple;
	bh=FmGYt4JEzS5fJoDvr4qTzEZb7ezKvmy9Ix/0XdAMfdE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PFPrfT/hbs4M0BASbopdYc1Wp3iw/CbyppV2U30KNTj9gXp/G5S5GaWT8v9WGD22CRIzSYhwVj48VcP4ft0CC2Ydn3FCupr4nCCY1SzB91D9P9u6cXfk0xph3vRdHxk/LwMQhlTrniLp2P9zEPEAg1ed/yW+UXVxqgNyX8Neq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WI3og/fx; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9699A280074;
	Tue,  1 Oct 2024 13:27:09 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.40.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 525D313C2B0;
	Tue,  1 Oct 2024 06:27:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 525D313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727789227;
	bh=FmGYt4JEzS5fJoDvr4qTzEZb7ezKvmy9Ix/0XdAMfdE=;
	h=Date:To:Cc:From:Subject:From;
	b=WI3og/fxk4RTmoJCk0YTF5tGVOYH76Rwp86OHca4XtHqrg6HmoMFKawvcomoSvHZo
	 M50UBlnBTQizM1Elvfjxs/rjh5LDX+JkAKCDsSNOjzFB2WgmUo9jezDHbsplV/ZXU7
	 TjTHqRc1Lbzc+rRcWQ1Tg73TdyJm1Zh9Y2Nc7K3U=
Message-ID: <6e69854b-7d03-4227-9b65-8166b451a984@candelatech.com>
Date: Tue, 1 Oct 2024 06:27:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi ax210 soft lockup on upstream 6.11.0
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1727789237-zRibQTsonpE8
X-MDID-O:
 us5;ut7;1727789237;zRibQTsonpE8;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

Hello,

We ran some tests on 6.11.0 plus a single patch to fix the VRF deadlock,
and I believe we are hitting a spin-forever type of bug in the iwlwifi
transmit logic.

This bug is reproducible after an hour or two of heavy traffic load
across 12 ax210 radios.  There are lots of mac-vlans on the system
as well, but I don't see indication that is part of the problem.

This same test case, on a more heavily patched kernel, sometimes shows a tcp_ack
crash in what appears to be a corrupted list.  I'm not sure if the
lockup below is directly related to that or not, but possibly
a corrupted list is making the gso logic spin forever?

This kernel has KASAN, lockdep, list debugging, and everything else
I know to turn on to debug this sort of thing.

The full log of the lockup is found here:

https://www.candelatech.com/downloads/6.11.0dbg30sept.txt


watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [btserver:28762]
Modules linked in: tls nf_conntrack_netlink nf_conntrack nfnetlink btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat jfs nls_ucs2_utils xfs nf_defrag_ipv6 
nf_defrag_ipv4 vrf 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr iwlmvm snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_codec_generic iTCO_wdt ee1004 snd_hda_scodec_component intel_pmc_bxt intel_rapl_msr iTCO_vendor_support snd_hda_intel snd_intel_dspcfg coretemp 
intel_rapl_common snd_hda_codec intel_uncore_frequency snd_hda_core intel_uncore_frequency_common mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm iwlwifi 
intel_tcc_cooling x86_pkg_temp_thermal snd_timer intel_powerclamp intel_wmi_thunderbolt i2c_i801 snd i2c_smbus pcspkr soundcore i2c_mux bfq cfg80211 mei_hdcp 
mei_pxp intel_pch_thermal intel_pmc_core intel_vsec pmt_telemetry pmt_class acpi_pad sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc zram raid1 dm_raid 
raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915
  cec rc_core drm_buddy intel_gtt drm_display_helper ixgbe drm_kms_helper igb mdio ttm dca i2c_algo_bit agpgart hwmon drm mei_wdt xhci_pci i2c_core 
xhci_pci_renesas video wmi fuse [last unloaded: nfnetlink]
irq event stamp: 462966149
hardirqs last  enabled at (462966148): [<ffffffff81a5688b>] ___slab_alloc+0x2cb/0x12e0
hardirqs last disabled at (462966149): [<ffffffff83eb133a>] sysvec_apic_timer_interrupt+0xa/0x90
softirqs last  enabled at (461971904): [<ffffffff8129bd51>] __irq_exit_rcu+0x91/0xc0
softirqs last disabled at (461971910): [<ffffffff835b0afa>] __dev_queue_xmit+0x21a/0x36e0
CPU: 1 UID: 0 PID: 28762 Comm: btserver Tainted: G        W    L     6.11.0+ #2
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
RIP: 0010:unwind_next_frame+0x35b/0x2320
Code: 89 ea 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e b9 15 00 00 41 c7 45 00 00 00 00 00 31 c0 48 83 c4 38 5b 5d 41 5c 41 5d <41> 5e 41 5f c3 49 81 ff 00 
a0 10 86 0f 83 af 01 00 00 4c 89 ff e8
RSP: 0018:ffff88820c31e180 EFLAGS: 00000296
RAX: 0000000000000001 RBX: ffffffff814ed640 RCX: ffffffff85fb5dea
RDX: 1ffff11041863c35 RSI: 0000000000000000 RDI: ffff88820c31e1a8
RBP: ffff88820c31e230 R08: ffffffff85fb5dee R09: ffff88820c31e1d8
R10: ffff88820c31e198 R11: 0000000000030000 R12: ffff88820c31e260
R13: 0000000000000000 R14: ffff88820c31ff48 R15: 0000000000000001
FS:  00007f340183a7c0(0000) GS:ffff88841da80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000149adaa8 CR3: 000000013a2c8005 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  ? watchdog_timer_fn+0x2d9/0x3b0
  ? lockup_detector_update_enable+0x50/0x50
  ? __hrtimer_run_queues+0x495/0x860
  ? trace_hrtimer_cancel+0x130/0x130
  ? ktime_get_update_offsets_now+0x87/0x2c0
  ? hrtimer_interrupt+0x2c4/0x7d0
  ? __sysvec_apic_timer_interrupt+0xbc/0x380
  ? sysvec_apic_timer_interrupt+0x69/0x90
  </IRQ>
  <TASK>
  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
  ? write_profile+0xe0/0xe0
  ? unwind_next_frame+0x35b/0x2320
  arch_stack_walk+0x7d/0xe0
  stack_trace_save+0x8b/0xc0
  ? filter_irq_stacks+0x90/0x90
  ? kasan_save_stack+0x2a/0x40
  ? kasan_save_stack+0x1c/0x40
  ? kasan_save_track+0x10/0x30
  ? __kasan_slab_alloc+0x62/0x70
  ? kmem_cache_alloc_node_noprof+0xf1/0x2e0
  ? kmalloc_reserve+0x21d/0x4d0
  kasan_save_stack+0x1c/0x40
  ? kasan_save_stack+0x1c/0x40
  ? kasan_save_track+0x10/0x30
  ? __kasan_slab_alloc+0x62/0x70
  ? kmem_cache_alloc_node_noprof+0xf1/0x2e0
  ? __alloc_skb+0x267/0x390
  ? skb_segment+0xad2/0x4260
  ? tcp_gso_segment+0x311/0x1ac0
  ? inet_gso_segment+0x465/0x15a0
  ? skb_mac_gso_segment+0x227/0x540
  ? __skb_gso_segment+0x2bf/0x5a0
  ? iwl_mvm_tx_tso_segment+0x7b4/0x1070 [iwlmvm]
  ? iwl_mvm_tx_skb_sta+0x10b1/0x1700 [iwlmvm]
  ? iwl_mvm_tx_skb+0x12/0x60 [iwlmvm]
  ? iwl_mvm_mac_itxq_xmit+0x1d9/0x3e0 [iwlmvm]
  ? ieee80211_queue_skb+0x10c9/0x2010 [mac80211]
  ? __ieee80211_xmit_fast+0x5f9/0x37f0 [mac80211]
  ? __ieee80211_subif_start_xmit+0x6d4/0x1150 [mac80211]
  ? ieee80211_subif_start_xmit+0xf2/0x1630 [mac80211]
  ? dev_hard_start_xmit+0xf0/0x570
  ? __dev_queue_xmit+0x794/0x36e0
  ? ip_finish_output2+0x10cd/0x1ff0
  ? __ip_queue_xmit+0x85f/0x1e20
  ? __tcp_transmit_skb+0x1699/0x3850
  ? tcp_write_xmit+0x14ac/0x8b50
  ? __tcp_push_pending_frames+0x8b/0x310
  ? tcp_sendmsg_locked+0x20de/0x31e0
  ? tcp_sendmsg+0x22/0x40
  ? __sock_sendmsg+0xbc/0x150
  ? __sys_sendto+0x19c/0x250
  ? __x64_sys_sendto+0xd7/0x1b0
  ? do_syscall_64+0x69/0x160
  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
  ? ___slab_alloc+0x2cb/0x12e0
  ? kasan_save_track+0x10/0x30
  ? __kasan_kmalloc+0x83/0x90
  ? __kmalloc_node_noprof+0x35f/0x420
  ? alloc_slab_obj_exts+0x4c/0xa0
  ? alloc_slab_obj_exts+0x4c/0xa0
  ? kasan_save_track+0x10/0x30
  ? __kasan_slab_alloc+0x62/0x70
  kasan_save_track+0x10/0x30
  __kasan_slab_alloc+0x62/0x70
  kmem_cache_alloc_node_noprof+0xf1/0x2e0
  ? __build_skb_around+0x235/0x3f0
  __alloc_skb+0x267/0x390
  ? __napi_build_skb+0x40/0x40
  ? skb_segment+0xc19/0x4260
  ? kasan_check_range+0x109/0x190
  ? __asan_memcpy+0x38/0x60
  skb_segment+0xad2/0x4260
  ? pskb_extract+0x230/0x230
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? print_usage_bug.part.0+0x600/0x600
  tcp_gso_segment+0x311/0x1ac0
  ? skb_still_in_host_queue+0x250/0x250
  ? lock_is_held_type+0xa5/0x110
  inet_gso_segment+0x465/0x15a0
  skb_mac_gso_segment+0x227/0x540
  ? mark_lock+0x101/0x16c0
  ? skb_gso_validate_mac_len+0x270/0x270
  ? print_usage_bug.part.0+0x600/0x600
  __skb_gso_segment+0x2bf/0x5a0
  iwl_mvm_tx_tso_segment+0x7b4/0x1070 [iwlmvm]
  ? invoke_tx_handlers_late+0x15c/0x2950 [mac80211]
  ? lock_is_held_type+0xa5/0x110
  ? ieee80211_xmit_fast_finish+0xa8/0xa80 [mac80211]
  ? iwl_mvm_skb_prepare_status+0x60/0x60 [iwlmvm]
  ? iwl_mvm_get_lmac_id+0x3d/0x80 [iwlmvm]
  iwl_mvm_tx_skb_sta+0x10b1/0x1700 [iwlmvm]
  ? iwl_mvm_max_amsdu_size+0x750/0x750 [iwlmvm]
  ? mark_lock+0x101/0x16c0
  ? lock_release+0x211/0x680
  ? ieee80211_queue_skb+0xe93/0x2010 [mac80211]
  iwl_mvm_tx_skb+0x12/0x60 [iwlmvm]
  iwl_mvm_mac_itxq_xmit+0x1d9/0x3e0 [iwlmvm]
  ? iwl_mvm_mac_wake_tx_queue+0x48/0x2d0 [iwlmvm]
  ? lockdep_hardirqs_on_prepare+0x127/0x3e0
  ieee80211_queue_skb+0x10c9/0x2010 [mac80211]
  ? lockdep_hardirqs_on_prepare+0x327/0x3e0
  __ieee80211_xmit_fast+0x5f9/0x37f0 [mac80211]
  ? netdev_nl_stats_write_tx+0x167/0x760
  ? reacquire_held_locks+0x456/0x4e0
  ? ieee80211_clear_fast_xmit+0xd0/0xd0 [mac80211]
  ? skb_gso_validate_mac_len+0x270/0x270
  ? __skb_gso_segment+0x2bf/0x5a0
  ? lock_is_held_type+0xa5/0x110
  __ieee80211_subif_start_xmit+0x6d4/0x1150 [mac80211]
  ? find_held_lock+0x2d/0x110
  ? __ieee80211_xmit_fast+0x37f0/0x37f0 [mac80211]
  ? reacquire_held_locks+0x4e0/0x4e0
  ieee80211_subif_start_xmit+0xf2/0x1630 [mac80211]
  ? lock_release+0x211/0x680
  ? dev_queue_xmit_nit+0x720/0xa40
  ? reacquire_held_locks+0x4e0/0x4e0
  ? __ieee80211_subif_start_xmit+0x1150/0x1150 [mac80211]
  ? __skb_clone+0x547/0x730
  ? run_filter+0x310/0x310
  ? dev_queue_xmit_nit+0x725/0xa40
  ? dev_hard_start_xmit+0xf0/0x570
  dev_hard_start_xmit+0xf0/0x570
  __dev_queue_xmit+0x794/0x36e0
  ? __lock_acquire+0x1c01/0x6300
  ? netdev_core_pick_tx+0x2e0/0x2e0
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? print_usage_bug.part.0+0x600/0x600
  ? find_held_lock+0x2d/0x110
  ? lock_acquire+0x19a/0x4f0
  ? find_held_lock+0x2d/0x110
  ? lock_release+0x211/0x680
  ? __ip_queue_xmit+0x85f/0x1e20
  ? reacquire_held_locks+0x4e0/0x4e0
  ? lock_is_held_type+0xa5/0x110
  ? mark_held_locks+0x9e/0xe0
  ? nf_hook+0x2de/0x430
  ip_finish_output2+0x10cd/0x1ff0
  ? lock_is_held_type+0x63/0x110
  ? ip_fragment.constprop.0+0x220/0x220
  ? __ip_finish_output+0x30c/0x520
  __ip_queue_xmit+0x85f/0x1e20
  ? __skb_clone+0x547/0x730
  __tcp_transmit_skb+0x1699/0x3850
  ? __tcp_select_window+0xfb0/0xfb0
  ? __alloc_skb+0x2c6/0x390
  ? __napi_build_skb+0x40/0x40
  tcp_write_xmit+0x14ac/0x8b50
  ? copy_page_to_iter+0x100/0x100
  __tcp_push_pending_frames+0x8b/0x310
  tcp_sendmsg_locked+0x20de/0x31e0
  ? print_usage_bug.part.0+0x5c3/0x600
  ? tcp_sendmsg_fastopen+0x6e0/0x6e0
  ? lock_release+0x211/0x680
  ? tcp_sendmsg+0x14/0x40
  ? inet_send_prepare+0x3d0/0x3d0
  ? inet_send_prepare+0x3d0/0x3d0
  tcp_sendmsg+0x22/0x40
  __sock_sendmsg+0xbc/0x150
  __sys_sendto+0x19c/0x250
  ? __ia32_sys_getpeername+0xa0/0xa0
  ? handle_irq_event+0x107/0x1b0
  ? __fget_light+0x4d/0x1d0
  ? __common_interrupt+0x62/0x110
  ? ksys_read+0x166/0x1c0
  ? __ia32_sys_pwrite64+0x1d0/0x1d0
  __x64_sys_sendto+0xd7/0x1b0
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  do_syscall_64+0x69/0x160
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f3401b13680
Code: 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 68 c3 
0f 1f 80 00 00 00 00 55 48 83 ec 20 48
RSP: 002b:00007ffdb34580b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000000000000ffdc RCX: 00007f3401b13680
RDX: 0000000000010000 RSI: 000000002bc4f000 RDI: 0000000000000077
RBP: 00007ffdb34581a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000723
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
  </TASK>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

