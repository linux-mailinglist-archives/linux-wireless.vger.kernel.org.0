Return-Path: <linux-wireless+bounces-32228-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AAiI0GkoGk9lQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32228-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:51:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A31AEB44
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E042300517C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD131D390;
	Thu, 26 Feb 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="F0n45tMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84C43E9FB
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135482; cv=none; b=YcveyjE+Iv0Ej46gHXm8jru+lx7hsRx+EyTEWMT32nR6YGVvcHH8/cp3mdOravNiUHREftj71CfdvPIuAihSF2ZiqslCTGpauhFnRBduJY34dv2/VkKMJSOmlLhFOuc6FQU+sCnNNN+qlWfJwxvhPfRDeBM9cJ2hiRNhe3WIzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135482; c=relaxed/simple;
	bh=pfiGeRuyQmkkMcOrhGCvYxnTEznr3YDSOVULVhG/8hA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=G4pVokax9jz1jjzlCbn5qRtL6YmD9PFvgJ+DbXlOEsFzY4SmdRTbqJQ8K4k81t8mJZrhXDjj+cTcpRAoAPuWQmDtO7ttiDVRRN2XYbApuFRMzrrSy6G60h4p9ndjF40h1ZrQg+fLpB5Y8GXryvHzDhaC41GLwGM3Mxq6CBy+xoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=F0n45tMo; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 86557C0084;
	Thu, 26 Feb 2026 19:51:12 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0B34C13C2B0;
	Thu, 26 Feb 2026 11:51:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0B34C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772135470;
	bh=pfiGeRuyQmkkMcOrhGCvYxnTEznr3YDSOVULVhG/8hA=;
	h=Date:To:Cc:From:Subject:From;
	b=F0n45tMo1b/qlRmIeLyBDH8ItmfDDBfU4VGcXzvAF3vhnBlkVLUsMY4b0coUECIPf
	 M430YyiUV7oUloNx/ZY3P4pC/vud9H2hCv+W2y1//tQ8Pxy+zhSvQABezHBMUUjd2G
	 nU6BpeSDzm0HoRt2hKorJ4LCrf2ecYOQMNWes48E=
Message-ID: <d0962498-2e21-336f-55ef-bcba33c5274e@candelatech.com>
Date: Thu, 26 Feb 2026 11:51:09 -0800
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
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi + mac80211: Force success in case of EIO in dis-assoc path?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772135473-pvb3IiXgGndf
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772135473;pvb3IiXgGndf;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32228-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: 061A31AEB44
X-Rspamd-Action: no action

Hello,

It looks like the radios in my system had some serious problem for one reason or another
and stopped responding, and it hit a warning of interest up in mac80211, in this code:

	if (new_state < sta->sta_state &&
	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
		int err = drv_sta_state(sta->local, sta->sdata, sta,
					sta->sta_state, new_state);

		WARN_ONCE(err,
			  "Driver is not allowed to fail if the sta_state is transitioning down the list: %d\n",
			  err);
	}

So in case the driver is trying to do drv_sta_state, and it runs into -EIO.  If we are going 'down the list',
should we force driver to ignore the EIO error and return success?


I think this is the pertinent set of logs related to this failure (several radios were failing
concurrently I believe, so possibly some logs are jumbled).

