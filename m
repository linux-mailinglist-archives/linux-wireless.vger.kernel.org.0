Return-Path: <linux-wireless+bounces-34676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJxXOfFQ3GlYPQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 04:12:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF03E6BE3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 04:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E7643001FAA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670A21E098;
	Mon, 13 Apr 2026 02:11:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC71FC7;
	Mon, 13 Apr 2026 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776046314; cv=none; b=jhDmiA+KZRX6ABYiwDpjoBV/ocvHkLB3dtbunWLuR4JAUBWwkPCbp0otRZmk4CQZRmoO7Pbd/YK+NuUedDBOPstUKnKl0jlPcDoawNoGcEHCR5tU5owRGcKvbvHLpJvOE/3QIa+eriEaQZCYai5jUlZIzIwOvLsQ5yZ3+PSx7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776046314; c=relaxed/simple;
	bh=5M8noxGCcnfaaZU81xO7iNBInA3/Lnd8U2tTM4USWrs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=CL3vSK/RUScH4O7ZyJEJmHoP4j91tLU9ndRaZJmad656cXas9SiP35UgG7NrB2t8ftR4CC7/8D5AL4eipFbqYbOXHqeOf/k2ZX5odXOKl0zdO/Cr5i18NeFvpFdq67ip5uvv9b8IKZw0nOEHry9rhfhXzt7ATHIAmtmYQS9oKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Content-Type: multipart/mixed; boundary="------------dkyYWvXVi2hDuZ0MqV3I0GAn"
Message-ID: <9771da26-dae7-40e3-b55e-6a1892886458@unwrap.rs>
Date: Sun, 12 Apr 2026 19:09:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: iwlwifi: prevent NAPI processing after firmware
 error
To: Ben Greear <greearb@candelatech.com>, johannes.berg@intel.com,
 miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org
References: <20260214181018.6091-1-cole@unwrap.rs>
 <20260214184352.11512-1-cole@unwrap.rs>
 <e6d6d4ad-475a-7bad-0dc9-6a920ed7f8ed@candelatech.com>
Content-Language: en-US
From: Cole Leavitt <cole@unwrap.rs>
In-Reply-To: <e6d6d4ad-475a-7bad-0dc9-6a920ed7f8ed@candelatech.com>
X-Spamd-Result: default: False [1.64 / 15.00];
	DMARC_POLICY_REJECT(2.00)[unwrap.rs : SPF not aligned (strict), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,multipart/related,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~,6:~,7:+];
	TAGGED_FROM(0.00)[bounces-34676-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cole@unwrap.rs,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.878];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C9DF03E6BE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------dkyYWvXVi2hDuZ0MqV3I0GAn
Content-Type: multipart/alternative;
 boundary="------------k70yhXO3NPSb4Ql6IY5gnrkw"

--------------k70yhXO3NPSb4Ql6IY5gnrkw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ben,

Thanks for the confirmation and the detailed logs. The Feb 26 trace is
exactly the scenario we designed the check for -- SYSTEM_STATISTICS_CMD
times out, driver forces NMI, and ksoftirqd/3 hits our WARN in
iwl_pcie_napi_poll_msix while the error dump is still printing. Good to
see it catching the race in production.

I owe you a correction on the TSO patch (2/3). You were right that my
commit message overclaimed causation between the 32k segment explosion
and the TCP UAF. I've been digging deeper into your Feb 16 crash trace
and here's what I've found I think:

