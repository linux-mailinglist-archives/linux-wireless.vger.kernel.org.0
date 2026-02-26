Return-Path: <linux-wireless+bounces-32227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN4cM2iioGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:43:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC381AE950
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B9D0301D060
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DE44E02C;
	Thu, 26 Feb 2026 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Hl0B8VYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD642883B;
	Thu, 26 Feb 2026 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134651; cv=none; b=YNdNLL797WzrOZdPpk9bOYWV9bHhO3Qlq1YFnoX9I2JQ7/S1p6rKt6WvsfUWtuf3vzBvEqQAJWTDCGctwkW2E4VcSof5nEYKz/v2IzEOguG75OFJtZh7GlOTnB+ApDBQ0x5jNSS7KmLKYomXh7GgDPQSYbz9Kq+Wz3Yi2KbNTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134651; c=relaxed/simple;
	bh=e4XJai9zpE7Ju12u/jWYL80yU5qqFEzNm+MC3T4lOqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O09VvJGq0+SL4NPYitjFSgpt2/jNxsSNTMw8XMtlP5hsumTi6EpAAnves+y8tM8v6iW5D18g7z5fYqFBbjYKJDnGD7qWwv6qkbZNnD1kJGVOaVKlgMMWKbruS83UYJIZ2+Se72AFn0AMiJvUWjXfDYQIt9Av1N48UamcFUhw13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Hl0B8VYL; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 666662ACD14;
	Thu, 26 Feb 2026 19:37:21 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C92C1B00093;
	Thu, 26 Feb 2026 19:37:13 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2A61213C2B0;
	Thu, 26 Feb 2026 11:37:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2A61213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772134631;
	bh=e4XJai9zpE7Ju12u/jWYL80yU5qqFEzNm+MC3T4lOqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hl0B8VYLOsnMEfc7jZ6/LNdPwda67mDHWtTw+VH+O0PBQ/I+rq/JbdioKasDAAjfQ
	 UpdKw+8GY4A9stYbkt0b2OT6UipSlUDz1EpYv9vgP0hztBht9QUzq28GkP7WZTBNE4
	 SfBEzjXB27Rdt0L6PbQYssGGRVykeBpdi0Gylxxo=
Message-ID: <e6d6d4ad-475a-7bad-0dc9-6a920ed7f8ed@candelatech.com>
Date: Thu, 26 Feb 2026 11:37:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] wifi: iwlwifi: prevent NAPI processing after firmware
 error
Content-Language: en-US
To: Cole Leavitt <cole@unwrap.rs>, johannes.berg@intel.com,
 miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org
References: <20260214181018.6091-1-cole@unwrap.rs>
 <20260214184352.11512-1-cole@unwrap.rs>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20260214184352.11512-1-cole@unwrap.rs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1772134634-sOFDASqYgAb7
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772134634;sOFDASqYgAb7;<greearb@candelatech.com>;874a6e8d4b105f853a4d4b73ba2c07da
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32227-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: 3BC381AE950
X-Rspamd-Action: no action

On 2/14/26 10:43, Cole Leavitt wrote:
> After a firmware error is detected and STATUS_FW_ERROR is set, NAPI can
> still be actively polling or get scheduled from a prior interrupt. The
> NAPI poll functions (both legacy and MSIX variants) have no check for
> STATUS_FW_ERROR and will continue processing stale RX ring entries from
> dying firmware. This can dispatch TX completion notifications containing
> corrupt SSN values to iwl_mld_handle_tx_resp_notif(), which passes them
> to iwl_trans_reclaim(). If the corrupt SSN causes reclaim to walk TX
> queue entries that were already freed by a prior correct reclaim, the
> result is an skb use-after-free or double-free.

Hello Cole,

We've been testing with this patch, and today managed to see its logic trigger.
The system had a cascade of other errors leading to use-after-free that does
not appear to be related to the skb use-after free, but I can at least confirm your
patch can be triggered.  Here are logs around this.  I believe in this case, firmware
didn't actually bubble up a crash notification/interrupt, but probably the driver detected timeout
and faked a crash.