Feb 26 11:09:56 ct523c-de7c kernel: ------------[ cut here ]------------
Feb 26 11:09:56 ct523c-de7c kernel: bad state = 0
Feb 26 11:09:56 ct523c-de7c kernel: WARNING: CPU: 1 PID: 111503 at drivers/net/wireless/intel/iwlwifi/iwl-trans.c:312 iwl_trans_send_cmd+0x2ad/0x330 [iwlwifi]
Feb 26 11:09:56 ct523c-de7c kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc 
macvlan pktgen rfcomm rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp 
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec_intelhdmi snd_hda_codec_hdmi intel_tcc_cooling x86_pkg_temp_thermal 
snd_hda_codec_alc662 snd_hda_codec_realtek_lib intel_powerclamp intel_wmi_thunderbolt snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec 
mac80211 snd_hda_core snd_hwdep snd_seq btusb btbcm snd_seq_device btmtk btrtl btintel snd_pcm iwlwifi bluetooth snd_timer cfg80211 i2c_i801 snd i2c_smbus 
soundcore i2c_mux mei_pxp mei_hdcp intel_pch_thermal intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq nfsd 
sch_fq_codel auth_rpcgss nfs_acl lockd grace nfs_localio fuse sunrpc raid1 dm_raid raid456 async_raid6_recov async_memcpy async_pq
Feb 26 11:09:56 ct523c-de7c kernel:  async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core ttm 
agpgart ixgbe mdio igb libie_fwlog i2c_algo_bit dca drm hwmon mei_wdt i2c_core intel_oc_wdt video wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath [last 
unloaded: nfnetlink]
Feb 26 11:09:56 ct523c-de7c kernel: CPU: 1 UID: 0 PID: 111503 Comm: kworker/1:0 Kdump: loaded Tainted: G        W           6.18.9+ #18 PREEMPT(full)
Feb 26 11:09:56 ct523c-de7c kernel: Tainted: [W]=WARN
Feb 26 11:09:56 ct523c-de7c kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Feb 26 11:09:56 ct523c-de7c kernel: Workqueue: events_freezable ieee80211_restart_work [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: RIP: 0010:iwl_trans_send_cmd+0x2ad/0x330 [iwlwifi]
Feb 26 11:09:56 ct523c-de7c kernel: Code: bd 7c ff ff ff e9 08 ff ff ff 80 3d 8c ba dc ff 00 0f 85 30 ff ff ff 48 c7 c7 00 8c 1a a2 c6 05 78 ba dc ff 01 e8 b3 
bd 0a df <0f> 0b e9 16 ff ff ff 4c 89 e7 e8 14 50 9b df e9 7e fd ff ff e8 0a
Feb 26 11:09:56 ct523c-de7c kernel: RSP: 0018:ffff8881f7e96ea8 EFLAGS: 00010282
Feb 26 11:09:56 ct523c-de7c kernel: RAX: 0000000000000000 RBX: ffff888132504028 RCX: 0000000000000001
Feb 26 11:09:56 ct523c-de7c kernel: RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88841daa4e48
Feb 26 11:09:56 ct523c-de7c kernel: RBP: ffff8881f7e96fb0 R08: 0000000000000001 R09: ffffed1083b549c9
Feb 26 11:09:56 ct523c-de7c kernel: R10: ffff88841daa4e4b R11: 000000000007bfe8 R12: ffff8881f7e96fd4
Feb 26 11:09:56 ct523c-de7c kernel: R13: ffff888132504090 R14: ffff88815aec7a68 R15: ffff88815aec5508
Feb 26 11:09:56 ct523c-de7c kernel: FS:  0000000000000000(0000) GS:ffff8884973c7000(0000) knlGS:0000000000000000
Feb 26 11:09:56 ct523c-de7c kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 26 11:09:56 ct523c-de7c kernel: CR2: 0000557cd9657138 CR3: 0000000128903001 CR4: 00000000003706f0
Feb 26 11:09:56 ct523c-de7c kernel: Call Trace:
Feb 26 11:09:56 ct523c-de7c kernel:  <TASK>
Feb 26 11:09:56 ct523c-de7c kernel:  iwl_mld_sync_rx_queues+0x297/0x6e0 [iwlmld]
Feb 26 11:09:56 ct523c-de7c kernel:  ? mark_held_locks+0x49/0x70
Feb 26 11:09:56 ct523c-de7c kernel:  ? iwl_mld_rx_mpdu+0x4100/0x4100 [iwlmld]
Feb 26 11:09:56 ct523c-de7c kernel:  ? do_raw_spin_lock+0x12c/0x270
Feb 26 11:09:56 ct523c-de7c kernel:  ? spin_bug+0x1d0/0x1d0
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  __sta_info_destroy_part1+0x252/0x12c0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  __sta_info_flush+0x2e1/0x610 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? __sta_info_destroy+0x30/0x30 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? ieee80211_bss_info_change_notify+0x53/0x650 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ieee80211_set_disassoc+0x14fb/0x1c10 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? ieee80211_prep_channel+0x12b0/0x12b0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ieee80211_mgd_deauth+0x526/0x1780 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_irq_usage+0xb5/0xa20
Feb 26 11:09:56 ct523c-de7c kernel:  ? ieee80211_mgd_assoc+0x5be0/0x5be0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_path.constprop.0+0x24/0x50
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_noncircular+0x7e/0x140
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_mlme_deauth+0x333/0x7a0 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? prb_final_commit+0x40/0x40
Feb 26 11:09:56 ct523c-de7c kernel:  ? cfg80211_mlme_assoc+0x960/0x960 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_mlme_down+0x16f/0x230 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? cfg80211_mlme_disassoc+0x450/0x450 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? kfree+0x2ae/0x580
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_disconnect+0x4d2/0x700 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_netdev_notifier_call+0x661/0x10a0 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? __lock_acquire+0x432/0x23b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? cfg80211_register_netdevice+0x2a0/0x2a0 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? __lock_acquire+0x432/0x23b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? __bfs+0x12e/0x220
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_irq_usage+0xb5/0xa20
Feb 26 11:09:56 ct523c-de7c kernel:  ? __bfs+0x12e/0x220
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_irq_usage+0xb5/0xa20
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_path.constprop.0+0x24/0x50
Feb 26 11:09:56 ct523c-de7c kernel:  ? __bfs+0x12e/0x220
Feb 26 11:09:56 ct523c-de7c kernel:  ? __lock_acquire+0x432/0x23b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_acquire+0x155/0x2e0
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_notifier+0xd3/0xa70
Feb 26 11:09:56 ct523c-de7c kernel:  ? find_held_lock+0x2b/0x80
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_notifier+0x1f0/0xa70
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_release+0xce/0x290
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_notifier+0x1fa/0xa70
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_getname_spkt+0x290/0x290
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  notifier_call_chain+0x97/0x280
Feb 26 11:09:56 ct523c-de7c kernel:  __dev_close_many+0xe8/0x670
Feb 26 11:09:56 ct523c-de7c kernel:  ? netdev_notify_peers+0x20/0x20
Feb 26 11:09:56 ct523c-de7c kernel:  netif_close_many+0x1e6/0x5c0
Feb 26 11:09:56 ct523c-de7c kernel:  ? preempt_schedule+0x4c/0x70
Feb 26 11:09:56 ct523c-de7c kernel:  ? __dev_close_many+0x670/0x670
Feb 26 11:09:56 ct523c-de7c kernel:  ? wake_up_q+0xaf/0x130
Feb 26 11:09:56 ct523c-de7c kernel:  netif_close+0x141/0x1d0
Feb 26 11:09:56 ct523c-de7c kernel:  ? netif_close_many+0x5c0/0x5c0
Feb 26 11:09:56 ct523c-de7c kernel:  dev_close+0x89/0x1f0
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  process_one_work+0x83f/0x17b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? pwq_dec_nr_in_flight+0xe00/0xe00
Feb 26 11:09:56 ct523c-de7c kernel:  ? assign_work+0x168/0x240
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  worker_thread+0x58c/0xfb0
Feb 26 11:09:56 ct523c-de7c kernel:  ? __kthread_parkme+0xc6/0x1f0
Feb 26 11:09:56 ct523c-de7c kernel:  ? rescuer_thread+0xca0/0xca0
Feb 26 11:09:56 ct523c-de7c kernel:  kthread+0x3b7/0x770
Feb 26 11:09:56 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:56 ct523c-de7c kernel:  ? ret_from_fork+0x17/0x3a0
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_release+0xce/0x290
Feb 26 11:09:56 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:56 ct523c-de7c kernel:  ret_from_fork+0x28b/0x3a0
Feb 26 11:09:56 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:56 ct523c-de7c kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 11:09:56 ct523c-de7c kernel:  </TASK>
Feb 26 11:09:56 ct523c-de7c kernel: irq event stamp: 1825193
Feb 26 11:09:56 ct523c-de7c kernel: hardirqs last  enabled at (1825199): [<ffffffff816116ee>] __up_console_sem+0x5e/0x70
Feb 26 11:09:56 ct523c-de7c kernel: hardirqs last disabled at (1825204): [<ffffffff816116d3>] __up_console_sem+0x43/0x70
Feb 26 11:09:56 ct523c-de7c kernel: softirqs last  enabled at (1823870): [<ffffffffa2661752>] __ieee80211_stop_tx_ba_session+0x6b2/0x780 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: softirqs last disabled at (1823868): [<ffffffffa26611cd>] __ieee80211_stop_tx_ba_session+0x12d/0x780 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: ---[ end trace 0000000000000000 ]---
Feb 26 11:09:56 ct523c-de7c kernel: iwlwifi 0000:28:00.0: Failed to trigger RX queues sync (-5)
Feb 26 11:09:56 ct523c-de7c kernel: ------------[ cut here ]------------
Feb 26 11:09:56 ct523c-de7c kernel: Driver is not allowed to fail if the sta_state is transitioning down the list: -5
Feb 26 11:09:56 ct523c-de7c kernel: WARNING: CPU: 1 PID: 111503 at net/mac80211/sta_info.c:1564 _sta_info_move_state+0x2a5/0x1420 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc 
macvlan pktgen rfcomm rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support iwlmld coretemp 
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec_intelhdmi snd_hda_codec_hdmi intel_tcc_cooling x86_pkg_temp_thermal 
snd_hda_codec_alc662 snd_hda_codec_realtek_lib intel_powerclamp intel_wmi_thunderbolt snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec 
mac80211 snd_hda_core snd_hwdep snd_seq btusb btbcm snd_seq_device btmtk btrtl btintel snd_pcm iwlwifi bluetooth snd_timer cfg80211 i2c_i801 snd i2c_smbus 
soundcore i2c_mux mei_pxp mei_hdcp intel_pch_thermal intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq nfsd 
sch_fq_codel auth_rpcgss nfs_acl lockd grace nfs_localio fuse sunrpc raid1 dm_raid raid456 async_raid6_recov async_memcpy async_pq
Feb 26 11:09:56 ct523c-de7c kernel:  async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core ttm 
agpgart ixgbe mdio igb libie_fwlog i2c_algo_bit dca drm hwmon mei_wdt i2c_core intel_oc_wdt video wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath [last 
unloaded: nfnetlink]
Feb 26 11:09:56 ct523c-de7c kernel: CPU: 1 UID: 0 PID: 111503 Comm: kworker/1:0 Kdump: loaded Tainted: G        W           6.18.9+ #18 PREEMPT(full)
Feb 26 11:09:56 ct523c-de7c kernel: Tainted: [W]=WARN
Feb 26 11:09:56 ct523c-de7c kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Feb 26 11:09:56 ct523c-de7c kernel: Workqueue: events_freezable ieee80211_restart_work [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: RIP: 0010:_sta_info_move_state+0x2a5/0x1420 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: Code: 85 c0 0f 84 cf 01 00 00 80 3d 0f 7c f1 ff 00 0f 85 c2 01 00 00 89 c6 48 c7 c7 80 bd a0 a2 c6 05 f9 7b f1 ff 01 e8 7b 
59 e3 de <0f> 0b e9 a6 01 00 00 41 83 fd 04 0f 85 ce 02 00 00 83 fa 03 0f 85
Feb 26 11:09:56 ct523c-de7c kernel: RSP: 0018:ffff8881f7e97030 EFLAGS: 00010282
Feb 26 11:09:56 ct523c-de7c kernel: RAX: 0000000000000000 RBX: ffff8881377e0188 RCX: 0000000000000001
Feb 26 11:09:56 ct523c-de7c kernel: RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88841daa4e48
Feb 26 11:09:56 ct523c-de7c kernel: RBP: ffff8881377e0058 R08: 0000000000000001 R09: ffffed1083b549c9
Feb 26 11:09:56 ct523c-de7c kernel: R10: ffff88841daa4e4b R11: 000000000007dc78 R12: ffff8881377e0050
Feb 26 11:09:56 ct523c-de7c kernel: R13: 0000000000000003 R14: ffff8881377e0180 R15: ffff8881377e0000
Feb 26 11:09:56 ct523c-de7c kernel: FS:  0000000000000000(0000) GS:ffff8884973c7000(0000) knlGS:0000000000000000
Feb 26 11:09:56 ct523c-de7c kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 26 11:09:56 ct523c-de7c kernel: CR2: 0000557cd9657138 CR3: 000000000509a002 CR4: 00000000003706f0
Feb 26 11:09:56 ct523c-de7c kernel: Call Trace:
Feb 26 11:09:56 ct523c-de7c kernel:  <TASK>
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  __sta_info_destroy_part2+0x3e2/0x4a0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  __sta_info_flush+0x409/0x610 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? __sta_info_destroy+0x30/0x30 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? ieee80211_bss_info_change_notify+0x53/0x650 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ieee80211_set_disassoc+0x14fb/0x1c10 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? ieee80211_prep_channel+0x12b0/0x12b0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ieee80211_mgd_deauth+0x526/0x1780 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_irq_usage+0xb5/0xa20
Feb 26 11:09:56 ct523c-de7c kernel:  ? ieee80211_mgd_assoc+0x5be0/0x5be0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_path.constprop.0+0x24/0x50
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_noncircular+0x7e/0x140
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_mlme_deauth+0x333/0x7a0 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? prb_final_commit+0x40/0x40
Feb 26 11:09:56 ct523c-de7c kernel:  ? cfg80211_mlme_assoc+0x960/0x960 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_mlme_down+0x16f/0x230 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? cfg80211_mlme_disassoc+0x450/0x450 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? kfree+0x2ae/0x580
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_disconnect+0x4d2/0x700 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_netdev_notifier_call+0x661/0x10a0 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? __lock_acquire+0x432/0x23b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? cfg80211_register_netdevice+0x2a0/0x2a0 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ? __lock_acquire+0x432/0x23b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? __bfs+0x12e/0x220
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_irq_usage+0xb5/0xa20
Feb 26 11:09:56 ct523c-de7c kernel:  ? __bfs+0x12e/0x220
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_irq_usage+0xb5/0xa20
Feb 26 11:09:56 ct523c-de7c kernel:  ? check_path.constprop.0+0x24/0x50
Feb 26 11:09:56 ct523c-de7c kernel:  ? __bfs+0x12e/0x220
Feb 26 11:09:56 ct523c-de7c kernel:  ? __lock_acquire+0x432/0x23b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_acquire+0x155/0x2e0
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_notifier+0xd3/0xa70
Feb 26 11:09:56 ct523c-de7c kernel:  ? find_held_lock+0x2b/0x80
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_notifier+0x1f0/0xa70
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_release+0xce/0x290
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_notifier+0x1fa/0xa70
Feb 26 11:09:56 ct523c-de7c kernel:  ? packet_getname_spkt+0x290/0x290
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  notifier_call_chain+0x97/0x280
Feb 26 11:09:56 ct523c-de7c kernel:  __dev_close_many+0xe8/0x670
Feb 26 11:09:56 ct523c-de7c kernel:  ? netdev_notify_peers+0x20/0x20
Feb 26 11:09:56 ct523c-de7c kernel:  netif_close_many+0x1e6/0x5c0
Feb 26 11:09:56 ct523c-de7c kernel:  ? preempt_schedule+0x4c/0x70
Feb 26 11:09:56 ct523c-de7c kernel:  ? __dev_close_many+0x670/0x670
Feb 26 11:09:56 ct523c-de7c kernel:  ? wake_up_q+0xaf/0x130
Feb 26 11:09:56 ct523c-de7c kernel:  netif_close+0x141/0x1d0
Feb 26 11:09:56 ct523c-de7c kernel:  ? netif_close_many+0x5c0/0x5c0
Feb 26 11:09:56 ct523c-de7c kernel:  dev_close+0x89/0x1f0
Feb 26 11:09:56 ct523c-de7c kernel:  cfg80211_shutdown_all_interfaces+0x76/0x190 [cfg80211]
Feb 26 11:09:56 ct523c-de7c kernel:  ieee80211_restart_work+0x2c8/0x3c0 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel:  process_one_work+0x83f/0x17b0
Feb 26 11:09:56 ct523c-de7c kernel:  ? pwq_dec_nr_in_flight+0xe00/0xe00
Feb 26 11:09:56 ct523c-de7c kernel:  ? assign_work+0x168/0x240
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_is_held_type+0xa5/0x110
Feb 26 11:09:56 ct523c-de7c kernel:  worker_thread+0x58c/0xfb0
Feb 26 11:09:56 ct523c-de7c kernel:  ? __kthread_parkme+0xc6/0x1f0
Feb 26 11:09:56 ct523c-de7c kernel:  ? rescuer_thread+0xca0/0xca0
Feb 26 11:09:56 ct523c-de7c kernel:  kthread+0x3b7/0x770
Feb 26 11:09:56 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:56 ct523c-de7c kernel:  ? ret_from_fork+0x17/0x3a0
Feb 26 11:09:56 ct523c-de7c kernel:  ? lock_release+0xce/0x290
Feb 26 11:09:56 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:56 ct523c-de7c kernel:  ret_from_fork+0x28b/0x3a0
Feb 26 11:09:56 ct523c-de7c kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Feb 26 11:09:56 ct523c-de7c kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 11:09:56 ct523c-de7c kernel:  </TASK>
Feb 26 11:09:56 ct523c-de7c kernel: irq event stamp: 1826775
Feb 26 11:09:56 ct523c-de7c kernel: hardirqs last  enabled at (1826781): [<ffffffff816116ee>] __up_console_sem+0x5e/0x70
Feb 26 11:09:56 ct523c-de7c kernel: hardirqs last disabled at (1826786): [<ffffffff816116d3>] __up_console_sem+0x43/0x70
Feb 26 11:09:56 ct523c-de7c kernel: softirqs last  enabled at (1825488): [<ffffffffa26fa978>] ieee80211_clear_fast_rx+0x58/0x80 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: softirqs last disabled at (1825486): [<ffffffffa26fa93b>] ieee80211_clear_fast_rx+0x1b/0x80 [mac80211]
Feb 26 11:09:56 ct523c-de7c kernel: ---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