The refcount underflow in tcp_shifted_skb is NOT a use-after-free.
I looked at your free_status debugging (commit 3b5f7046f in your tree)
and the fact that none of your checks fire means the skb is still
validly allocated when the underflow happens. The refcount that
underflows is sk->sk_wmem_alloc (the socket's write memory accounting),
not skb->users or dataref.

The crash path is:
   tcp_shifted_skb -> tcp_rtx_queue_unlink_and_free -> tcp_wmem_free_skb
   -> __kfree_skb -> skb_release_head_state -> sock_wfree
   -> __refcount_sub_and_test(len, &sk->sk_wmem_alloc) -> UNDERFLOW

Something is subtracting more from sk_wmem_alloc than was added. I
traced every charge/drain path:

   Charges: skb_set_owner_w() at creation, tcp_transmit_skb:1601 at clone
   Drains:  sock_wfree() or tcp_wfree() at destructor time

I also verified:
   - TCP clones before sending (tcp_output.c:1539), so the TSO
     segmentation operates on the clone, not the retransmit original
   - skb_clone sets destructor=NULL (skbuff.c:1625), tcp_transmit_skb
     re-sets it with a fresh refcount_add -- balanced per-skb
   - pskb_expand_head in mac80211 (tx.c:2016) does NOT modify truesize
     on TCP-owned skbs because of the guard at skbuff.c:2367
   - skb_shift truesize changes during SACK coalescing are
     self-balancing across the source/target pair

I've exhausted what I can find from code analysis alone. The accounting
mismatch is real but I can't identify the exact path without tracing
on the hardware.

I wrote a small debug patch that adds trace_printk at every
sk_wmem_alloc modification point:

   - skb_set_owner_w(): charge at creation
   - tcp_transmit_skb(): charge at clone
   - sock_wfree(): drain (generic)
   - tcp_wfree(): drain (TCP fast path)
   - skb_shift(): truesize change during SACK coalescing

Could you apply the attached patch, reproduce against the problem AP,
and send me the ftrace output? The skb pointer in each trace line lets
us correlate exactly which charge/drain pair is imbalanced.

   echo 1 > /sys/kernel/debug/tracing/tracing_on
   # reproduce
   cat /sys/kernel/debug/tracing/trace > /tmp/wmem_trace.txt

The trace will be noisy (every TCP packet), so grep for the socket
address from your crash (R12=ffff88820165f200 in your Feb 16 dump) to
filter to the relevant connection.

Separately, the TSO sentinel fix and the NAPI race fix are still correct
regardless of the TCP accounting issue. The sentinel value 1 producing
num_subframes=0 is a real bug -- I verified that only 7 code paths in
the entire kernel write max_tid_amsdu_len, and through legitimate MLD
code the only value that produces zero is the sentinel 1 from the TLC
notification. The WARN_ON_ONCE(!num_subframes) guard in the v2 patch
catches any corruption-induced zeros from unknown paths.

On your remaining 32k GSO spins after applying the sentinel fix: since
legitimate code can only produce values 0 (caught by existing check) or
1 (caught by our new check) or >= 2000 (safe), values 2-1533 that would
also produce num_subframes=0 can only come from memory corruption. Does
the WARN_ON_ONCE fire? If so, what max_tid_amsdu_len value does the
pr_warn_once in your tree (commit 9dd9677f5) print?

Cole

On 26/02/2026 12.37, Ben Greear wrote:
> On 2/14/26 10:43, Cole Leavitt wrote:
>> After a firmware error is detected and STATUS_FW_ERROR is set, NAPI can
>> still be actively polling or get scheduled from a prior interrupt. The
>> NAPI poll functions (both legacy and MSIX variants) have no check for
>> STATUS_FW_ERROR and will continue processing stale RX ring entries from
>> dying firmware. This can dispatch TX completion notifications containing
>> corrupt SSN values to iwl_mld_handle_tx_resp_notif(), which passes them
>> to iwl_trans_reclaim(). If the corrupt SSN causes reclaim to walk TX
>> queue entries that were already freed by a prior correct reclaim, the
>> result is an skb use-after-free or double-free.
>
> Hello Cole,
>
> We've been testing with this patch, and today managed to see its logic 
> trigger.
> The system had a cascade of other errors leading to use-after-free 
> that does
> not appear to be related to the skb use-after free, but I can at least 
> confirm your
> patch can be triggered.  Here are logs around this.  I believe in this 
> case, firmware
> didn't actually bubble up a crash notification/interrupt, but probably 
> the driver detected timeout
> and faked a crash.
>
> Feb 26 11:09:35 ct523c-de7c kernel: workqueue: blk_mq_requeue_work 
> hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> Feb 26 11:09:36 ct523c-de7c kernel: workqueue: gc_worker 
> [nf_conntrack] hogged CPU for >10000us 515 times, consider switching 
> to WQ_UNBOUND
> Feb 26 11:09:39 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Error 
> sending SYSTEM_STATISTICS_CMD: time out after 2000ms.
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Current CMD 
> queue read_ptr 92 write_ptr 93
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start IWL 
> Error Log Dump:
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Transport 
> status: 0x0000004A, valid: 6
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Loaded 
> firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000084 | 
> NMI_INTERRUPT_UNKNOWN
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | 
> trm_hw_status0
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> trm_hw_status1
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002C438C | 
> branchlink2
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C04 | 
> interruptlink1
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C04 | 
> interruptlink2
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C3C | 
> data1
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01000000 | 
> data2
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> data3
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xD040FE38 | 
> beacon time
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x3B6411CD | 
> tsf low
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000026B | 
> tsf hi
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> time gp1
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0616DB18 | 
> time gp2
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000001 | 
> uCode revision type
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000065 | 
> uCode version major
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x6EF20B19 | 
> uCode version minor
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000472 | 
> hw version
> Feb 26 11:09:40 ct523c-de7c kernel: ------------[ cut here ]------------
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi: NAPI MSIX poll[0] invoked 
> after FW error
> Feb 26 11:09:40 ct523c-de7c kernel: WARNING: CPU: 3 PID: 36 at 
> drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058 
> iwl_pcie_napi_poll_msix+0x29e/0x310 [iwlwifi]
> Feb 26 11:09:40 ct523c-de7c kernel: Modules linked in: vrf 
> nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 
> nf_defrag_ipv4 8021q garp mrp stp llc macvlan pktgen rfcomm rpcrdma 
> rdma_cm iw_cm ib_cm ib_core qrtr bnep intel_rapl_msr iTCO_wdt 
> intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp 
> intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common 
> snd_hda_codec_intelhdmi snd_hda_codec_hdmi intel_tcc_cooling 
> x86_pkg_temp_thermal snd_hda_codec_alc662 snd_hda_codec_realtek_lib 
> intel_powerclamp intel_wmi_thunderbolt snd_hda_codec_generic 
> snd_hda_intel snd_intel_dspcfg snd_hda_codec mac80211 snd_hda_core 
> snd_hwdep snd_seq btusb btbcm snd_seq_device btmtk btrtl btintel 
> snd_pcm iwlwifi bluetooth snd_timer cfg80211 i2c_i801 snd i2c_smbus 
> soundcore i2c_mux mei_pxp mei_hdcp intel_pch_thermal intel_pmc_core 
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry 
> intel_vsec acpi_pad bfq nfsd sch_fq_codel auth_rpcgss nfs_acl lockd 
> grace nfs_localio fuse sunrpc raid1 dm_raid raid456 async_raid6_recov 
> async_memcpy async_pq
> Feb 26 11:09:40 ct523c-de7c kernel:  async_xor xor async_tx raid6_pq 
> i915 drm_buddy intel_gtt drm_client_lib drm_display_helper 
> drm_kms_helper cec rc_core ttm agpgart ixgbe mdio igb libie_fwlog 
> i2c_algo_bit dca drm hwmon mei_wdt i2c_core intel_oc_wdt video wmi 
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath [last unloaded: 
> nfnetlink]
> Feb 26 11:09:40 ct523c-de7c kernel: CPU: 3 UID: 0 PID: 36 Comm: 
> ksoftirqd/3 Kdump: loaded Not tainted 6.18.9+ #18 PREEMPT(full)
> Feb 26 11:09:40 ct523c-de7c kernel: Hardware name: Default string 
> Default string/SKYBAY, BIOS 5.12 02/21/2023
> Feb 26 11:09:40 ct523c-de7c kernel: RIP: 
> 0010:iwl_pcie_napi_poll_msix+0x29e/0x310 [iwlwifi]
> Feb 26 11:09:40 ct523c-de7c kernel: Code: 00 00 fc ff df 48 89 fa 48 
> c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03 7e 74 8b b3 48 ff ff ff 48 c7 
> c7 a0 d2 19 a2 e8 62 00 0f df <0f> 0b eb 96 4c 89 e7 e8 d6 92 9f df e9 
> 0b fe ff ff e8 cc 92 9f df
> Feb 26 11:09:40 ct523c-de7c kernel: RSP: 0018:ffff888120fe7b70 EFLAGS: 
> 00010286
> Feb 26 11:09:40 ct523c-de7c kernel: RAX: 0000000000000000 RBX: 
> ffff888182e100b8 RCX: 0000000000000001
> Feb 26 11:09:40 ct523c-de7c kernel: RDX: 0000000000000027 RSI: 
> 0000000000000004 RDI: ffff88841dba4e48
> Feb 26 11:09:40 ct523c-de7c kernel: RBP: ffff888132504028 R08: 
> 0000000000000001 R09: ffffed1083b749c9
> Feb 26 11:09:40 ct523c-de7c kernel: R10: ffff88841dba4e4b R11: 
> 0000000000072ee8 R12: ffff888132504090
> Feb 26 11:09:40 ct523c-de7c kernel: R13: ffff888132504d90 R14: 
> 0000000000000040 R15: ffff888134b480b8
> Feb 26 11:09:40 ct523c-de7c kernel: FS:  0000000000000000(0000) 
> GS:ffff8884974c7000(0000) knlGS:0000000000000000
> Feb 26 11:09:40 ct523c-de7c kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> Feb 26 11:09:40 ct523c-de7c kernel: CR2: 00007fd5beb80028 CR3: 
> 000000013e2d4001 CR4: 00000000003706f0
> Feb 26 11:09:40 ct523c-de7c kernel: Call Trace:
> Feb 26 11:09:40 ct523c-de7c kernel:  <TASK>
> Feb 26 11:09:40 ct523c-de7c kernel: __napi_poll.constprop.0+0xa0/0x580
> Feb 26 11:09:40 ct523c-de7c kernel:  net_rx_action+0x84d/0xe40
> Feb 26 11:09:40 ct523c-de7c kernel:  ? 
> __napi_poll.constprop.0+0x580/0x580
> Feb 26 11:09:40 ct523c-de7c kernel:  ? do_raw_spin_lock+0x12c/0x270
> Feb 26 11:09:40 ct523c-de7c kernel:  ? run_timer_softirq+0xf2/0x1b0
> Feb 26 11:09:40 ct523c-de7c kernel:  ? lock_release+0xce/0x290
> Feb 26 11:09:40 ct523c-de7c kernel:  ? 
> trace_irq_enable.constprop.0+0xbe/0x100
> Feb 26 11:09:40 ct523c-de7c kernel:  handle_softirqs+0x1c6/0x810
> Feb 26 11:09:40 ct523c-de7c kernel:  run_ksoftirqd+0x2d/0x50
> Feb 26 11:09:40 ct523c-de7c kernel:  smpboot_thread_fn+0x338/0x8c0
> Feb 26 11:09:40 ct523c-de7c kernel:  ? sort_range+0x20/0x20
> Feb 26 11:09:40 ct523c-de7c kernel:  kthread+0x3b7/0x770
> Feb 26 11:09:40 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
> Feb 26 11:09:40 ct523c-de7c kernel:  ? ret_from_fork+0x17/0x3a0
> Feb 26 11:09:40 ct523c-de7c kernel:  ? lock_release+0xce/0x290
> Feb 26 11:09:40 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
> Feb 26 11:09:40 ct523c-de7c kernel:  ret_from_fork+0x28b/0x3a0
> Feb 26 11:09:40 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
> Feb 26 11:09:40 ct523c-de7c kernel:  ret_from_fork_asm+0x11/0x20
> Feb 26 11:09:40 ct523c-de7c kernel:  </TASK>
> Feb 26 11:09:40 ct523c-de7c kernel: irq event stamp: 36429934
> Feb 26 11:09:40 ct523c-de7c kernel: hardirqs last  enabled at 
> (36429940): [<ffffffff816116ee>] __up_console_sem+0x5e/0x70
> Feb 26 11:09:40 ct523c-de7c kernel: hardirqs last disabled at 
> (36429945): [<ffffffff816116d3>] __up_console_sem+0x43/0x70
> Feb 26 11:09:40 ct523c-de7c kernel: softirqs last  enabled at 
> (36428910): [<ffffffff81471d3d>] run_ksoftirqd+0x2d/0x50
> Feb 26 11:09:40 ct523c-de7c kernel: softirqs last disabled at 
> (36428915): [<ffffffff81471d3d>] run_ksoftirqd+0x2d/0x50
> Feb 26 11:09:40 ct523c-de7c kernel: ---[ end trace 0000000000000000 ]---
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C80002 | 
> board version
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x036D001C | 
> hcmd
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xF6F38000 | 
> isr0
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01400000 | 
> isr1
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x48F00002 | 
> isr2
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C00008 | 
> isr3
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x18200000 | 
> isr4
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x036D001C | 
> last cmd Id
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C3C | 
> wait_event
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x10000010 | 
> l2p_control
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> l2p_duration
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> l2p_mhvalid
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> l2p_addr_match
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000009 | 
> lmpm_pmg_sel
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> timestamp
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009018 | 
> flow_handler
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start IWL 
> Error Log Dump:
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Transport 
> status: 0x0000004A, valid: 6
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Loaded 
> firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
> Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000084 | 
> NMI_INTERRUPT_UNKNOWN
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | 
> trm_hw_status0
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> trm_hw_status1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002C438C | 
> branchlink2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002B8AD0 | 
> interruptlink1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002B8AD0 | 
> interruptlink2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002A5822 | 
> data1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01000000 | 
> data2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> data3
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xD040FE37 | 
> beacon time
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x3B6411CE | 
> tsf low
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000026B | 
> tsf hi
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> time gp1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0616DB19 | 
> time gp2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000001 | 
> uCode revision type
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000065 | 
> uCode version major
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x6EF20B19 | 
> uCode version minor
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000472 | 
> hw version
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C80002 | 
> board version
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x804AFC12 | 
> hcmd
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00020000 | 
> isr0
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> isr1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x48F00002 | 
> isr2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C0001C | 
> isr3
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> isr4
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> last cmd Id
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002A5822 | 
> wait_event
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x10000010 | 
> l2p_control
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> l2p_duration
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> l2p_mhvalid
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> l2p_addr_match
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000028 | 
> lmpm_pmg_sel
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> timestamp
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009018 | 
> flow_handler
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start IWL 
> Error Log Dump:
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Transport 
> status: 0x0000004A, valid: 7
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000066 | 
> NMI_INTERRUPT_HOST
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> umac branchlink1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xC00808AA | 
> umac branchlink2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x80287BFE | 
> umac interruptlink1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0102163E | 
> umac interruptlink2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01000000 | 
> umac data1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0102163E | 
> umac data2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> umac data3
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000065 | 
> umac major
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x6EF20B19 | 
> umac minor
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0616DB0F | 
> frame pointer
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xD00D6258 | 
> stack pointer
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x005C020F | 
> last host cmd
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000400 | 
> isr status reg
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM1 status:
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | 
> error ID
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001D2E | 
> tcm branchlink2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | 
> tcm interruptlink1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | 
> tcm interruptlink2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x40000000 | 
> tcm data1
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> tcm data2
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> tcm data3
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001DAC | 
> tcm log PC
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | 
> tcm frame pointer
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | 
> tcm stack pointer
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm msg ID
> Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x4000001F | 
> tcm ISR status
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | 
> tcm HW status[0]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm HW status[1]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm HW status[2]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x40008300 | 
> tcm HW status[3]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm HW status[4]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm SW status[0]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM1 status:
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | 
> error ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E2E | 
> rcm branchlink2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | 
> rcm interruptlink1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | 
> rcm interruptlink2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000000 | 
> rcm data1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> rcm data2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> rcm data3
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E98 | 
> rcm log PC
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | 
> rcm frame pointer
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | 
> rcm stack pointer
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> rcm msg ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x2006F000 | 
> rcm ISR status
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00020400 | 
> frame HW status
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> LMAC-to-RCM request mbox
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> RCM-to-LMAC request mbox
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> MAC header control
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> MAC header addr1 low
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x003C0000 | 
> MAC header info
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> MAC header error
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM2 status:
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | 
> error ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001D2E | 
> tcm branchlink2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | 
> tcm interruptlink1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | 
> tcm interruptlink2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x40000000 | 
> tcm data1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> tcm data2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> tcm data3
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001DAC | 
> tcm log PC
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | 
> tcm frame pointer
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | 
> tcm stack pointer
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm msg ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x60000000 | 
> tcm ISR status
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | 
> tcm HW status[0]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm HW status[1]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm HW status[2]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00008000 | 
> tcm HW status[3]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm HW status[4]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> tcm SW status[0]
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM2 status:
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | 
> error ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E2E | 
> rcm branchlink2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | 
> rcm interruptlink1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | 
> rcm interruptlink2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000000 | 
> rcm data1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> rcm data2
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | 
> rcm data3
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E98 | 
> rcm log PC
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | 
> rcm frame pointer
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | 
> rcm stack pointer
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> rcm msg ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000000 | 
> rcm ISR status
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00020400 | 
> frame HW status
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> LMAC-to-RCM request mbox
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> RCM-to-LMAC request mbox
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> MAC header control
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> MAC header addr1 low
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x003C0000 | 
> MAC header info
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> MAC header error
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: IML/ROM dump:
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000B03 | 
> IML/ROM error/state
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000EEE3 | 
> IML/ROM data1
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000080 | 
> IML/ROM WFPM_AUTH_KEY_0
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Fseq Registers:
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x60000000 | 
> FSEQ_ERROR_CODE
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x80B10006 | 
> FSEQ_TOP_INIT_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00570000 | 
> FSEQ_CNVIO_INIT_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000AA14 | 
> FSEQ_OTP_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000000F | 
> FSEQ_TOP_CONTENT_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x4552414E | 
> FSEQ_ALIVE_TOKEN
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | 
> FSEQ_CNVI_ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | 
> FSEQ_CNVR_ID
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | 
> CNVI_AUX_MISC_CHIP
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | 
> CNVR_AUX_MISC_CHIP
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x8F0F1BEF | 
> CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | 
> CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00570000 | 
> FSEQ_PREV_CNVIO_INIT_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00B10006 | 
> FSEQ_WIFI_FSEQ_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00B10005 | 
> FSEQ_BT_FSEQ_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000000DC | 
> FSEQ_CLASS_TP_VERSION
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: UMAC CURRENT 
> PC: 0x8028b720
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: LMAC1 
> CURRENT PC: 0xd0
> Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: LMAC2 
> CURRENT PC: 0xd0
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: UMAC CURRENT 
> PC 1: 0x8028b722
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM1 CURRENT 
> PC: 0xd0
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM1 CURRENT 
> PC: 0xd0
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM2 CURRENT 
> PC: 0xd0
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Function 
> Scratch status:
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01010100 | 
> Func Scratch
> Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: WRT: 
> Collecting data: ini trigger 4 fired (delay=0ms).
>
>
> Thanks,
> Ben
>
>>
>> The race window opens when the MSIX IRQ handler schedules NAPI (lines
>> 2319-2321 in rx.c) before processing the error bit (lines 2382-2396),
>> or when NAPI is already running on another CPU from a previous interrupt
>> when STATUS_FW_ERROR gets set on the current CPU.
>>
>> Add STATUS_FW_ERROR checks to both NAPI poll functions to prevent
>> processing stale RX data after firmware error, and add early-return
>> guards in the TX response and compressed BA notification handlers as
>> defense-in-depth. Each check uses WARN_ONCE to log if the race is
>> actually hit, which aids diagnosis of the hard-to-reproduce skb
>> use-after-free reported on Intel BE200.
>>
>> Note that _iwl_trans_pcie_gen2_stop_device() already calls
>> iwl_pcie_rx_napi_sync() to quiesce NAPI during device teardown, but that
>> runs much later in the restart sequence. These checks close the window
>> between error detection and device stop.
>>
>> Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Cole Leavitt <cole@unwrap.rs>
>> ---
>> Changes since v1:
>>    - Added Fixes: tag and Cc: stable@vger.kernel.org
>>
>> Tested on Intel BE200 (FW 101.6e695a70.0) by forcing NMI via debugfs.
>> The WARN_ONCE fires reliably:
>>
>>    iwlwifi: NAPI MSIX poll[0] invoked after FW error
>>    WARNING: drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058
>>             at iwl_pcie_napi_poll_msix+0xff/0x130 [iwlwifi], CPU#22
>>
>> Confirming NAPI poll is invoked after STATUS_FW_ERROR is set. Without
>> this patch, that poll processes stale RX ring data from dead firmware.
>>
>>   drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 19 ++++++++++++++++++
>>   .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 20 +++++++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c 
>> b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
>> index 3b4b575aadaa..3e99f3ded9bc 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
>> @@ -1071,6 +1071,18 @@ void iwl_mld_handle_tx_resp_notif(struct 
>> iwl_mld *mld,
>>       bool mgmt = false;
>>       bool tx_failure = (status & TX_STATUS_MSK) != TX_STATUS_SUCCESS;
>>   +    /* Firmware is dead — the TX response may contain corrupt SSN 
>> values
>> +     * from a dying firmware DMA. Processing it could cause
>> +     * iwl_trans_reclaim() to free the wrong TX queue entries, 
>> leading to
>> +     * skb use-after-free or double-free.
>> +     */
>> +    if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
>> +        WARN_ONCE(1,
>> +              "iwlwifi: TX resp notif (sta=%d txq=%d) after FW 
>> error\n",
>> +              sta_id, txq_id);
>> +        return;
>> +    }
>> +
>>       if (IWL_FW_CHECK(mld, tx_resp->frame_count != 1,
>>                "Invalid tx_resp notif frame_count (%d)\n",
>>                tx_resp->frame_count))
>> @@ -1349,6 +1361,13 @@ void iwl_mld_handle_compressed_ba_notif(struct 
>> iwl_mld *mld,
>>       u8 sta_id = ba_res->sta_id;
>>       struct ieee80211_link_sta *link_sta;
>>   +    if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
>> +        WARN_ONCE(1,
>> +              "iwlwifi: BA notif (sta=%d) after FW error\n",
>> +              sta_id);
>> +        return;
>> +    }
>> +
>>       if (!tfd_cnt)
>>           return;
>>   diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c 
>> b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
>> index 619a9505e6d9..ba18d35fa55d 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
>> @@ -1015,6 +1015,18 @@ static int iwl_pcie_napi_poll(struct 
>> napi_struct *napi, int budget)
>>       trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
>>       trans = trans_pcie->trans;
>>   +    /* Stop processing RX if firmware has crashed. Stale 
>> notifications
>> +     * from dying firmware (e.g. TX completions with corrupt SSN 
>> values)
>> +     * can cause use-after-free in reclaim paths.
>> +     */
>> +    if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
>> +        WARN_ONCE(1,
>> +              "iwlwifi: NAPI poll[%d] invoked after FW error\n",
>> +              rxq->id);
>> +        napi_complete_done(napi, 0);
>> +        return 0;
>> +    }
>> +
>>       ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
>>         IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
>> @@ -1042,6 +1054,14 @@ static int iwl_pcie_napi_poll_msix(struct 
>> napi_struct *napi, int budget)
>>       trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
>>       trans = trans_pcie->trans;
>>   +    if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
>> +        WARN_ONCE(1,
>> +              "iwlwifi: NAPI MSIX poll[%d] invoked after FW error\n",
>> +              rxq->id);
>> +        napi_complete_done(napi, 0);
>> +        return 0;
>> +    }
>> +
>>       ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
>>       IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n", rxq->id, ret,
>>                 budget);
>
-- 
Email Signature
Cole Leavitt 	
Cole Leavitt
Principal Security Engineer
+1 (520) 870-0922 <tel:+15208700922>
4050 E COTTON CENTER BLVD STE 40
PHOENIX AZ 85040-8863
fiwealth.com <https://fiwealth.com>