Feb 26 11:09:35 ct523c-de7c kernel: workqueue: blk_mq_requeue_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
Feb 26 11:09:36 ct523c-de7c kernel: workqueue: gc_worker [nf_conntrack] hogged CPU for >10000us 515 times, consider switching to WQ_UNBOUND
Feb 26 11:09:39 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Error sending SYSTEM_STATISTICS_CMD: time out after 2000ms.
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Current CMD queue read_ptr 92 write_ptr 93
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start IWL Error Log Dump:
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Transport status: 0x0000004A, valid: 6
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | trm_hw_status0
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | trm_hw_status1
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002C438C | branchlink2
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C04 | interruptlink1
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C04 | interruptlink2
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C3C | data1
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01000000 | data2
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | data3
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xD040FE38 | beacon time
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x3B6411CD | tsf low
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000026B | tsf hi
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | time gp1
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0616DB18 | time gp2
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000001 | uCode revision type
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000065 | uCode version major
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x6EF20B19 | uCode version minor
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000472 | hw version
Feb 26 11:09:40 ct523c-de7c kernel: ------------[ cut here ]------------
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi: NAPI MSIX poll[0] invoked after FW error
Feb 26 11:09:40 ct523c-de7c kernel: WARNING: CPU: 3 PID: 36 at drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058 iwl_pcie_napi_poll_msix+0x29e/0x310 
[iwlwifi]
Feb 26 11:09:40 ct523c-de7c kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc 
macvlan pktgen rfcomm rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp 
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec_intelhdmi snd_hda_codec_hdmi intel_tcc_cooling x86_pkg_temp_thermal 
snd_hda_codec_alc662 snd_hda_codec_realtek_lib intel_powerclamp intel_wmi_thunderbolt snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec 
mac80211 snd_hda_core snd_hwdep snd_seq btusb btbcm snd_seq_device btmtk btrtl btintel snd_pcm iwlwifi bluetooth snd_timer cfg80211 i2c_i801 snd i2c_smbus 
soundcore i2c_mux mei_pxp mei_hdcp intel_pch_thermal intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq nfsd 
sch_fq_codel auth_rpcgss nfs_acl lockd grace nfs_localio fuse sunrpc raid1 dm_raid raid456 async_raid6_recov async_memcpy async_pq
Feb 26 11:09:40 ct523c-de7c kernel:  async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core ttm 
agpgart ixgbe mdio igb libie_fwlog i2c_algo_bit dca drm hwmon mei_wdt i2c_core intel_oc_wdt video wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath [last 
unloaded: nfnetlink]
Feb 26 11:09:40 ct523c-de7c kernel: CPU: 3 UID: 0 PID: 36 Comm: ksoftirqd/3 Kdump: loaded Not tainted 6.18.9+ #18 PREEMPT(full)
Feb 26 11:09:40 ct523c-de7c kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Feb 26 11:09:40 ct523c-de7c kernel: RIP: 0010:iwl_pcie_napi_poll_msix+0x29e/0x310 [iwlwifi]
Feb 26 11:09:40 ct523c-de7c kernel: Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03 7e 74 8b b3 48 ff ff ff 48 c7 c7 a0 d2 19 a2 e8 62 
00 0f df <0f> 0b eb 96 4c 89 e7 e8 d6 92 9f df e9 0b fe ff ff e8 cc 92 9f df
Feb 26 11:09:40 ct523c-de7c kernel: RSP: 0018:ffff888120fe7b70 EFLAGS: 00010286
Feb 26 11:09:40 ct523c-de7c kernel: RAX: 0000000000000000 RBX: ffff888182e100b8 RCX: 0000000000000001
Feb 26 11:09:40 ct523c-de7c kernel: RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88841dba4e48
Feb 26 11:09:40 ct523c-de7c kernel: RBP: ffff888132504028 R08: 0000000000000001 R09: ffffed1083b749c9
Feb 26 11:09:40 ct523c-de7c kernel: R10: ffff88841dba4e4b R11: 0000000000072ee8 R12: ffff888132504090
Feb 26 11:09:40 ct523c-de7c kernel: R13: ffff888132504d90 R14: 0000000000000040 R15: ffff888134b480b8
Feb 26 11:09:40 ct523c-de7c kernel: FS:  0000000000000000(0000) GS:ffff8884974c7000(0000) knlGS:0000000000000000
Feb 26 11:09:40 ct523c-de7c kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 26 11:09:40 ct523c-de7c kernel: CR2: 00007fd5beb80028 CR3: 000000013e2d4001 CR4: 00000000003706f0
Feb 26 11:09:40 ct523c-de7c kernel: Call Trace:
Feb 26 11:09:40 ct523c-de7c kernel:  <TASK>
Feb 26 11:09:40 ct523c-de7c kernel:  __napi_poll.constprop.0+0xa0/0x580
Feb 26 11:09:40 ct523c-de7c kernel:  net_rx_action+0x84d/0xe40
Feb 26 11:09:40 ct523c-de7c kernel:  ? __napi_poll.constprop.0+0x580/0x580
Feb 26 11:09:40 ct523c-de7c kernel:  ? do_raw_spin_lock+0x12c/0x270
Feb 26 11:09:40 ct523c-de7c kernel:  ? run_timer_softirq+0xf2/0x1b0
Feb 26 11:09:40 ct523c-de7c kernel:  ? lock_release+0xce/0x290
Feb 26 11:09:40 ct523c-de7c kernel:  ? trace_irq_enable.constprop.0+0xbe/0x100
Feb 26 11:09:40 ct523c-de7c kernel:  handle_softirqs+0x1c6/0x810
Feb 26 11:09:40 ct523c-de7c kernel:  run_ksoftirqd+0x2d/0x50
Feb 26 11:09:40 ct523c-de7c kernel:  smpboot_thread_fn+0x338/0x8c0
Feb 26 11:09:40 ct523c-de7c kernel:  ? sort_range+0x20/0x20
Feb 26 11:09:40 ct523c-de7c kernel:  kthread+0x3b7/0x770
Feb 26 11:09:40 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:40 ct523c-de7c kernel:  ? ret_from_fork+0x17/0x3a0
Feb 26 11:09:40 ct523c-de7c kernel:  ? lock_release+0xce/0x290
Feb 26 11:09:40 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:40 ct523c-de7c kernel:  ret_from_fork+0x28b/0x3a0
Feb 26 11:09:40 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:40 ct523c-de7c kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 11:09:40 ct523c-de7c kernel:  </TASK>
Feb 26 11:09:40 ct523c-de7c kernel: irq event stamp: 36429934
Feb 26 11:09:40 ct523c-de7c kernel: hardirqs last  enabled at (36429940): [<ffffffff816116ee>] __up_console_sem+0x5e/0x70
Feb 26 11:09:40 ct523c-de7c kernel: hardirqs last disabled at (36429945): [<ffffffff816116d3>] __up_console_sem+0x43/0x70
Feb 26 11:09:40 ct523c-de7c kernel: softirqs last  enabled at (36428910): [<ffffffff81471d3d>] run_ksoftirqd+0x2d/0x50
Feb 26 11:09:40 ct523c-de7c kernel: softirqs last disabled at (36428915): [<ffffffff81471d3d>] run_ksoftirqd+0x2d/0x50
Feb 26 11:09:40 ct523c-de7c kernel: ---[ end trace 0000000000000000 ]---
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C80002 | board version
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x036D001C | hcmd
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xF6F38000 | isr0
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01400000 | isr1
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x48F00002 | isr2
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C00008 | isr3
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x18200000 | isr4
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x036D001C | last cmd Id
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009C3C | wait_event
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x10000010 | l2p_control
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | l2p_duration
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | l2p_mhvalid
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | l2p_addr_match
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000009 | lmpm_pmg_sel
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | timestamp
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009018 | flow_handler
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start IWL Error Log Dump:
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Transport status: 0x0000004A, valid: 6
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Loaded firmware version: 101.6ef20b19.0 gl-c0-fm-c0-101.ucode
Feb 26 11:09:40 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | trm_hw_status0
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | trm_hw_status1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002C438C | branchlink2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002B8AD0 | interruptlink1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002B8AD0 | interruptlink2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002A5822 | data1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01000000 | data2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | data3
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xD040FE37 | beacon time
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x3B6411CE | tsf low
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000026B | tsf hi
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | time gp1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0616DB19 | time gp2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000001 | uCode revision type
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000065 | uCode version major
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x6EF20B19 | uCode version minor
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000472 | hw version
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C80002 | board version
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x804AFC12 | hcmd
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00020000 | isr0
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | isr1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x48F00002 | isr2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00C0001C | isr3
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | isr4
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | last cmd Id
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x002A5822 | wait_event
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x10000010 | l2p_control
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | l2p_duration
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | l2p_mhvalid
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | l2p_addr_match
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000028 | lmpm_pmg_sel
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | timestamp
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00009018 | flow_handler
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Start IWL Error Log Dump:
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Transport status: 0x0000004A, valid: 7
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000066 | NMI_INTERRUPT_HOST
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | umac branchlink1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xC00808AA | umac branchlink2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x80287BFE | umac interruptlink1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0102163E | umac interruptlink2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01000000 | umac data1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0102163E | umac data2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | umac data3
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000065 | umac major
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x6EF20B19 | umac minor
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0616DB0F | frame pointer
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xD00D6258 | stack pointer
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x005C020F | last host cmd
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000400 | isr status reg
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM1 status:
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | error ID
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001D2E | tcm branchlink2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | tcm interruptlink1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | tcm interruptlink2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x40000000 | tcm data1
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | tcm data2
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | tcm data3
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001DAC | tcm log PC
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | tcm frame pointer
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | tcm stack pointer
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm msg ID
Feb 26 11:09:41 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x4000001F | tcm ISR status
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | tcm HW status[0]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm HW status[1]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm HW status[2]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x40008300 | tcm HW status[3]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm HW status[4]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm SW status[0]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM1 status:
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | error ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E2E | rcm branchlink2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | rcm interruptlink1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | rcm interruptlink2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000000 | rcm data1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | rcm data2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | rcm data3
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E98 | rcm log PC
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | rcm frame pointer
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | rcm stack pointer
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | rcm msg ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x2006F000 | rcm ISR status
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00020400 | frame HW status
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | LMAC-to-RCM request mbox
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | RCM-to-LMAC request mbox
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | MAC header control
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | MAC header addr1 low
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x003C0000 | MAC header info
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | MAC header error
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM2 status:
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | error ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001D2E | tcm branchlink2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | tcm interruptlink1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000211C | tcm interruptlink2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x40000000 | tcm data1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | tcm data2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | tcm data3
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001DAC | tcm log PC
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | tcm frame pointer
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | tcm stack pointer
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm msg ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x60000000 | tcm ISR status
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000002F0 | tcm HW status[0]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm HW status[1]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm HW status[2]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00008000 | tcm HW status[3]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm HW status[4]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | tcm SW status[0]
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM2 status:
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000070 | error ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E2E | rcm branchlink2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | rcm interruptlink1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000027A0 | rcm interruptlink2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000000 | rcm data1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | rcm data2
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0xDEADBEEF | rcm data3
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00001E98 | rcm log PC
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803FF0 | rcm frame pointer
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00803F5C | rcm stack pointer
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | rcm msg ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x20000000 | rcm ISR status
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00020400 | frame HW status
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | LMAC-to-RCM request mbox
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | RCM-to-LMAC request mbox
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | MAC header control
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | MAC header addr1 low
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x003C0000 | MAC header info
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | MAC header error
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: IML/ROM dump:
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000B03 | IML/ROM error/state
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000EEE3 | IML/ROM data1
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Fseq Registers:
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x60000000 | FSEQ_ERROR_CODE
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x80B10006 | FSEQ_TOP_INIT_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | FSEQ_CNVI_ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | FSEQ_CNVR_ID
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x8F0F1BEF | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00B10006 | FSEQ_WIFI_FSEQ_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x00B10005 | FSEQ_BT_FSEQ_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x000000DC | FSEQ_CLASS_TP_VERSION
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: UMAC CURRENT PC: 0x8028b720
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: LMAC1 CURRENT PC: 0xd0
Feb 26 11:09:42 ct523c-de7c kernel: iwlwifi 0000:28:00.0: LMAC2 CURRENT PC: 0xd0
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: UMAC CURRENT PC 1: 0x8028b722
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: TCM1 CURRENT PC: 0xd0
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM1 CURRENT PC: 0xd0
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: RCM2 CURRENT PC: 0xd0
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Function Scratch status:
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: 0x01010100 | Func Scratch
Feb 26 11:09:43 ct523c-de7c kernel: iwlwifi 0000:28:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).


