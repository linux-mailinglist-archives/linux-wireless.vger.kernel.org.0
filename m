Return-Path: <linux-wireless+bounces-14648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B759B4EA7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFD6B2344B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D1196D90;
	Tue, 29 Oct 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Dw0LGLST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21245195F22
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217341; cv=none; b=SOS+wOxKBJHXo3Gq91JEWn12pk6Y4uDMrtnU0vOeDn79RhRTZpY/9QRTmdCm6VzvlOe5Iu2C4eNJc+CF8OBQ2Q/59Sw8s/Lifh1rMgzPDia0sF7c5rCivoOGEhfsVgbg8O0z9AYbi2us3Im+m1a1SANayPLlLO36GJlm9l7qobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217341; c=relaxed/simple;
	bh=Xa3jI1O/fJFm23Q+z242z8X2QEMb8dZF0+yVihi9UFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=REJLVQkm4RgQ6n5KLtNOOsREgzRYeJ/rhKxzECC51Sb8FZT7Kv2/xwqNzTYmLm1MO8aODU80zZ9TNUVTumYMQjjVluCUtQ+wli4a4nnXd+EVs33XQZrirmQlyuaQRnNfuw5Zq3V3Qm0ZSnLKBROVz62uo4uMw4M91HiI/Yvauv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Dw0LGLST; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 08341B80073;
	Tue, 29 Oct 2024 15:55:33 +0000 (UTC)