Foundations Investment Advisors

Please consider the environment before printing this email.

*IMPORTANT NOTICE*
Foundations Investment Advisors, LLC is registered with the U.S. 
Securities and Exchange Commission as an investment adviser pursuant to 
the Investment Advisers Act of 1940, 15 U.S.C. § 80b. Registration does 
not imply a certain level of skill or training. See Form ADV Part 2A, 
Item 1.C at adviserinfo.sec.gov <https://adviserinfo.sec.gov>.

This email may contain confidential or privileged information protected 
under Fed. R. Evid. 502. It is intended solely for the named addressee. 
If received in error, notify the sender immediately and delete all 
copies. Unauthorized review, copying, or distribution is prohibited.

--------------k70yhXO3NPSb4Ql6IY5gnrkw
Content-Type: multipart/related;
 boundary="------------KYwIzx9ERBRj5FSG9tQoGFZX"

--------------KYwIzx9ERBRj5FSG9tQoGFZX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Ben,<br>
      <br>
      Thanks for the confirmation and the detailed logs. The Feb 26
      trace is<br>
      exactly the scenario we designed the check for --
      SYSTEM_STATISTICS_CMD<br>
      times out, driver forces NMI, and ksoftirqd/3 hits our WARN in<br>
      iwl_pcie_napi_poll_msix while the error dump is still printing.
      Good to<br>
      see it catching the race in production.<br>
      <br>
      I owe you a correction on the TSO patch (2/3). You were right that
      my<br>
      commit message overclaimed causation between the 32k segment
      explosion<br>
      and the TCP UAF. I've been digging deeper into your Feb 16 crash
      trace<br>
      and here's what I've found I think:<br>
      <br>
      The refcount underflow in tcp_shifted_skb is NOT a use-after-free.<br>
      I looked at your free_status debugging (commit 3b5f7046f in your
      tree)<br>
      and the fact that none of your checks fire means the skb is still<br>
      validly allocated when the underflow happens. The refcount that<br>
      underflows is sk-&gt;sk_wmem_alloc (the socket's write memory
      accounting),<br>
      not skb-&gt;users or dataref.<br>
      <br>
      The crash path is:<br>
        tcp_shifted_skb -&gt; tcp_rtx_queue_unlink_and_free -&gt;
      tcp_wmem_free_skb<br>
        -&gt; __kfree_skb -&gt; skb_release_head_state -&gt; sock_wfree<br>
        -&gt; __refcount_sub_and_test(len, &amp;sk-&gt;sk_wmem_alloc)
      -&gt; UNDERFLOW<br>
      <br>
      Something is subtracting more from sk_wmem_alloc than was added. I<br>
      traced every charge/drain path:<br>
      <br>
        Charges: skb_set_owner_w() at creation, tcp_transmit_skb:1601 at
      clone<br>
        Drains:  sock_wfree() or tcp_wfree() at destructor time<br>
      <br>
      I also verified:<br>
        - TCP clones before sending (tcp_output.c:1539), so the TSO<br>
          segmentation operates on the clone, not the retransmit
      original<br>
        - skb_clone sets destructor=NULL (skbuff.c:1625),
      tcp_transmit_skb<br>
          re-sets it with a fresh refcount_add -- balanced per-skb<br>
        - pskb_expand_head in mac80211 (tx.c:2016) does NOT modify
      truesize<br>
          on TCP-owned skbs because of the guard at skbuff.c:2367<br>
        - skb_shift truesize changes during SACK coalescing are<br>
          self-balancing across the source/target pair<br>
      <br>
      I've exhausted what I can find from code analysis alone. The
      accounting<br>
      mismatch is real but I can't identify the exact path without
      tracing<br>
      on the hardware.<br>
      <br>
      I wrote a small debug patch that adds trace_printk at every<br>
      sk_wmem_alloc modification point:<br>
      <br>
        - skb_set_owner_w(): charge at creation<br>
        - tcp_transmit_skb(): charge at clone<br>
        - sock_wfree(): drain (generic)<br>
        - tcp_wfree(): drain (TCP fast path)<br>
        - skb_shift(): truesize change during SACK coalescing<br>
      <br>
      Could you apply the attached patch, reproduce against the problem
      AP,<br>
      and send me the ftrace output? The skb pointer in each trace line
      lets<br>
      us correlate exactly which charge/drain pair is imbalanced.<br>
      <br>
        echo 1 &gt; /sys/kernel/debug/tracing/tracing_on<br>
        # reproduce<br>
        cat /sys/kernel/debug/tracing/trace &gt; /tmp/wmem_trace.txt<br>
      <br>
      The trace will be noisy (every TCP packet), so grep for the socket<br>
      address from your crash (R12=ffff88820165f200 in your Feb 16 dump)
      to<br>
      filter to the relevant connection.<br>
      <br>
      Separately, the TSO sentinel fix and the NAPI race fix are still
      correct<br>
      regardless of the TCP accounting issue. The sentinel value 1
      producing<br>
      num_subframes=0 is a real bug -- I verified that only 7 code paths
      in<br>
      the entire kernel write max_tid_amsdu_len, and through legitimate
      MLD<br>
      code the only value that produces zero is the sentinel 1 from the
      TLC<br>
      notification. The WARN_ON_ONCE(!num_subframes) guard in the v2
      patch<br>
      catches any corruption-induced zeros from unknown paths.<br>
      <br>
      On your remaining 32k GSO spins after applying the sentinel fix:
      since<br>
      legitimate code can only produce values 0 (caught by existing
      check) or<br>
      1 (caught by our new check) or &gt;= 2000 (safe), values 2-1533
      that would<br>
      also produce num_subframes=0 can only come from memory corruption.
      Does<br>
      the WARN_ON_ONCE fire? If so, what max_tid_amsdu_len value does
      the<br>
      pr_warn_once in your tree (commit 9dd9677f5) print?<br>
      <br>
      Cole<br>
      <br>
    </p>
    <div class="moz-cite-prefix">On 26/02/2026 12.37, Ben Greear wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:e6d6d4ad-475a-7bad-0dc9-6a920ed7f8ed@candelatech.com">On
      2/14/26 10:43, Cole Leavitt wrote:
      <br>
      <blockquote type="cite">After a firmware error is detected and
        STATUS_FW_ERROR is set, NAPI can
        <br>
        still be actively polling or get scheduled from a prior
        interrupt. The
        <br>
        NAPI poll functions (both legacy and MSIX variants) have no
        check for
        <br>
        STATUS_FW_ERROR and will continue processing stale RX ring
        entries from
        <br>
        dying firmware. This can dispatch TX completion notifications
        containing
        <br>
        corrupt SSN values to iwl_mld_handle_tx_resp_notif(), which
        passes them
        <br>
        to iwl_trans_reclaim(). If the corrupt SSN causes reclaim to
        walk TX
        <br>
        queue entries that were already freed by a prior correct
        reclaim, the
        <br>
        result is an skb use-after-free or double-free.
        <br>
      </blockquote>
      <br>
      Hello Cole,
      <br>
      <br>
      We've been testing with this patch, and today managed to see its
      logic trigger.
      <br>
      The system had a cascade of other errors leading to use-after-free
      that does
      <br>
      not appear to be related to the skb use-after free, but I can at
      least confirm your
      <br>
      patch can be triggered.  Here are logs around this.  I believe in
      this case, firmware
      <br>
      didn't actually bubble up a crash notification/interrupt, but
      probably the driver detected timeout
      <br>
      and faked a crash.
      <br>
      <br>
      Feb 26 11:09:35 ct523c-de7c kernel: workqueue: blk_mq_requeue_work
      hogged CPU for &gt;10000us 4 times, consider switching to
      WQ_UNBOUND
      <br>
      Feb 26 11:09:36 ct523c-de7c kernel: workqueue: gc_worker
      [nf_conntrack] hogged CPU for &gt;10000us 515 times, consider
      switching to WQ_UNBOUND
      <br>
      Feb 26 11:09:39 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Error
      sending SYSTEM_STATISTICS_CMD: time out after 2000ms.
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Current
      CMD queue read_ptr 92 write_ptr 93
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start
      IWL Error Log Dump:
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      Transport status: 0x0000004A, valid: 6
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Loaded
      firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000084 | NMI_INTERRUPT_UNKNOWN
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000002F0 | trm_hw_status0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | trm_hw_status1
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x002C438C | branchlink2
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00009C04 | interruptlink1
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00009C04 | interruptlink2
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00009C3C | data1
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x01000000 | data2
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | data3
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xD040FE38 | beacon time
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x3B6411CD | tsf low
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000026B | tsf hi
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | time gp1
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0616DB18 | time gp2
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000001 | uCode revision type
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000065 | uCode version major
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x6EF20B19 | uCode version minor
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000472 | hw version
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: ------------[ cut here
      ]------------
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi: NAPI MSIX poll[0]
      invoked after FW error
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: WARNING: CPU: 3 PID: 36 at
      drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058
      iwl_pcie_napi_poll_msix+0x29e/0x310 [iwlwifi]
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: Modules linked in: vrf
      nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6
      nf_defrag_ipv4 8021q garp mrp stp llc macvlan pktgen rfcomm
      rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep intel_rapl_msr
      iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp
      intel_rapl_common intel_uncore_frequency
      intel_uncore_frequency_common snd_hda_codec_intelhdmi
      snd_hda_codec_hdmi intel_tcc_cooling x86_pkg_temp_thermal
      snd_hda_codec_alc662 snd_hda_codec_realtek_lib intel_powerclamp
      intel_wmi_thunderbolt snd_hda_codec_generic snd_hda_intel
      snd_intel_dspcfg snd_hda_codec mac80211 snd_hda_core snd_hwdep
      snd_seq btusb btbcm snd_seq_device btmtk btrtl btintel snd_pcm
      iwlwifi bluetooth snd_timer cfg80211 i2c_i801 snd i2c_smbus
      soundcore i2c_mux mei_pxp mei_hdcp intel_pch_thermal
      intel_pmc_core pmt_telemetry pmt_discovery pmt_class
      intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq nfsd
      sch_fq_codel auth_rpcgss nfs_acl lockd grace nfs_localio fuse
      sunrpc raid1 dm_raid raid456 async_raid6_recov async_memcpy
      async_pq
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  async_xor xor async_tx
      raid6_pq i915 drm_buddy intel_gtt drm_client_lib
      drm_display_helper drm_kms_helper cec rc_core ttm agpgart ixgbe
      mdio igb libie_fwlog i2c_algo_bit dca drm hwmon mei_wdt i2c_core
      intel_oc_wdt video wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua
      dm_multipath [last unloaded: nfnetlink]
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: CPU: 3 UID: 0 PID: 36 Comm:
      ksoftirqd/3 Kdump: loaded Not tainted 6.18.9+ #18 PREEMPT(full)
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: Hardware name: Default string
      Default string/SKYBAY, BIOS 5.12 02/21/2023
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: RIP:
      0010:iwl_pcie_napi_poll_msix+0x29e/0x310 [iwlwifi]
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: Code: 00 00 fc ff df 48 89 fa
      48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03 7e 74 8b b3 48 ff ff ff
      48 c7 c7 a0 d2 19 a2 e8 62 00 0f df &lt;0f&gt; 0b eb 96 4c 89 e7
      e8 d6 92 9f df e9 0b fe ff ff e8 cc 92 9f df
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: RSP: 0018:ffff888120fe7b70
      EFLAGS: 00010286
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: RAX: 0000000000000000 RBX:
      ffff888182e100b8 RCX: 0000000000000001
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: RDX: 0000000000000027 RSI:
      0000000000000004 RDI: ffff88841dba4e48
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: RBP: ffff888132504028 R08:
      0000000000000001 R09: ffffed1083b749c9
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: R10: ffff88841dba4e4b R11:
      0000000000072ee8 R12: ffff888132504090
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: R13: ffff888132504d90 R14:
      0000000000000040 R15: ffff888134b480b8
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: FS:  0000000000000000(0000)
      GS:ffff8884974c7000(0000) knlGS:0000000000000000
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: CS:  0010 DS: 0000 ES: 0000
      CR0: 0000000080050033
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: CR2: 00007fd5beb80028 CR3:
      000000013e2d4001 CR4: 00000000003706f0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: Call Trace:
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  &lt;TASK&gt;
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: 
      __napi_poll.constprop.0+0xa0/0x580
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  net_rx_action+0x84d/0xe40
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      __napi_poll.constprop.0+0x580/0x580
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      do_raw_spin_lock+0x12c/0x270
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      run_timer_softirq+0xf2/0x1b0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ? lock_release+0xce/0x290
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      trace_irq_enable.constprop.0+0xbe/0x100
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  handle_softirqs+0x1c6/0x810
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  run_ksoftirqd+0x2d/0x50
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  smpboot_thread_fn+0x338/0x8c0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ? sort_range+0x20/0x20
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  kthread+0x3b7/0x770
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      kthread_is_per_cpu+0xb0/0xb0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ? ret_from_fork+0x17/0x3a0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ? lock_release+0xce/0x290
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      kthread_is_per_cpu+0xb0/0xb0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ret_from_fork+0x28b/0x3a0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ?
      kthread_is_per_cpu+0xb0/0xb0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  ret_from_fork_asm+0x11/0x20
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel:  &lt;/TASK&gt;
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: irq event stamp: 36429934
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: hardirqs last  enabled at
      (36429940): [&lt;ffffffff816116ee&gt;] __up_console_sem+0x5e/0x70
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: hardirqs last disabled at
      (36429945): [&lt;ffffffff816116d3&gt;] __up_console_sem+0x43/0x70
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: softirqs last  enabled at
      (36428910): [&lt;ffffffff81471d3d&gt;] run_ksoftirqd+0x2d/0x50
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: softirqs last disabled at
      (36428915): [&lt;ffffffff81471d3d&gt;] run_ksoftirqd+0x2d/0x50
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: ---[ end trace
      0000000000000000 ]---
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00C80002 | board version
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x036D001C | hcmd
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xF6F38000 | isr0
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x01400000 | isr1
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x48F00002 | isr2
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00C00008 | isr3
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x18200000 | isr4
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x036D001C | last cmd Id
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00009C3C | wait_event
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x10000010 | l2p_control
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | l2p_duration
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | l2p_mhvalid
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | l2p_addr_match
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000009 | lmpm_pmg_sel
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | timestamp
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00009018 | flow_handler
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start
      IWL Error Log Dump:
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      Transport status: 0x0000004A, valid: 6
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Loaded
      firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
      <br>
      Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000084 | NMI_INTERRUPT_UNKNOWN
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000002F0 | trm_hw_status0
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | trm_hw_status1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x002C438C | branchlink2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x002B8AD0 | interruptlink1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x002B8AD0 | interruptlink2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x002A5822 | data1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x01000000 | data2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | data3
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xD040FE37 | beacon time
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x3B6411CE | tsf low
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000026B | tsf hi
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | time gp1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0616DB19 | time gp2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000001 | uCode revision type
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000065 | uCode version major
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x6EF20B19 | uCode version minor
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000472 | hw version
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00C80002 | board version
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x804AFC12 | hcmd
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00020000 | isr0
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | isr1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x48F00002 | isr2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00C0001C | isr3
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | isr4
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | last cmd Id
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x002A5822 | wait_event
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x10000010 | l2p_control
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | l2p_duration
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | l2p_mhvalid
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | l2p_addr_match
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000028 | lmpm_pmg_sel
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | timestamp
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00009018 | flow_handler
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start
      IWL Error Log Dump:
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      Transport status: 0x0000004A, valid: 7
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x20000066 | NMI_INTERRUPT_HOST
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | umac branchlink1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xC00808AA | umac branchlink2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x80287BFE | umac interruptlink1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0102163E | umac interruptlink2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x01000000 | umac data1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0102163E | umac data2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | umac data3
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000065 | umac major
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x6EF20B19 | umac minor
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0616DB0F | frame pointer
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xD00D6258 | stack pointer
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x005C020F | last host cmd
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000400 | isr status reg
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM1
      status:
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000070 | error ID
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001D2E | tcm branchlink2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000211C | tcm interruptlink1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000211C | tcm interruptlink2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x40000000 | tcm data1
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | tcm data2
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | tcm data3
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001DAC | tcm log PC
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803FF0 | tcm frame pointer
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803F5C | tcm stack pointer
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm msg ID
      <br>
      Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x4000001F | tcm ISR status
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000002F0 | tcm HW status[0]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm HW status[1]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm HW status[2]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x40008300 | tcm HW status[3]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm HW status[4]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm SW status[0]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM1
      status:
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000070 | error ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001E2E | rcm branchlink2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000027A0 | rcm interruptlink1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000027A0 | rcm interruptlink2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x20000000 | rcm data1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | rcm data2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | rcm data3
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001E98 | rcm log PC
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803FF0 | rcm frame pointer
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803F5C | rcm stack pointer
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | rcm msg ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x2006F000 | rcm ISR status
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00020400 | frame HW status
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | LMAC-to-RCM request mbox
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | RCM-to-LMAC request mbox
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | MAC header control
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | MAC header addr1 low
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x003C0000 | MAC header info
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | MAC header error
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM2
      status:
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000070 | error ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001D2E | tcm branchlink2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000211C | tcm interruptlink1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000211C | tcm interruptlink2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x40000000 | tcm data1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | tcm data2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | tcm data3
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001DAC | tcm log PC
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803FF0 | tcm frame pointer
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803F5C | tcm stack pointer
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm msg ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x60000000 | tcm ISR status
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000002F0 | tcm HW status[0]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm HW status[1]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm HW status[2]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00008000 | tcm HW status[3]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm HW status[4]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | tcm SW status[0]
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM2
      status:
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000070 | error ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001E2E | rcm branchlink2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000027A0 | rcm interruptlink1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000027A0 | rcm interruptlink2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x20000000 | rcm data1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | rcm data2
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0xDEADBEEF | rcm data3
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00001E98 | rcm log PC
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803FF0 | rcm frame pointer
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00803F5C | rcm stack pointer
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | rcm msg ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x20000000 | rcm ISR status
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00020400 | frame HW status
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | LMAC-to-RCM request mbox
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | RCM-to-LMAC request mbox
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | MAC header control
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | MAC header addr1 low
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x003C0000 | MAC header info
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | MAC header error
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: IML/ROM
      dump:
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000B03 | IML/ROM error/state
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000EEE3 | IML/ROM data1
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000080 | IML/ROM WFPM_AUTH_KEY_0
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Fseq
      Registers:
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x60000000 | FSEQ_ERROR_CODE
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x80B10006 | FSEQ_TOP_INIT_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00570000 | FSEQ_CNVIO_INIT_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000AA14 | FSEQ_OTP_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x0000000F | FSEQ_TOP_CONTENT_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x4552414E | FSEQ_ALIVE_TOKEN
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x02001910 | FSEQ_CNVI_ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x02001910 | FSEQ_CNVR_ID
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x02001910 | CNVI_AUX_MISC_CHIP
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x02001910 | CNVR_AUX_MISC_CHIP
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x8F0F1BEF | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x00B10005 | FSEQ_BT_FSEQ_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x000000DC | FSEQ_CLASS_TP_VERSION
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: UMAC
      CURRENT PC: 0x8028b720
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: LMAC1
      CURRENT PC: 0xd0
      <br>
      Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: LMAC2
      CURRENT PC: 0xd0
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: UMAC
      CURRENT PC 1: 0x8028b722
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM1
      CURRENT PC: 0xd0
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM1
      CURRENT PC: 0xd0
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM2
      CURRENT PC: 0xd0
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Function
      Scratch status:
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0:
      0x01010100 | Func Scratch
      <br>
      Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: WRT:
      Collecting data: ini trigger 4 fired (delay=0ms).
      <br>
      <br>
      <br>
      Thanks,
      <br>
      Ben
      <br>
      <br>
      <blockquote type="cite">
        <br>
        The race window opens when the MSIX IRQ handler schedules NAPI
        (lines
        <br>
        2319-2321 in rx.c) before processing the error bit (lines
        2382-2396),
        <br>
        or when NAPI is already running on another CPU from a previous
        interrupt
        <br>
        when STATUS_FW_ERROR gets set on the current CPU.
        <br>
        <br>
        Add STATUS_FW_ERROR checks to both NAPI poll functions to
        prevent
        <br>
        processing stale RX data after firmware error, and add
        early-return
        <br>
        guards in the TX response and compressed BA notification
        handlers as
        <br>
        defense-in-depth. Each check uses WARN_ONCE to log if the race
        is
        <br>
        actually hit, which aids diagnosis of the hard-to-reproduce skb
        <br>
        use-after-free reported on Intel BE200.
        <br>
        <br>
        Note that _iwl_trans_pcie_gen2_stop_device() already calls
        <br>
        iwl_pcie_rx_napi_sync() to quiesce NAPI during device teardown,
        but that
        <br>
        runs much later in the restart sequence. These checks close the
        window
        <br>
        between error detection and device stop.
        <br>
        <br>
        Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
        <br>
        Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
        <br>
        Signed-off-by: Cole Leavitt <a class="moz-txt-link-rfc2396E" href="mailto:cole@unwrap.rs">&lt;cole@unwrap.rs&gt;</a>
        <br>
        ---
        <br>
        Changes since v1:
        <br>
           - Added Fixes: tag and Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
        <br>
        <br>
        Tested on Intel BE200 (FW 101.6e695a70.0) by forcing NMI via
        debugfs.
        <br>
        The WARN_ONCE fires reliably:
        <br>
        <br>
           iwlwifi: NAPI MSIX poll[0] invoked after FW error
        <br>
           WARNING:
        drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058
        <br>
                    at iwl_pcie_napi_poll_msix+0xff/0x130 [iwlwifi],
        CPU#22
        <br>
        <br>
        Confirming NAPI poll is invoked after STATUS_FW_ERROR is set.
        Without
        <br>
        this patch, that poll processes stale RX ring data from dead
        firmware.
        <br>
        <br>
          drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 19
        ++++++++++++++++++
        <br>
          .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 20
        +++++++++++++++++++
        <br>
          2 files changed, 39 insertions(+)
        <br>
        <br>
        diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
        b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
        <br>
        index 3b4b575aadaa..3e99f3ded9bc 100644
        <br>
        --- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
        <br>
        +++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
        <br>
        @@ -1071,6 +1071,18 @@ void iwl_mld_handle_tx_resp_notif(struct
        iwl_mld *mld,
        <br>
              bool mgmt = false;
        <br>
              bool tx_failure = (status &amp; TX_STATUS_MSK) !=
        TX_STATUS_SUCCESS;
        <br>
          +    /* Firmware is dead — the TX response may contain corrupt
        SSN values
        <br>
        +     * from a dying firmware DMA. Processing it could cause
        <br>
        +     * iwl_trans_reclaim() to free the wrong TX queue entries,
        leading to
        <br>
        +     * skb use-after-free or double-free.
        <br>
        +     */
        <br>
        +    if (unlikely(test_bit(STATUS_FW_ERROR,
        &amp;mld-&gt;trans-&gt;status))) {
        <br>
        +        WARN_ONCE(1,
        <br>
        +              "iwlwifi: TX resp notif (sta=%d txq=%d) after FW
        error\n",
        <br>
        +              sta_id, txq_id);
        <br>
        +        return;
        <br>
        +    }
        <br>
        +
        <br>
              if (IWL_FW_CHECK(mld, tx_resp-&gt;frame_count != 1,
        <br>
                       "Invalid tx_resp notif frame_count (%d)\n",
        <br>
                       tx_resp-&gt;frame_count))
        <br>
        @@ -1349,6 +1361,13 @@ void
        iwl_mld_handle_compressed_ba_notif(struct iwl_mld *mld,
        <br>
              u8 sta_id = ba_res-&gt;sta_id;
        <br>
              struct ieee80211_link_sta *link_sta;
        <br>
          +    if (unlikely(test_bit(STATUS_FW_ERROR,
        &amp;mld-&gt;trans-&gt;status))) {
        <br>
        +        WARN_ONCE(1,
        <br>
        +              "iwlwifi: BA notif (sta=%d) after FW error\n",
        <br>
        +              sta_id);
        <br>
        +        return;
        <br>
        +    }
        <br>
        +
        <br>
              if (!tfd_cnt)
        <br>
                  return;
        <br>
          diff --git
        a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
        b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
        <br>
        index 619a9505e6d9..ba18d35fa55d 100644
        <br>
        --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
        <br>
        +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
        <br>
        @@ -1015,6 +1015,18 @@ static int iwl_pcie_napi_poll(struct
        napi_struct *napi, int budget)
        <br>
              trans_pcie = iwl_netdev_to_trans_pcie(napi-&gt;dev);
        <br>
              trans = trans_pcie-&gt;trans;
        <br>
          +    /* Stop processing RX if firmware has crashed. Stale
        notifications
        <br>
        +     * from dying firmware (e.g. TX completions with corrupt
        SSN values)
        <br>
        +     * can cause use-after-free in reclaim paths.
        <br>
        +     */
        <br>
        +    if (unlikely(test_bit(STATUS_FW_ERROR,
        &amp;trans-&gt;status))) {
        <br>
        +        WARN_ONCE(1,
        <br>
        +              "iwlwifi: NAPI poll[%d] invoked after FW
        error\n",
        <br>
        +              rxq-&gt;id);
        <br>
        +        napi_complete_done(napi, 0);
        <br>
        +        return 0;
        <br>
        +    }
        <br>
        +
        <br>
              ret = iwl_pcie_rx_handle(trans, rxq-&gt;id, budget);
        <br>
                IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
        <br>
        @@ -1042,6 +1054,14 @@ static int iwl_pcie_napi_poll_msix(struct
        napi_struct *napi, int budget)
        <br>
              trans_pcie = iwl_netdev_to_trans_pcie(napi-&gt;dev);
        <br>
              trans = trans_pcie-&gt;trans;
        <br>
          +    if (unlikely(test_bit(STATUS_FW_ERROR,
        &amp;trans-&gt;status))) {
        <br>
        +        WARN_ONCE(1,
        <br>
        +              "iwlwifi: NAPI MSIX poll[%d] invoked after FW
        error\n",
        <br>
        +              rxq-&gt;id);
        <br>
        +        napi_complete_done(napi, 0);
        <br>
        +        return 0;
        <br>
        +    }
        <br>
        +
        <br>
              ret = iwl_pcie_rx_handle(trans, rxq-&gt;id, budget);
        <br>
              IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
        rxq-&gt;id, ret,
        <br>
                        budget);
        <br>
      </blockquote>
      <br>
    </blockquote>
    <div class="moz-signature">-- <br>
      <meta charset="UTF-8">
      <title>Email Signature</title>
      <table cellpadding="0" cellspacing="0" border="0"
style="font-family: 'Century Gothic', Arial, sans-serif; font-size: 11pt; color: #54565a; line-height: 1.5; max-width: 600px;">
        <!-- Row 1: headshot + contact info --> <tbody>
          <tr>
            <td
style="vertical-align: top; padding-right: 16px; width: 236px;"> <img
                src="cid:part1.bx8SKipB.CcnQenHX@unwrap.rs"
                alt="Cole Leavitt"
style="display: block; width: 220px; height: 250px; object-fit: cover; object-position: top; border-radius: 4px;">
            </td>
            <td style="vertical-align: top;">
              <div
style="font-size: 16pt; font-weight: bold; color: #e75527; line-height: 1.2;">Cole
                Leavitt</div>
              <div
style="font-weight: bold; color: #54565a; margin-bottom: 10px;">Principal
                Security Engineer</div>
              <div><a href="tel:+15208700922"
                  style="color: #54565a; text-decoration: none;">+1
                  (520) 870-0922</a></div>
              <div style="margin-top: 6px;">4050 E COTTON CENTER BLVD
                STE 40<br>
                PHOENIX AZ 85040-8863</div>
              <div style="margin-top: 6px;"><a
                  href="https://fiwealth.com"
style="color: #006ab1; text-decoration: none; font-weight: bold;">fiwealth.com</a>
              </div>
            </td>
          </tr>
          <!-- Spacer --> <tr>
            <td colspan="2" style="height: 14px;"><br>
            </td>
          </tr>
          <!-- Row 2: Logo --> <tr>
            <td colspan="2"> <img
                src="cid:part2.BGop8mik.g00BzLN4@unwrap.rs"
                alt="Foundations Investment Advisors"
                style="display: block; width: 300px;"> </td>
          </tr>
          <!-- Spacer --> <tr>
            <td colspan="2" style="height: 14px;"><br>
            </td>
          </tr>
          <!-- Row 3: env notice --> <tr>
            <td colspan="2" style="font-size: 9pt; color: #636366;">
              Please consider the environment before printing this
              email. </td>
          </tr>
          <!-- Spacer + divider --> <tr>
            <td colspan="2" style="height: 8px;"><br>
            </td>
          </tr>
          <!-- Row 4: disclaimer --> <tr>
            <td colspan="2"
style="padding-top: 8px; border-top: 1px solid #cccccc; font-size: 8pt; color: #636366; line-height: 1.5; max-width: 600px;">
              <strong>IMPORTANT NOTICE</strong><br>
              Foundations Investment Advisors, LLC is registered with
              the U.S. Securities and Exchange Commission as an
              investment adviser pursuant to the Investment Advisers Act
              of 1940, 15 U.S.C. § 80b. Registration does not imply a
              certain level of skill or training. See Form ADV Part 2A,
              Item 1.C at <a href="https://adviserinfo.sec.gov"
                style="color: #004c97; text-decoration: none;">adviserinfo.sec.gov</a>.<br>
              <br>
              This email may contain confidential or privileged
              information protected under Fed. R. Evid. 502. It is
              intended solely for the named addressee. If received in
              error, notify the sender immediately and delete all
              copies. Unauthorized review, copying, or distribution is
              prohibited. </td>
          </tr>
        </tbody>
      </table>
    </div>
  </body>
</html>
--------------KYwIzx9ERBRj5FSG9tQoGFZX
Content-Type: image/jpeg; name="uQTg7sS1jQmGBnc9.jpg"
Content-Disposition: inline; filename="uQTg7sS1jQmGBnc9.jpg"
Content-Id: <part1.bx8SKipB.CcnQenHX@unwrap.rs>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoM
DAsKCwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsN
FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wAAR
CAVGA5QDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA
AgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK
FhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl
5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA
AgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
NOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE
hYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk
5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD6Y/z/APXo/wA+/wBaXHP+fzoK+n/1/rXn
nQJjP+efrRjn/wCv+tKAT1/z707GP8/rQAijH/6/1pcf5/rR/n3+tOX/AD/jQAAY/wA9faj/
AD9Pej/P/wBej/Pv9aAD/Pv9aP8APv8AWj/Pv9aP8+/1oAP8+/1o/wA+/wBaP8+/1pccf5/O
gBP8+/1o/wA+/wBaMf5/rR/n3+tS0A4EY/zn60cH/P603/Pv9aXP+e/1o2AB/n/GlOP8n9ab
1/8Arfzo/wA+/wBaLgH+f/r0uCf88/Wk/wA+/wBaXOR/n86dwDH+f60n+ff60f59/rR/n3+t
G4B/n3+tLk/h/nmk/wA+/wBaP8+/1qQFJJ/z+tPXp/X1pn+eOv1pwOAP6dfrTAcBj/PI96Rh
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
PrRRQA4ITnBxjiiiigD/2Q==
--------------KYwIzx9ERBRj5FSG9tQoGFZX
Content-Type: image/png; name="1ftrbDu00oyei46w.png"
Content-Disposition: inline; filename="1ftrbDu00oyei46w.png"
Content-Id: <part2.BGop8mik.g00BzLN4@unwrap.rs>
Content-Transfer-Encoding: base64

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
hf8Pmz4JPZssrIYAAAAASUVORK5CYII=

--------------KYwIzx9ERBRj5FSG9tQoGFZX--


--------------k70yhXO3NPSb4Ql6IY5gnrkw--
--------------dkyYWvXVi2hDuZ0MqV3I0GAn
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tcp-add-sk_wmem_alloc-tracing-for-debugging-refcount.patch"
Content-Disposition: attachment;
 filename*0="0001-tcp-add-sk_wmem_alloc-tracing-for-debugging-refcount.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxMWU4NzllZTA2M2RhNmJhMDZiMzdlMTBkMmJkMzZhZjc5NGVmMjE5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDb2xlIExlYXZpdHQgPGNvbGVAdW53cmFwLnJzPgpE
YXRlOiBTdW4sIDEyIEFwciAyMDI2IDE4OjI0OjU0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
dGNwOiBhZGQgc2tfd21lbV9hbGxvYyB0cmFjaW5nIGZvciBkZWJ1Z2dpbmcgcmVmY291bnQK
IHVuZGVyZmxvdwoKQWRkIHRyYWNlX3ByaW50ayBpbnN0cnVtZW50YXRpb24gYXQgZXZlcnkg
cG9pbnQgdGhhdCBtb2RpZmllcwpza193bWVtX2FsbG9jIHRvIGRpYWdub3NlIGEgcmVmY291
bnQgdW5kZXJmbG93IGJ1ZyBvYnNlcnZlZCBvbgppd2x3aWZpIEJFMjAwIGR1cmluZyBUQ1Ag
U0FDSyBwcm9jZXNzaW5nLgoKVHJhY2UgcG9pbnRzIGFkZGVkOgogIC0gc2tiX3NldF9vd25l
cl93KCk6IGNoYXJnZSBhdCBza2IgY3JlYXRpb24KICAtIHRjcF90cmFuc21pdF9za2IoKTog
Y2hhcmdlIGF0IGNsb25lIHRyYW5zbWlzc2lvbgogIC0gc29ja193ZnJlZSgpOiBkcmFpbiBh
dCBza2IgZnJlZSAoZ2VuZXJpYyBwYXRoKQogIC0gdGNwX3dmcmVlKCk6IGRyYWluIGF0IHNr
YiBmcmVlIChUQ1AgZmFzdCBwYXRoKQogIC0gc2tiX3NoaWZ0KCk6IHRydWVzaXplIG1vZGlm
aWNhdGlvbiBkdXJpbmcgU0FDSyBjb2FsZXNjaW5nCgpUaGVzZSB0cmFjZV9wcmludGsgY2Fs
bHMgYXJlIGZvciBkZWJ1Z2dpbmcgb25seSBhbmQgc2hvdWxkIG5vdApiZSBtZXJnZWQgdXBz
dHJlYW0uIFVzZSBmdHJhY2UgdG8gY2FwdHVyZToKICBlY2hvIDEgPiAvc3lzL2tlcm5lbC9k
ZWJ1Zy90cmFjaW5nL3RyYWNpbmdfb24KICA8cmVwcm9kdWNlIHRoZSBjcmFzaD4KICBjYXQg
L3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZy90cmFjZQoKTk9ULUZPUi1VUFNUUkVBTTogZGVi
dWdnaW5nIGluc3RydW1lbnRhdGlvbgpTaWduZWQtb2ZmLWJ5OiBDb2xlIExlYXZpdHQgPGNv
bGVAdW53cmFwLnJzPgotLS0KIG5ldC9jb3JlL3NrYnVmZi5jICAgICB8IDEgKwogbmV0L2Nv
cmUvc29jay5jICAgICAgIHwgMiArKwogbmV0L2lwdjQvdGNwX291dHB1dC5jIHwgMiArKwog
MyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvY29y
ZS9za2J1ZmYuYyBiL25ldC9jb3JlL3NrYnVmZi5jCmluZGV4IDQzZWU4NmRjZjJlYS4uZGJm
NmEwNTgzOWU0IDEwMDY0NAotLS0gYS9uZXQvY29yZS9za2J1ZmYuYworKysgYi9uZXQvY29y
ZS9za2J1ZmYuYwpAQCAtNDM3Myw2ICs0MzczLDcgQEAgaW50IHNrYl9zaGlmdChzdHJ1Y3Qg
c2tfYnVmZiAqdGd0LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgc2hpZnRsZW4pCiAJdGd0
LT5pcF9zdW1tZWQgPSBDSEVDS1NVTV9QQVJUSUFMOwogCXNrYi0+aXBfc3VtbWVkID0gQ0hF
Q0tTVU1fUEFSVElBTDsKIAorCXRyYWNlX3ByaW50aygic2tiX3NoaWZ0OiBzcmM9JXB4IHRz
PSV1IGRzdD0lcHggdHM9JXUgc2hpZnQ9JWRcbiIsIHNrYiwgc2tiLT50cnVlc2l6ZSwgdGd0
LCB0Z3QtPnRydWVzaXplLCBzaGlmdGxlbik7CiAJc2tiX2xlbl9hZGQoc2tiLCAtc2hpZnRs
ZW4pOwogCXNrYl9sZW5fYWRkKHRndCwgc2hpZnRsZW4pOwogCmRpZmYgLS1naXQgYS9uZXQv
Y29yZS9zb2NrLmMgYi9uZXQvY29yZS9zb2NrLmMKaW5kZXggNTk3NjEwMGE5ZDU1Li5jNzli
YmViZWUzMjIgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3NvY2suYworKysgYi9uZXQvY29yZS9z
b2NrLmMKQEAgLTI2NzIsNiArMjY3Miw3IEBAIHZvaWQgc29ja193ZnJlZShzdHJ1Y3Qgc2tf
YnVmZiAqc2tiKQogCWJvb2wgZnJlZTsKIAlpbnQgb2xkOwogCisJdHJhY2VfcHJpbnRrKCJz
b2NrX3dmcmVlOiAtJXUgYmVmb3JlPSVkIHNrYj0lcHhcbiIsIGxlbiwgcmVmY291bnRfcmVh
ZCgmc2stPnNrX3dtZW1fYWxsb2MpLCBza2IpOwogCWlmICghc29ja19mbGFnKHNrLCBTT0NL
X1VTRV9XUklURV9RVUVVRSkpIHsKIAkJaWYgKHNvY2tfZmxhZyhzaywgU09DS19SQ1VfRlJF
RSkgJiYKIAkJICAgIHNrLT5za193cml0ZV9zcGFjZSA9PSBzb2NrX2RlZl93cml0ZV9zcGFj
ZSkgewpAQCAtMjczMSw2ICsyNzMyLDcgQEAgdm9pZCBza2Jfc2V0X293bmVyX3coc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IHNvY2sgKnNrKQogCSAqIGFsbCBpbi1mbGlnaHQgcGFj
a2V0cyBhcmUgY29tcGxldGVkCiAJICovCiAJX19yZWZjb3VudF9hZGQoc2tiLT50cnVlc2l6
ZSwgJnNrLT5za193bWVtX2FsbG9jLCAmb2xkX3dtZW0pOworCXRyYWNlX3ByaW50aygic2V0
X293bmVyX3c6ICsldSBhZnRlcj0lZCBza2I9JXB4XG4iLCBza2ItPnRydWVzaXplLCBvbGRf
d21lbSArIChpbnQpc2tiLT50cnVlc2l6ZSwgc2tiKTsKIAogCS8qIChvbGRfd21lbSA9PSBT
S19XTUVNX0FMTE9DX0JJQVMpIGlmIG5vIG90aGVyIFRYIHBhY2tldCBmb3IgdGhpcyBzb2Nr
ZXQKIAkgKiBpcyBpbiBhIGhvc3QgcXVldWUgKHFkaXNjLCBOSUMgcXVldWUpLgpkaWZmIC0t
Z2l0IGEvbmV0L2lwdjQvdGNwX291dHB1dC5jIGIvbmV0L2lwdjQvdGNwX291dHB1dC5jCmlu
ZGV4IDMyNmI1OGZmMTExOC4uNjg5ZGViNjNiMWIyIDEwMDY0NAotLS0gYS9uZXQvaXB2NC90
Y3Bfb3V0cHV0LmMKKysrIGIvbmV0L2lwdjQvdGNwX291dHB1dC5jCkBAIC0xMzg4LDYgKzEz
ODgsNyBAQCB2b2lkIHRjcF93ZnJlZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCS8qIEtlZXAg
b25lIHJlZmVyZW5jZSBvbiBza193bWVtX2FsbG9jLgogCSAqIFdpbGwgYmUgcmVsZWFzZWQg
Ynkgc2tfZnJlZSgpIGZyb20gaGVyZSBvciB0Y3BfdHNxX3dvcmtmbigpCiAJICovCisJdHJh
Y2VfcHJpbnRrKCJ0Y3Bfd2ZyZWU6IC0ldSBiZWZvcmU9JWQgc2tiPSVweFxuIiwgc2tiLT50
cnVlc2l6ZSAtIDEsIHJlZmNvdW50X3JlYWQoJnNrLT5za193bWVtX2FsbG9jKSwgc2tiKTsK
IAlXQVJOX09OKHJlZmNvdW50X3N1Yl9hbmRfdGVzdChza2ItPnRydWVzaXplIC0gMSwgJnNr
LT5za193bWVtX2FsbG9jKSk7CiAKIAkvKiBJZiB0aGlzIHNvZnRpcnEgaXMgc2VydmljZWQg
Ynkga3NvZnRpcnFkLCB3ZSBhcmUgbGlrZWx5IHVuZGVyIHN0cmVzcy4KQEAgLTE1OTksNiAr
MTYwMCw3IEBAIHN0YXRpYyBpbnQgX190Y3BfdHJhbnNtaXRfc2tiKHN0cnVjdCBzb2NrICpz
aywgc3RydWN0IHNrX2J1ZmYgKnNrYiwKIAlza2ItPnNrID0gc2s7CiAJc2tiLT5kZXN0cnVj
dG9yID0gc2tiX2lzX3RjcF9wdXJlX2Fjayhza2IpID8gX19zb2NrX3dmcmVlIDogdGNwX3dm
cmVlOwogCXJlZmNvdW50X2FkZChza2ItPnRydWVzaXplLCAmc2stPnNrX3dtZW1fYWxsb2Mp
OworCXRyYWNlX3ByaW50aygidGNwX3htaXQ6ICsldSBhZnRlcj0lZCBza2I9JXB4XG4iLCBz
a2ItPnRydWVzaXplLCByZWZjb3VudF9yZWFkKCZzay0+c2tfd21lbV9hbGxvYyksIHNrYik7
CiAKIAlza2Jfc2V0X2RzdF9wZW5kaW5nX2NvbmZpcm0oc2tiLCBSRUFEX09OQ0Uoc2stPnNr
X2RzdF9wZW5kaW5nX2NvbmZpcm0pKTsKIAotLSAKMi41Mi4wCgo=

--------------dkyYWvXVi2hDuZ0MqV3I0GAn--