Thanks,
Ben

> 
> The race window opens when the MSIX IRQ handler schedules NAPI (lines
> 2319-2321 in rx.c) before processing the error bit (lines 2382-2396),
> or when NAPI is already running on another CPU from a previous interrupt
> when STATUS_FW_ERROR gets set on the current CPU.
> 
> Add STATUS_FW_ERROR checks to both NAPI poll functions to prevent
> processing stale RX data after firmware error, and add early-return
> guards in the TX response and compressed BA notification handlers as
> defense-in-depth. Each check uses WARN_ONCE to log if the race is
> actually hit, which aids diagnosis of the hard-to-reproduce skb
> use-after-free reported on Intel BE200.
> 
> Note that _iwl_trans_pcie_gen2_stop_device() already calls
> iwl_pcie_rx_napi_sync() to quiesce NAPI during device teardown, but that
> runs much later in the restart sequence. These checks close the window
> between error detection and device stop.
> 
> Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cole Leavitt <cole@unwrap.rs>
> ---
> Changes since v1:
>    - Added Fixes: tag and Cc: stable@vger.kernel.org
> 
> Tested on Intel BE200 (FW 101.6e695a70.0) by forcing NMI via debugfs.
> The WARN_ONCE fires reliably:
> 
>    iwlwifi: NAPI MSIX poll[0] invoked after FW error
>    WARNING: drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:1058
>             at iwl_pcie_napi_poll_msix+0xff/0x130 [iwlwifi], CPU#22
> 
> Confirming NAPI poll is invoked after STATUS_FW_ERROR is set. Without
> this patch, that poll processes stale RX ring data from dead firmware.
> 
>   drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 19 ++++++++++++++++++
>   .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 20 +++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
> index 3b4b575aadaa..3e99f3ded9bc 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
> @@ -1071,6 +1071,18 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
>   	bool mgmt = false;
>   	bool tx_failure = (status & TX_STATUS_MSK) != TX_STATUS_SUCCESS;
>   
> +	/* Firmware is dead — the TX response may contain corrupt SSN values
> +	 * from a dying firmware DMA. Processing it could cause
> +	 * iwl_trans_reclaim() to free the wrong TX queue entries, leading to
> +	 * skb use-after-free or double-free.
> +	 */
> +	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
> +		WARN_ONCE(1,
> +			  "iwlwifi: TX resp notif (sta=%d txq=%d) after FW error\n",
> +			  sta_id, txq_id);
> +		return;
> +	}
> +
>   	if (IWL_FW_CHECK(mld, tx_resp->frame_count != 1,
>   			 "Invalid tx_resp notif frame_count (%d)\n",
>   			 tx_resp->frame_count))
> @@ -1349,6 +1361,13 @@ void iwl_mld_handle_compressed_ba_notif(struct iwl_mld *mld,
>   	u8 sta_id = ba_res->sta_id;
>   	struct ieee80211_link_sta *link_sta;
>   
> +	if (unlikely(test_bit(STATUS_FW_ERROR, &mld->trans->status))) {
> +		WARN_ONCE(1,
> +			  "iwlwifi: BA notif (sta=%d) after FW error\n",
> +			  sta_id);
> +		return;
> +	}
> +
>   	if (!tfd_cnt)
>   		return;
>   
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
> index 619a9505e6d9..ba18d35fa55d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
> @@ -1015,6 +1015,18 @@ static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
>   	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
>   	trans = trans_pcie->trans;
>   
> +	/* Stop processing RX if firmware has crashed. Stale notifications
> +	 * from dying firmware (e.g. TX completions with corrupt SSN values)
> +	 * can cause use-after-free in reclaim paths.
> +	 */
> +	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
> +		WARN_ONCE(1,
> +			  "iwlwifi: NAPI poll[%d] invoked after FW error\n",
> +			  rxq->id);
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>   	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
>   
>   	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n",
> @@ -1042,6 +1054,14 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
>   	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
>   	trans = trans_pcie->trans;
>   
> +	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status))) {
> +		WARN_ONCE(1,
> +			  "iwlwifi: NAPI MSIX poll[%d] invoked after FW error\n",
> +			  rxq->id);
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>   	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
>   	IWL_DEBUG_ISR(trans, "[%d] handled %d, budget %d\n", rxq->id, ret,
>   		      budget);

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