Received: from [10.252.34.165] (unknown [198.134.98.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7632B13C2B0;
	Tue, 29 Oct 2024 08:55:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7632B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1730217333;
	bh=Xa3jI1O/fJFm23Q+z242z8X2QEMb8dZF0+yVihi9UFI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Dw0LGLST1cNcPzrnhJLFEM3u4h6jfEp0IGkL+Kb5tPTu723NSS3nFT1MdPWGSr0AP
	 UXbkry5MF0BQWv8IEW/I4dCnN8FABPe+thbtKVPTblUP36okriHONMiS4vd+DUhS4m
	 kfSksVyDBlTFRE0/y9go6WK3a2YDZ8yFuaHRdz6c=
Message-ID: <9cfa23e6-3c4e-4c45-b6db-2148c9bdd2b0@candelatech.com>
Date: Tue, 29 Oct 2024 08:55:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on iwlwifi iwl_mvm_mac_itxq_xmit, possible busy-spin.
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <8dce89a1-350c-4885-afcc-0eda162fd76c@candelatech.com>
 <1f6d998c16510426e57b774c42358dcef7a5cd31.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <1f6d998c16510426e57b774c42358dcef7a5cd31.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1730217334-zPmPe0bPG4dR
X-MDID-O:
 us5;at1;1730217334;zPmPe0bPG4dR;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/29/24 1:01 AM, Johannes Berg wrote:
> On Mon, 2024-10-28 at 10:48 -0700, Ben Greear wrote:
>>
>> We see indication that the iwlwifi txpath can busy-spin,
>> causing soft-lockup (and, only indication at this point, possibly
>> issue is elsewhere somehow).
> 
> TX path I'm not aware of any issues, but we did have this recently:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219375
> 
>> But, I also wanted to check on expected behaviour.  At the bottom is a double
>> loop.  The inner will break out if the queues are full and for some other reasons,
>> but the outside loop is spinning on a different atomic counter. The question is:
>> If the inner loop breaks out, at least for queue full reasons, should it then
>> immediately break out of the outer while loop as well?
> 
> It shouldn't matter, but off the top of my head I'd say it's valid to
> break out entirely since the "queue no longer full" indication will
> restart it. In fact, it seems that'd really make more sense than the
> "sofar" thing you added. Not much value in retrying if the queue is full
> anyway?

The 'sofar' thing was just to ensure there is a hard upper limit on how many skb
it will try to send in one call.  At this point, I have no proof that is the cause of my problem,
so if we can reproduce we should see our debugging logs and know more...

> 
>> And, from what I can tell, it would be possible for other transmitters to hit this
>> path,
> 
> Not really? It should only get here from two places: userspace
> (serialized, so you're not going to get to this point with two threads
> from there), and the "queue no longer full" logic I mentioned above. Oh,
> maybe technically a third at the beginning after allocating a new queue.

How is user-space serialized here?  The comments in the code seem to assume
that multiple threads/whatever calling into this is expected (ie, the whole
3-state atomic counter).

>> Based on the description of the 3 tx_request states, I am also not sure that
>> this would not hang the tx path in case where inner loop bails out due to
>> tx queue full, leaving packets queued.  If no other packets are ever transmitted,
>> is there anything that would re-kick the xmit path?
> 
> If the queue becomes "not full", then yes, that kicks it again.
> 
> 
> I guess I could sort of see a scenario where
> 
>   - queues got full
>   - queues got not full
>   - we kick this logic via "queue not full"
>   - while this is running, userspace TX permanently bumps
>     tx_request from 1 to 2, this decrements it again, etc.

Considering GSO and KASAN slowness and highly loaded system, perhaps under memory pressure too,
maybe upper stack could feed the txq fast enough that something is always bumping
tx_requests to 2 before inner loop can finish?

> 
> What thread is the soft lockup in that you see?

I believe this below is the culprit.  Other threads are blocked on trying to grab xmit lock on
netdev and sock locks on tcp socket(s).

This is with our normal pile of hacks and patches applied.  There is some indication it is harder
to reproduce on stock 6.11 kernel, but also, we cannot reproduce reliably enough on local testbeds
to bisect or be sure stock cannot hit the issue.

Test case is a heavy load of http requests (like 300+ processes running in a hot loop,
lots of mac-vlans as well) across 16 radios, kernel is built with
kasan, lockdep and more.  I think lockdep disabled itself earlier due to some serial console splat which I
believe is harmless...though sucks it disables lockdep.  It is not easy to reproduce in most systems,
though certain (remote customers, of course) systems hit it often.

We seem to be hitting several different bugs in this area, one of which is use-after-free of an skb
related to tcp stack.  I guess it is possible somehow this lockup is caused by the gso logic called by iwlwifi.
There are several loops in gso segment path that could loop forever if a list got corrupted somehow.  But, no
KASAN splats in this case, so this particular issue below may be different.  I have added bail-out
logic to those other gso loops after 32k loop iterations, so if that is cause, we should also see
it in our new logs.

watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [irq/205-iwlwifi:909]
Modules linked in: nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nfnetlink vrf 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm 
ib_cm ib_core qrtr iwlmvm snd_hda_codec_hdmi snd_hda_codec_realtek intel_rapl_msr snd_hda_codec_generic snd_hda_scodec_component coretemp iTCO_wdt intel_pmc_bxt 
intel_rapl_common snd_hda_intel snd_intel_dspcfg intel_uncore_frequency ee1004 iTCO_vendor_support intel_uncore_frequency_common mac80211 snd_hda_codec 
snd_hda_core snd_hwdep snd_seq snd_seq_device iwlwifi snd_pcm intel_tcc_cooling x86_pkg_temp_thermal snd_timer i2c_i801 intel_wmi_thunderbolt intel_powerclamp 
pcspkr i2c_smbus snd i2c_mux soundcore cfg80211 mei_pxp mei_hdcp intel_pch_thermal intel_pmc_core intel_vsec pmt_telemetry acpi_pad pmt_class bfq sch_fq_codel 
nfsd auth_rpcgss nfs_acl lockd grace fuse sunrpc zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq 
i915 cec rc_core drm_buddy intel_gtt drm_display_helper drm_kms_helper igb
  ttm ixgbe mdio i2c_algo_bit dca agpgart hwmon mei_wdt drm video xhci_pci i2c_core xhci_pci_renesas wmi
irq event stamp: 19170042
hardirqs last  enabled at (19170042): [<ffffffff81a66490>] ___slab_alloc+0x2d0/0x12f0
hardirqs last disabled at (19170041): [<ffffffff81a672f9>] ___slab_alloc+0x1139/0x12f0
softirqs last  enabled at (18530504): [<ffffffffa206416b>] iwl_pcie_irq_rx_msix_handler+0x1fb/0x320 [iwlwifi]
softirqs last disabled at (18530505): [<ffffffff812a25b1>] do_softirq.part.0+0x41/0x90
CPU: 1 UID: 0 PID: 909 Comm: irq/205-iwlwifi Tainted: G             L     6.11.5+ #39
Tainted: [L]=SOFTLOCKUP
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
RIP: 0010:__orc_find+0x62/0xf0
Code: ff df 49 89 ff 48 89 fd eb 0c 48 8d 6b 04 49 89 df 49 39 ec 72 4e 4c 89 e2 48 29 ea 48 89 d6 48 c1 ea 3f 48 c1 fe 02 48 01 f2 <48> d1 fa 48 8d 5c 95 00 48 
89 da 48 c1 ea 03 0f b6 34 0a 48 89 da
RSP: 0000:ffff88841da87950 EFLAGS: 00000206
RAX: ffffffff85cd7284 RBX: ffffffff8598f4a4 RCX: dffffc0000000000
RDX: 0000000000000005 RSI: 0000000000000005 RDI: ffffffff8598f454
RBP: ffffffff8598f48c R08: ffffffff85cd7326 R09: 0000000000000000
R10: ffff88841da87a08 R11: ffffffff85cd729a R12: ffffffff8598f4a0
R13: ffffffff81adf0a2 R14: ffffffff8598f454 R15: ffffffff8598f488
FS:  0000000000000000(0000) GS:ffff88841da80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000bb35000 CR3: 0000000127420004 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  ? watchdog_timer_fn+0x2de/0x3b0
  ? lockup_detector_update_enable+0x50/0x50
  ? __hrtimer_run_queues+0x49a/0x860
  ? trace_hrtimer_cancel+0x130/0x130
  ? ktime_get_update_offsets_now+0x8c/0x2c0
  ? hrtimer_interrupt+0x2c9/0x7d0
  ? iwl_pcie_irq_rx_msix_handler+0x202/0x320 [iwlwifi]
  ? __sysvec_apic_timer_interrupt+0xc1/0x330
  ? sysvec_apic_timer_interrupt+0x35/0x90
  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
  ? kasan_save_track+0x12/0x60
  ? __orc_find+0x62/0xf0
  unwind_next_frame+0x161/0x1d20
  ? kasan_save_track+0x13/0x60
  ? kasan_save_track+0x13/0x60
  ? write_profile+0xf0/0xf0
  arch_stack_walk+0x82/0xf0
  ? kasan_save_track+0x13/0x60
  stack_trace_save+0x90/0xc0
  ? filter_irq_stacks+0x90/0x90
  ? kasan_save_stack+0x2a/0x40
  ? kasan_save_stack+0x1c/0x40
  ? kasan_save_track+0x13/0x60
  ? __kasan_slab_alloc+0x62/0x70
  ? kmem_cache_alloc_node_noprof+0xf6/0x2e0
  ? kmalloc_reserve+0x222/0x4d0
  ? __alloc_skb+0x114/0x390
  ? skb_segment+0xa2e/0x4350
  kasan_save_stack+0x1c/0x40
  ? kasan_save_stack+0x1c/0x40
  ? kasan_save_track+0x13/0x60
  ? iwl_mvm_tx_skb_sta+0x1098/0x1800 [iwlmvm]
  ? iwl_mvm_tx_skb+0x17/0x60 [iwlmvm]
  ? iwl_mvm_mac_itxq_xmit+0x1de/0x3e0 [iwlmvm]
  ? ieee80211_queue_skb+0x10ce/0x2010 [mac80211]
  ? __ieee80211_xmit_fast+0x5fe/0x37f0 [mac80211]
  ? __ieee80211_subif_start_xmit+0x6d9/0x1150 [mac80211]
  ? ieee80211_subif_start_xmit+0xf7/0x1630 [mac80211]
  ? dev_hard_start_xmit+0xf5/0x570
  ? __dev_queue_xmit+0x750/0x35d0
  ? ip_finish_output2+0x10ad/0x1fc0
  ? __ip_queue_xmit+0x864/0x1e30
  ? __tcp_transmit_skb+0x169e/0x3850
  ? tcp_write_xmit+0x13f7/0x8700
  ? __tcp_push_pending_frames+0x90/0x310
  ? tcp_rcv_established+0x799/0x20e0
  ? tcp_v4_do_rcv+0x495/0x860
  ? tcp_v4_rcv+0x2adc/0x4070
  ? ip_protocol_deliver_rcu+0x7e/0x300
  ? ip_local_deliver_finish+0x297/0x410
  ? ip_local_deliver+0x18d/0x430
  ? ip_sublist_rcv_finish+0x8c/0x260
  ? ip_sublist_rcv+0x451/0x870
  ? ip_list_rcv+0x2c6/0x3d0
  ? __netif_receive_skb_list_core+0x47d/0x890
  ? netif_receive_skb_list_internal+0x615/0xcc0
  ? napi_complete_done+0x1c9/0x7c0
  ? iwl_pcie_napi_poll_msix+0x1db/0x270 [iwlwifi]
  ? __napi_poll.constprop.0+0x9e/0x430
  ? net_rx_action+0x8ec/0xe20
  ? handle_softirqs+0x1bc/0x810
  ? do_softirq.part.0+0x41/0x90
  ? __local_bh_enable_ip+0xfb/0x120
  ? iwl_pcie_irq_rx_msix_handler+0x203/0x320 [iwlwifi]
  ? irq_thread_fn+0x84/0x150
  ? irq_thread+0x2f2/0x5a0
  ? kthread+0x2da/0x3c0
  ? ret_from_fork+0x2d/0x70
  ? ret_from_fork_asm+0x11/0x20
  ? handle_softirqs+0x1bc/0x810
  ? do_softirq.part.0+0x41/0x90
  ? __local_bh_enable_ip+0xfb/0x120
  ? iwl_pcie_irq_rx_msix_handler+0x203/0x320 [iwlwifi]
  ? irq_thread_fn+0x84/0x150
  ? irq_thread+0x2f2/0x5a0
  ? kthread+0x2da/0x3c0
  ? ret_from_fork+0x2d/0x70
  ? ret_from_fork_asm+0x11/0x20
  ? local_clock_noinstr+0x9/0xb0
  ? local_clock+0x11/0x30
  ? kasan_save_track+0x22/0x60
  ? __kasan_slab_alloc+0x62/0x70
  kasan_save_track+0x13/0x60
  __kasan_slab_alloc+0x62/0x70
  kmem_cache_alloc_node_noprof+0xf6/0x2e0
  __alloc_skb+0x26c/0x390
  ? __napi_build_skb+0x50/0x50
  ? __asan_memcpy+0x38/0x60
  skb_segment+0xa2e/0x4350
  ? ieee80211_tx_dequeue+0x139b/0x4a00 [mac80211]
  ? pskb_extract+0x230/0x230
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  tcp_gso_segment+0x2eb/0x1a00
  ? skb_still_in_host_queue+0x260/0x260
  ? lock_acquire+0x19a/0x4f0
  ? skb_mac_gso_segment+0x150/0x4c0
  ? lock_is_held_type+0xa5/0x110
  inet_gso_segment+0x426/0x12d0
  ? skb_csum_hwoffload_help+0xc0/0x100
  skb_mac_gso_segment+0x221/0x4c0
  ? skb_gso_transport_seglen+0x2e0/0x2e0
  ? print_usage_bug.part.0+0x600/0x600
  ? lock_acquire+0x19a/0x4f0
  __skb_gso_segment+0x2c4/0x5b0
  iwl_mvm_tx_tso_segment+0x77c/0xfa0 [iwlmvm]
  ? lock_is_held_type+0xa5/0x110
  ? ieee80211_xmit_fast_finish+0xad/0xa80 [mac80211]
  ? iwl_mvm_skb_prepare_status+0xd0/0xd0 [iwlmvm]
  ? iwl_mvm_get_lmac_id+0x42/0x90 [iwlmvm]
  iwl_mvm_tx_skb_sta+0x1098/0x1800 [iwlmvm]
  ? iwl_mvm_max_amsdu_size+0x750/0x750 [iwlmvm]
  ? mark_lock+0x101/0x16b0
  ? lock_release+0x211/0x680
  ? ieee80211_queue_skb+0xe98/0x2010 [mac80211]
  iwl_mvm_tx_skb+0x17/0x60 [iwlmvm]
  iwl_mvm_mac_itxq_xmit+0x1de/0x3e0 [iwlmvm]
  ? iwl_mvm_mac_wake_tx_queue+0x4d/0x2d0 [iwlmvm]
  ? lockdep_hardirqs_on_prepare+0x127/0x3e0
  ieee80211_queue_skb+0x10ce/0x2010 [mac80211]
  ? lockdep_hardirqs_on_prepare+0x307/0x3e0
  __ieee80211_xmit_fast+0x5fe/0x37f0 [mac80211]
  ? netdev_nl_stats_write_tx+0x667/0x760
  ? reacquire_held_locks+0x466/0x4e0
  ? ieee80211_clear_fast_xmit+0xd0/0xd0 [mac80211]
  ? skb_gso_transport_seglen+0x2e0/0x2e0
  ? __ip_queue_xmit+0x864/0x1e30
  ? lock_is_held_type+0xa5/0x110
  ? __skb_gso_segment+0x2c4/0x5b0
  ? lock_is_held_type+0xa5/0x110
  __ieee80211_subif_start_xmit+0x6d9/0x1150 [mac80211]
  ? lock_acquire+0x19a/0x4f0
  ? find_held_lock+0x2d/0x110
  ? __ieee80211_xmit_fast+0x37f0/0x37f0 [mac80211]
  ? mark_held_locks+0x9e/0xe0
  ieee80211_subif_start_xmit+0xf7/0x1630 [mac80211]
  ? lock_release+0x211/0x680
  ? dev_queue_xmit_nit+0x725/0xa50
  ? reacquire_held_locks+0x4e0/0x4e0
  ? __ieee80211_subif_start_xmit+0x1150/0x1150 [mac80211]
  ? packet_rcv+0x144/0x1310
  ? __skb_clone+0x54c/0x730
  ? run_filter+0x320/0x320
  ? dev_queue_xmit_nit+0x72a/0xa50
  ? dev_hard_start_xmit+0xf5/0x570
  dev_hard_start_xmit+0xf5/0x570
  __dev_queue_xmit+0x750/0x35d0
  ? __lock_acquire+0x1be3/0x62d0
  ? netdev_core_pick_tx+0x290/0x290
  ? ehci_urb_enqueue+0x3a03/0x5de0
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? print_usage_bug.part.0+0x600/0x600
  ? find_held_lock+0x2d/0x110
  ? lock_acquire+0x19a/0x4f0
  ? find_held_lock+0x2d/0x110
  ? lock_release+0x211/0x680
  ? __ip_queue_xmit+0x864/0x1e30
  ? reacquire_held_locks+0x4e0/0x4e0
  ? lock_is_held_type+0xa5/0x110
  ? mark_held_locks+0x9e/0xe0
  ? nf_hook+0x2de/0x430
  ip_finish_output2+0x10ad/0x1fc0
  ? ip_fragment.constprop.0+0x220/0x220
  ? __ip_finish_output+0x311/0x520
  __ip_queue_xmit+0x864/0x1e30
  ? __skb_clone+0x54c/0x730
  __tcp_transmit_skb+0x169e/0x3850
  ? lock_acquire+0x19a/0x4f0
  ? __tcp_select_window+0xfb0/0xfb0
  ? lock_release+0x211/0x680
  ? ktime_get+0x2e/0x140
  ? reacquire_held_locks+0x4e0/0x4e0
  ? lockdep_hardirqs_on_prepare+0x127/0x3e0
  ? tcp_small_queue_check.isra.0+0x146/0x3f0
  tcp_write_xmit+0x13f7/0x8700
  ? tcp_data_ready+0x350/0x350
  ? tcp_send_dupack+0x7b0/0x7b0
  __tcp_push_pending_frames+0x90/0x310
  tcp_rcv_established+0x799/0x20e0
  ? lock_sync+0x170/0x170
  ? tcp_ioctl+0x640/0x640
  ? tcp_check_space+0x5d0/0x5d0
  ? do_raw_spin_lock+0x12d/0x270
  tcp_v4_do_rcv+0x495/0x860
  tcp_v4_rcv+0x2adc/0x4070
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? lock_acquire+0x19a/0x4f0
  ? tcp_v4_early_demux+0x910/0x910
  ? raw_rcv+0x6e0/0x6e0
  ? lock_is_held_type+0xa5/0x110
  ? lock_is_held_type+0xa5/0x110
  ip_protocol_deliver_rcu+0x7e/0x300
  ip_local_deliver_finish+0x297/0x410
  ? inet_ehashfn+0x1f0/0x1f0
  ip_local_deliver+0x18d/0x430
  ? ip_local_deliver_finish+0x410/0x410
  ? lock_is_held_type+0xa5/0x110
  ? tcp_v4_early_demux+0x561/0x910
  ? lock_is_held_type+0xa5/0x110
  ? lock_is_held_type+0xa5/0x110
  ip_sublist_rcv_finish+0x8c/0x260
  ip_sublist_rcv+0x451/0x870
  ? ip_rcv_finish_core.constprop.0+0x1e70/0x1e70
  ? __asan_memset+0x1f/0x40
  ? ip_rcv_core+0x608/0xcc0
  ? __lock_acquire+0xd42/0x62d0
  ip_list_rcv+0x2c6/0x3d0
  ? ip_rcv+0x330/0x330
  ? mark_lock+0x101/0x16b0
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? print_usage_bug.part.0+0x600/0x600
  __netif_receive_skb_list_core+0x47d/0x890
  ? __netif_receive_skb_core.constprop.0+0x3a10/0x3a10
  ? iwl_pcie_rx_handle+0x116f/0x2580 [iwlwifi]
  ? __lock_acquire+0x1be3/0x62d0
  netif_receive_skb_list_internal+0x615/0xcc0
  ? iwl_pcie_rx_handle+0x116f/0x2580 [iwlwifi]
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? process_backlog+0x1230/0x1230
  ? find_held_lock+0x2d/0x110
  napi_complete_done+0x1c9/0x7c0
  ? do_raw_spin_lock+0x121/0x270
  ? napi_busy_loop+0x110/0x110
  ? spin_bug+0x1d0/0x1d0
  iwl_pcie_napi_poll_msix+0x1db/0x270 [iwlwifi]
  __napi_poll.constprop.0+0x9e/0x430
  net_rx_action+0x8ec/0xe20
  ? __napi_poll.constprop.0+0x430/0x430
  ? lock_sync+0x170/0x170
  ? do_raw_spin_lock+0x12d/0x270
  ? find_held_lock+0x2d/0x110
  ? mark_held_locks+0x9e/0xe0
  handle_softirqs+0x1bc/0x810
  ? iwl_pcie_irq_rx_msix_handler+0x1fb/0x320 [iwlwifi]
  do_softirq.part.0+0x41/0x90
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0xfb/0x120
  ? iwl_pcie_irq_rx_msix_handler+0x1fb/0x320 [iwlwifi]
  iwl_pcie_irq_rx_msix_handler+0x203/0x320 [iwlwifi]
  ? iwl_pcie_rx_free+0x550/0x550 [iwlwifi]
  irq_thread_fn+0x84/0x150
  irq_thread+0x2f2/0x5a0
  ? disable_irq_nosync+0x10/0x10
  ? wake_threads_waitq+0x40/0x40
  ? irq_thread+0x5a0/0x5a0
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  ? __kthread_parkme+0xba/0x1e0
  ? wake_threads_waitq+0x40/0x40
  kthread+0x2da/0x3c0
  ? kthread_insert_work_sanity_check+0xd0/0xd0
  ret_from_fork+0x2d/0x70
  ? kthread_insert_work_sanity_check+0xd0/0xd0
  ret_from_fork_asm+0x11/0x20
  </TASK>

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

