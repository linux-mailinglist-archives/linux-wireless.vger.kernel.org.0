Return-Path: <linux-wireless+bounces-31892-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jBNTIv5fk2m64AEAu9opvQ
	(envelope-from <linux-wireless+bounces-31892-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:20:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E25D8146F50
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE6F3017F99
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E72BEC4E;
	Mon, 16 Feb 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="lo0qkI0q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE128FA91
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266041; cv=none; b=FyMKlv7UO4n5F+kS12DCInPn/ENoKfj8sfqe0hkXOK9V+oQxr8XT1L6W1S2V52SJTDllVPoYDwqWw4KxyOUyfck4BWlcUOAzD8gJTQFhAF5/FPXJdqnS5KG+AlQ7kAS4aWBWLn5WX2vTK8DYfyG3JtxAkdVK0JeB8KYLL0FfORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266041; c=relaxed/simple;
	bh=sVvqjAtk7keg86h+EFuG9twphMDytr92CDqeDHidCNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9dZipl75EDbjABqzaHCBaF2bmJasCDEmFgMXCta70aTHmkDfPAVWKfVKtz/4AmVGsgNuZJEfkaMImHH+qpFKm4h75j5cfYe80nsGPtDHZ26skYO7RHowcgPymngm2/4QYgxGgvH8DiK1t3JgGKN6ScMUssZwtZVgaxHcZnH+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=lo0qkI0q; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 677622C92DD
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 18:12:47 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DD55BC400AA;
	Mon, 16 Feb 2026 18:12:38 +0000 (UTC)
Received: from [172.20.83.41] (unknown [24.83.181.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7D9EF13C2B0;
	Mon, 16 Feb 2026 10:12:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7D9EF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1771265555;
	bh=sVvqjAtk7keg86h+EFuG9twphMDytr92CDqeDHidCNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lo0qkI0qH/YGkbZeP8QT9E85AX2p/AVN647UFeZtSLLeWH8ZPBSZvaXtGSdainjd+
	 gFL2WcGUkJ6mTo4osEHW1+P4jyq7js6ysevk9GHVxqJkEDi7WC0HK9w3tfOSZFVwo3
	 D1DGI9TdnMtnFyqzQXG/x1551gJ2Gx61KnMlfSqE=
Message-ID: <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
Date: Mon, 16 Feb 2026 10:12:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: prevent NAPI processing after firmware
 error
To: Cole Leavitt <cole@unwrap.rs>
Cc: johannes.berg@intel.com, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org
References: <c6f886d4-b9ed-48a6-9723-a738af055b64@candelatech.com>
 <20260214181018.6091-1-cole@unwrap.rs>
 <5be8a502-d53a-4cce-821f-202368c44f6d@candelatech.com>
 <20260214183306.10188-1-cole@unwrap.rs>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20260214183306.10188-1-cole@unwrap.rs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1771265560-3CiYrd1T0c9k
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1771265560;3CiYrd1T0c9k;<greearb@candelatech.com>;7a78acbb80695419b4cc4b4fc92f5d88
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31892-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: E25D8146F50
X-Rspamd-Action: no action

On 2/14/26 10:33 AM, Cole Leavitt wrote:
> Ben,
> 
> Good catch on both fronts.
> 
> On the build_tfd dangling pointer -- you're right. The failure path at
> line 775 leaves entries[idx].skb/cmd pointing at caller-owned objects
> (set at lines 763-764). The caller gets -1 and presumably frees the
> skb, so entries[idx].skb becomes a dangling pointer. While write_ptr
> not advancing means current unmap paths won't iterate to that index,
> it's a latent UAF waiting for a flush path change or future code to
> touch it. Two NULL stores inside a held spinlock cost nothing. I think
> this should go upstream as its own patch.
> 
> On the TOCTOU question -- this is the part I spent the most time on.
> The window you're asking about is: firmware starts producing corrupt
> completion data *before* STATUS_FW_ERROR gets set. Our NAPI/TX handler
> checks can't help there because the flag isn't set yet.
> 
> The primary guard in that window is iwl_txq_used() in
> iwl_pcie_reclaim(). It validates that the firmware's SSN falls within
> [read_ptr, write_ptr). This catches wild values -- out-of-range SSNs,
> wraparound corruption, etc.
> 
> What it can't catch is an in-range corrupt SSN -- e.g., firmware says
> reclaim up to index 15 when legitimate is 8, but write_ptr is 20.
> That passes bounds checking and the reclaim loop frees skbs for
> entries still in-flight (active DMA). The NULL skb WARN_ONCE in the
> loop catches double-reclaim but not first-time over-reclaim.
> 
> The complete fix for this would be a per-entry generation counter --
> tag each entry on submit, validate on reclaim. But that adds per-entry
> overhead on the TX hot path to protect against a condition (firmware
> producing corrupt completions) that is already terminal. I think the
> right trade-off is:
> 
>    1. Your build_tfd NULL fix (eliminates one dangling pointer class)
>    2. STATUS_FW_ERROR checks in NAPI poll + TX handlers (this series --
>       shrinks the detection window to near-zero)
>    3. The existing iwl_txq_used() bounds check (catches most corrupt
>       SSNs)
> 
> Together these make the damage window small enough that a per-entry
> generation scheme isn't justified -- by the time firmware is sending
> corrupt SSNs, we're in dump-and-reset territory anyway.
> 
> That said, if you're seeing corruption patterns in your customer
> testing where a valid-looking-but-wrong SSN gets through before
> FW_ERROR fires, I'd be very interested in the traces. That would
> change the cost/benefit on the generation counter approach.

Hello Cole,

Looks like even with your patches we are still seeing use-after-free.  I tried
adding a lot of checks to detect already freed skbs in iwlwifi, and those are not hitting,
so possibly the bug is very close to the end of the call chain, or I am doing it
wrong, or it is some sort of race or bug that my code will not catch.

We do not see any related crashes when using mt76 radios, so pretty sure this
is related to iwlwifi.  A particular AP reproduces this problem within
a day, and we can run tcp tests for 30+ days against other APs with no problem.
I don't know what the AP could be doing to trigger this though.

No FW crash was seen in my logs in this case.

My tree is here if you care to investigate any of my UAF debugging or see
what code is printing some of these logs.  Suggestions for improvement would
be welcome!

https://github.com/greearb/linux-ct-6.18

One problem I see (for several years) is an infinite busy-spin in iwl-mvm-tx-tso-segment.  I added code to break
out after 32k loops, and warn.  That hits here.  The system crashes 28 minutes later, so not
sure if that is directly related.  I guess I can try to do more debugging around that bad tso
segment path.

Feb 16 00:16:01 LF1-MobileStation1 kernel: skbuff: ERROR: Found more than 32000 packets in skbuff::skb_segment, bailing out.
Feb 16 00:16:01 LF1-MobileStation1 kernel: ERROR: iwl-mvm-tx-tso-segment, list gso-segment list is huge: 32001, bailing out.
Feb 16 00:16:06 LF1-MobileStation1 kernel: skbuff: ERROR: Found more than 32000 packets in skbuff::skb_segment, bailing out.
Feb 16 00:16:06 LF1-MobileStation1 kernel: ERROR: iwl-mvm-tx-tso-segment, list gso-segment list is huge: 32001, bailing out.

Feb 16 00:44:06 LF1-MobileStation1 kernel: ------------[ cut here ]------------
Feb 16 00:44:06 LF1-MobileStation1 kernel: refcount_t: underflow; use-after-free.
Feb 16 00:44:06 LF1-MobileStation1 kernel: WARNING: CPU: 18 PID: 1203 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
Feb 16 00:44:06 LF1-MobileStation1 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink tls vrf nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp 
stp llc macvlan wanlink(O) pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr nct7802 vfat fat intel_rapl_msr coretemp intel_rapl_common intel_uncore_frequency 
intel_uncore_frequency_common snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc882 x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek_lib 
ofpart snd_hda_codec_generic i2c_designware_platform spi_nor kvm_intel spi_pxa2xx_platform iwlmld i2c_designware_core spd5118 dw_dmac iTCO_wdt intel_pmc_bxt ccp 
mtd regmap_i2c spi_pxa2xx_core uvcvideo kvm snd_hda_intel 8250_dw iTCO_vendor_support mac80211 uvc snd_intel_dspcfg irqbypass videobuf2_vmalloc snd_hda_codec 
videobuf2_memops btusb videobuf2_v4l2 btbcm snd_hda_core videobuf2_common snd_hwdep videodev btmtk snd_seq btrtl mc btintel iwlwifi cdc_acm onboard_usb_dev 
snd_seq_device bluetooth snd_pcm cfg80211 snd_timer intel_pmc_core snd intel_lpss_pci i2c_i801 pmt_telemetry
Feb 16 00:44:06 LF1-MobileStation1 kernel:  i2c_smbus soundcore intel_lpss pmt_discovery spi_intel_pci mei_hdcp idma64 i2c_mux pmt_class wmi_bmof spi_intel 
pcspkr mei_pxp intel_pmc_ssram_telemetry bfq acpi_tad acpi_pad nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sch_fq_codel sunrpc fuse zram raid1 dm_raid 
raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec 
drm_gpusvm_helper i915 i2c_algo_bit drm_buddy intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core intel_oc_wdt ttm ixgbe agpgart mdio 
libie_fwlog e1000e igc dca hwmon drm mei_wdt intel_vsec i2c_core video wmi pinctrl_alderlake efivarfs [last unloaded: nfnetlink]
Feb 16 00:44:06 LF1-MobileStation1 kernel: CPU: 18 UID: 0 PID: 1203 Comm: irq/343-iwlwifi Tainted: G S         O        6.18.9+ #53 PREEMPT(full)
Feb 16 00:44:06 LF1-MobileStation1 kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
Feb 16 00:44:06 LF1-MobileStation1 kernel: Hardware name: Default string /Default string, BIOS 5.27 11/12/2024
Feb 16 00:44:06 LF1-MobileStation1 kernel: RIP: 0010:refcount_warn_saturate+0xd8/0xe0
Feb 16 00:44:07 LF1-MobileStation1 kernel: Code: ff 48 c7 c7 d8 a4 6d 82 c6 05 d0 4a 3e 01 01 e8 3e 83 a7 ff 0f 0b c3 48 c7 c7 80 a4 6d 82 c6 05 bc 4a 3e 01 01 
e8 28 83 a7 ff <0f> 0b c3 0f 1f 44 00 00 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 13
Feb 16 00:44:07 LF1-MobileStation1 kernel: RSP: 0018:ffffc9000045c6d0 EFLAGS: 00010282
Feb 16 00:44:07 LF1-MobileStation1 kernel: RAX: 0000000000000000 RBX: ffff8882772db000 RCX: 0000000000000000
Feb 16 00:44:07 LF1-MobileStation1 kernel: RDX: ffff88885faa5f00 RSI: 0000000000000001 RDI: ffff88885fa98d00
Feb 16 00:44:07 LF1-MobileStation1 kernel: RBP: ffff8882447d9e00 R08: 0000000000000000 R09: 0000000000000003
Feb 16 00:44:07 LF1-MobileStation1 kernel: R10: ffffc9000045c570 R11: ffffffff82b58da8 R12: ffff88820165f200
Feb 16 00:44:07 LF1-MobileStation1 kernel: R13: 0000000000000001 R14: 00000000000005a8 R15: ffffc9000045c890
Feb 16 00:44:07 LF1-MobileStation1 kernel: FS:  0000000000000000(0000) GS:ffff8888dc5ae000(0000) knlGS:0000000000000000
Feb 16 00:44:07 LF1-MobileStation1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 16 00:44:07 LF1-MobileStation1 kernel: CR2: 00007fd1022fdcb4 CR3: 0000000005a36004 CR4: 0000000000772ef0
Feb 16 00:44:07 LF1-MobileStation1 kernel: PKRU: 55555554
Feb 16 00:44:07 LF1-MobileStation1 kernel: Call Trace:
Feb 16 00:44:07 LF1-MobileStation1 kernel:  <IRQ>
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_shifted_skb+0x1d2/0x300
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_sacktag_walk+0x2da/0x4d0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_sacktag_write_queue+0x4a1/0x9a0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_ack+0xd66/0x16e0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? ip_finish_output2+0x189/0x570
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_rcv_established+0x211/0xc10
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? sk_filter_trim_cap+0x1a7/0x350
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_v4_do_rcv+0x1bf/0x350
Feb 16 00:44:07 LF1-MobileStation1 kernel:  tcp_v4_rcv+0xddf/0x1550
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? raw_local_deliver+0xcc/0x280
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ip_protocol_deliver_rcu+0x20/0x130
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ip_local_deliver_finish+0x85/0xf0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ip_sublist_rcv_finish+0x35/0x50
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ip_sublist_rcv+0x16f/0x200
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ip_list_rcv+0xfe/0x130
Feb 16 00:44:07 LF1-MobileStation1 kernel:  __netif_receive_skb_list_core+0x183/0x1f0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  netif_receive_skb_list_internal+0x1c8/0x2a0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  gro_receive_skb+0x12e/0x210
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ieee80211_rx_napi+0x82/0xc0 [mac80211]
Feb 16 00:44:07 LF1-MobileStation1 kernel:  iwl_mld_rx_mpdu+0xd0f/0xf00 [iwlmld]
Feb 16 00:44:07 LF1-MobileStation1 kernel:  iwl_pcie_rx_handle+0x394/0xa00 [iwlwifi]
Feb 16 00:44:07 LF1-MobileStation1 kernel:  iwl_pcie_napi_poll_msix+0x3f/0x110 [iwlwifi]
Feb 16 00:44:07 LF1-MobileStation1 kernel:  __napi_poll+0x25/0x1e0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  net_rx_action+0x2d3/0x340
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? try_to_wake_up+0x2e6/0x610
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? __handle_irq_event_percpu+0xa3/0x230
Feb 16 00:44:07 LF1-MobileStation1 kernel:  handle_softirqs+0xca/0x2b0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? irq_thread_dtor+0xa0/0xa0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  do_softirq.part.0+0x3b/0x60
Feb 16 00:44:07 LF1-MobileStation1 kernel:  </IRQ>
Feb 16 00:44:07 LF1-MobileStation1 kernel:  <TASK>
Feb 16 00:44:07 LF1-MobileStation1 kernel:  __local_bh_enable_ip+0x58/0x60
Feb 16 00:44:07 LF1-MobileStation1 kernel:  iwl_pcie_irq_rx_msix_handler+0xbb/0x100 [iwlwifi]
Feb 16 00:44:07 LF1-MobileStation1 kernel:  irq_thread_fn+0x19/0x50
Feb 16 00:44:07 LF1-MobileStation1 kernel:  irq_thread+0x126/0x230
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? irq_finalize_oneshot.part.0+0xc0/0xc0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? irq_forced_thread_fn+0x40/0x40
Feb 16 00:44:07 LF1-MobileStation1 kernel:  kthread+0xf7/0x1f0
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? kthreads_online_cpu+0x100/0x100
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? kthreads_online_cpu+0x100/0x100
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ret_from_fork+0x114/0x140
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ? kthreads_online_cpu+0x100/0x100
Feb 16 00:44:07 LF1-MobileStation1 kernel:  ret_from_fork_asm+0x11/0x20
Feb 16 00:44:07 LF1-MobileStation1 kernel:  </TASK>
Feb 16 00:44:07 LF1-MobileStation1 kernel: ---[ end trace 0000000000000000 ]---
Feb 16 00:44:07 LF1-MobileStation1 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000

[NPE shortly after in tcp code, bug real problem is the use-after-free I assume]
# serial console output of the crash following the UAF.

#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 18 UID: 0 PID: 1203 Comm: irq/343-iwlwifi Tainted: G S      W  O        6.18.9+ #53 PREEMPT(full)
Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
Hardware name: Default string /Default string, BIOS 5.27 11/12/2024
RIP: 0010:tcp_rack_detect_loss+0x11c/0x170
Code: 07 00 00 48 8b 87 b0 06 00 00 44 01 ee 48 29 d0 ba 00 00 00 00 48 0f 48 c2 29 c6 85 f6 7e 27 41 8b 06 39 f0 0f 42 c6 41 89 06 <48> 8b 45 58 4c 8d 65 58 48 
89 eb 48 83 e8 58 4d 39 fc 74 ab 48 89
RSP: 0018:ffffc9000045c758 EFLAGS: 00010293
RAX: 000000000000408d RBX: ffff88824fff7a00 RCX: 20c49ba5e353f7cf
RDX: 0000000000000000 RSI: 000000000000408d RDI: ffff88820165f200
RBP: ffffffffffffffa8 R08: 0000000083eed3f9 R09: 000000000000012c
R10: 00000000000005ba R11: 000000000000001d R12: ffff88824fff7a58
R13: 000000000000408d R14: ffffc9000045c79c R15: ffff88820165f888
FS:  0000000000000000(0000) GS:ffff8888dc5ae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000005a36004 CR4: 0000000000772ef0
PKRU: 55555554
Call Trace:
  <IRQ>
  tcp_rack_mark_lost+0x59/0xe0
  tcp_identify_packet_loss+0x30/0x70
  tcp_fastretrans_alert+0x366/0x810
  tcp_ack+0xc66/0x16e0
  ? ip_finish_output2+0x189/0x570
  tcp_rcv_established+0x211/0xc10
  ? sk_filter_trim_cap+0x1a7/0x350
  tcp_v4_do_rcv+0x1bf/0x350
  tcp_v4_rcv+0xddf/0x1550
  ? raw_local_deliver+0xcc/0x280
  ip_protocol_deliver_rcu+0x20/0x130
  ip_local_deliver_finish+0x85/0xf0
  ip_sublist_rcv_finish+0x35/0x50
  ip_sublist_rcv+0x16f/0x200
  ip_list_rcv+0xfe/0x130
  __netif_receive_skb_list_core+0x183/0x1f0
  netif_receive_skb_list_internal+0x1c8/0x2a0
  gro_receive_skb+0x12e/0x210
  ieee80211_rx_napi+0x82/0xc0 [mac80211]
  iwl_mld_rx_mpdu+0xd0f/0xf00 [iwlmld]
  iwl_pcie_rx_handle+0x394/0xa00 [iwlwifi]
  iwl_pcie_napi_poll_msix+0x3f/0x110 [iwlwifi]
  __napi_poll+0x25/0x1e0
  net_rx_action+0x2d3/0x340
  ? try_to_wake_up+0x2e6/0x610
  ? __handle_irq_event_percpu+0xa3/0x230
  handle_softirqs+0xca/0x2b0
  ? irq_thread_dtor+0xa0/0xa0
  do_softirq.part.0+0x3b/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x58/0x60
  iwl_pcie_irq_rx_msix_handler+0xbb/0x100 [iwlwifi]
  irq_thread_fn+0x19/0x50
  irq_thread+0x126/0x230
  ? irq_finalize_oneshot.part.0+0xc0/0xc0
  ? irq_forced_thread_fn+0x40/0x40
  kthread+0xf7/0x1f0
  ? kthreads_online_cpu+0x100/0x100
  ? kthreads_online_cpu+0x100/0x100
  ret_from_fork+0x114/0x140
  ? kthreads_online_cpu+0x100/0x100
  ret_from_fork_asm+0x11/0x20
  </TASK>
Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink tls vrf nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc macvlan wanlink(O) pktgen rpcrdma 
rdma_cm iw_cm ib_cm ib_core qrtr nct7802 vfat fat intel_rapl_msr coretemp intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common 
snd_hda_codec_intelhdmi snd_hda_codec_hdmi snd_hda_codec_alc882 x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek_lib ofpart snd_hda_codec_generic 
i2c_designware_platform spi_nor kvm_intel spi_pxa2xx_platform iwlmld i2c_designware_core spd5118 dw_dmac iTCO_wdt intel_pmc_bxt ccp mtd regmap_i2c 
spi_pxa2xx_core uvcvideo kvm snd_hda_intel 8250_dw iTCO_vendor_support mac80211 uvc snd_intel_dspcfg irqbypass videobuf2_vmalloc snd_hda_codec videobuf2_memops 
btusb videobuf2_v4l2 btbcm snd_hda_core videobuf2_common snd_hwdep videodev btmtk snd_seq btrtl mc btintel iwlwifi cdc_acm onboard_usb_dev snd_seq_device 
bluetooth snd_pcm cfg80211 snd_timer intel_pmc_core snd intel_lpss_pci i2c_i801 pmt_telemetry
  i2c_smbus soundcore intel_lpss pmt_discovery spi_intel_pci mei_hdcp idma64 i2c_mux pmt_class wmi_bmof spi_intel pcspkr mei_pxp intel_pmc_ssram_telemetry bfq 
acpi_tad acpi_pad nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sch_fq_codel sunrpc fuse zram raid1 dm_raid raid456 async_raid6_recov async_memcpy async_pq 
async_xor xor async_tx raid6_pq xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec drm_gpusvm_helper i915 i2c_algo_bit drm_buddy intel_gtt 
drm_client_lib drm_display_helper drm_kms_helper cec rc_core intel_oc_wdt ttm ixgbe agpgart mdio libie_fwlog e1000e igc dca hwmon drm mei_wdt intel_vsec 
i2c_core video wmi pinctrl_alderlake efivarfs [last unloaded: nfnetlink]
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:tcp_rack_detect_loss+0x11c/0x170
Code: 07 00 00 48 8b 87 b0 06 00 00 44 01 ee 48 29 d0 ba 00 00 00 00 48 0f 48 c2 29 c6 85 f6 7e 27 41 8b 06 39 f0 0f 42 c6 41 89 06 <48> 8b 45 58 4c 8d 65 58 48 
89 eb 48 83 e8 58 4d 39 fc 74 ab 48 89
RSP: 0018:ffffc9000045c758 EFLAGS: 00010293
RAX: 000000000000408d RBX: ffff88824fff7a00 RCX: 20c49ba5e353f7cf
RDX: 0000000000000000 RSI: 000000000000408d RDI: ffff88820165f200
RBP: ffffffffffffffa8 R08: 0000000083eed3f9 R09: 000000000000012c
R10: 00000000000005ba R11: 000000000000001d R12: ffff88824fff7a58
R13: 000000000000408d R14: ffffc9000045c79c R15: ffff88820165f888
FS:  0000000000000000(0000) GS:ffff8888dc5ae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000005a36004 CR4: 0000000000772ef0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 10 seconds..

Thanks,
Ben

> 
> Thanks,
> Cole
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

