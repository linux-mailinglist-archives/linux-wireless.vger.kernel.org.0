Return-Path: <linux-wireless+bounces-28942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B227CC5AE33
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 02:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636253B3A70
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 01:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227D1DB95E;
	Fri, 14 Nov 2025 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LqlnER64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3724EEB3
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082988; cv=none; b=Gzk0zNLUiCGmzpQRBo8LOJByu8e0G/rzJ1/0BNgIDDj7O993gRm5b1H0TQLSb+zX/HFNg6XiUnn57UCBuFlTQWa8OWvZJsymS6ILJhZjjJ+DW523A0sspdVsECOUXqVBpJYqlonV4PCOmFStQICDAA2y44YT0lEGsLy6V+oKGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082988; c=relaxed/simple;
	bh=1QIWPEJ7rqK0Bp61G7oNzO9lmtqa9ay/S22z6+MdZAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IY2+EwJ7Vb4kHe8ej8U6I9mcmEDOQnfvawqDTagJnXX9KNbzUOHYO5S+1rtkZTM2ULe+kKRCn54bSDk/ND5jqVvjMtaCgGchThXCTNvEOtzwBc2rRn+EWkSN8ShY3fhnr84KMuJpHdXvRKB1dl4KZx+9oCEHQ6oQBAXervMQwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LqlnER64; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5BBB7C400B9;
	Fri, 14 Nov 2025 01:16:17 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5D9E913C2B3;
	Thu, 13 Nov 2025 17:16:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5D9E913C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1763082970;
	bh=1QIWPEJ7rqK0Bp61G7oNzO9lmtqa9ay/S22z6+MdZAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LqlnER647QtrVQ2XEr6Nen9ZUfSssbesaWWJFPIpLhSzvAhGB6VQdMCANJOwVHMuz
	 LcnyeemDCpIWkY4nB2/WNglslcvLCJghB/oU1asYgCnhPf/LDEAHejLvo9Y9A2yCMo
	 oOyvJ9Xh6CQFzQYWqsCMGU4QkZmmnNC4bJxSIgWE=
Message-ID: <026fd8fc-1871-af93-4622-8d33a6039e47@candelatech.com>
Date: Thu, 13 Nov 2025 17:16:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: mtk7996 lockdep & rcu splat in upstream kernel.
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Felix Fietkau <nbd@nbd.name>
References: <b0218060-3987-ed7d-55f3-43d1978579ea@candelatech.com>
 <aRWdqZAfVPgb-KxY@lore-desk> <aRZp7RYn0p34CVWA@lore-desk>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <aRZp7RYn0p34CVWA@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1763082978-EAogMGNScWuf
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1763082978;EAogMGNScWuf;<greearb@candelatech.com>;d07cbf78db220dce000d227a927b0a59
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/13/25 15:29, Lorenzo Bianconi wrote:
> On Nov 13, Lorenzo Bianconi wrote:
>>> Hello Lorenzo & Felix,
>>
>> Hi Ben,
>>
>>>
>>> With the hack to fix the crash I just posted, the kernel can get far enough to
>>> show this lockdep splat.  I cannot find any code that grabs the wiphy mtx
>>> in this path, and yet if I try to add an explicit mutex_lock lock in the scan code, then
>>> I get kernel deadlocks.  Maybe I'm just putting the lock in the wrong place.
>>>
>>> Any idea how this is supposed to work with regards to wiphy locking?
>>>
>>> And in addition, there is RCU splat immediately after the key.c related
>>> splat.
>>>
>>>     315 Nov 12 10:40:51 ct523c-a0af kernel: ------------[ cut here ]------------
>>>     316 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: CPU: 1 PID: 115 at net/mac80211/key.c:1029 ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
>>>     317 Nov 12 10:40:51 ct523c-a0af kernel: Modules linked in: vrf
>>> nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4
>>> 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core
>>> qrtr bnep snd_hda_codec_intelhdmi intel_rapl_msr snd_hda_codec_hdmi
>>> iTCO_wdt coretemp ee1004 intel_pmc_bxt iTCO_vendor_support intel_rapl_common
>>> snd_hda_codec_alc662 intel_uncore_frequency snd_hda_codec_realtek_lib
>>> intel_uncore_frequency_common snd_hda_codec_generic iwlmld mt7996e
>>> intel_tcc_cooling snd_hda_intel mt76_connac_lib         mt76
>>> x86_pkg_temp_thermal snd_intel_dspcfg snd_hda_codec intel_powerclamp pcspkr
>>> snd_hda_core mac80211 intel_wmi_thunderbolt iwlwifi
>>> snd_hwdep btusb snd_seq btbcm snd_seq_device btmtk btrtl btintel joydev
>>> bluetooth snd_pcm cfg80211 i2c_i801 snd_timer i2c_smbus bfq snd
>>> i2c_mux soundcore intel_pmc_core mei_pxp mei_hdcp intel_pch_thermal
>>> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry
>>> intel_vsec acpi_pad nfsd auth_rpcgss nfs_acl lockd grace nfs_localio
>>> sch_fq_codel sunrpc fuse zram raid1 dm_raid
>>>     318 Nov 12 10:40:51 ct523c-a0af kernel:  raid456 async_raid6_recov
>>> async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy
>>> intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core igb
>>> ttm intel_oc_wdt agpgart i2c_algo_bit ixgbe mdio libie_fwlog dca drm hwmon
>>> mei_wdt i2c_core video wmi [last unloaded: nfnetlink]
>>>     319 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm: kworker/u32:4 Tainted: G S                  6.18.0-rc5+ #25 PREEMPT(full)
>>>     320 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=CPU_OUT_OF_SPEC
>>>     321 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
>>>     322 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work [mt76]
>>>     323 Nov 12 10:40:51 ct523c-a0af kernel: RIP: 0010:ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
>>>     324 Nov 12 10:40:51 ct523c-a0af kernel: Code: 4c 48 83 c4 10 5b 5d 41 5c
>>> 41 5d 41 5e 41 5f c3 48 8b 47 48 be ff ff ff ff 48 8d 78 68 e8 04 ec fe
>>> e0 85 c0 0f 85 49 ff ff ff <0f> 0b 4d 85 ed 0f 85 47 ff ff ff 4c 8b ab 90 1a
>>> 00 00 48 8d 83 90
>>>     325 Nov 12 10:40:51 ct523c-a0af kernel: RSP: 0018:ffffc90000f1fcb0 EFLAGS: 00010246
>>>     326 Nov 12 10:40:51 ct523c-a0af kernel: RAX: 0000000000000000 RBX: ffff888132710ee0 RCX: 0000000000000000
>>>     327 Nov 12 10:40:51 ct523c-a0af kernel: RDX: 0000000000000000 RSI: ffff888132710788 RDI: ffff8881158435c8
>>>     328 Nov 12 10:40:51 ct523c-a0af kernel: RBP: ffffffffa0de5400 R08: 0000000000000001 R09: 00000000f9936176
>>>     329 Nov 12 10:40:51 ct523c-a0af kernel: R10: 0000000000000001 R11: ffff8881158435a0 R12: ffffc90000f1fd00
>>>     330 Nov 12 10:40:51 ct523c-a0af kernel: R13: ffff88811642aa80 R14: ffff88813271afc8 R15: 000000000000043f
>>>     331 Nov 12 10:40:51 ct523c-a0af kernel: FS:  0000000000000000(0000) GS:ffff8884da4c6000(0000) knlGS:0000000000000000
>>>     332 Nov 12 10:40:51 ct523c-a0af kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>     333 Nov 12 10:40:51 ct523c-a0af kernel: CR2: 0000000000422bcc CR3: 0000000002c52004 CR4: 00000000003706f0
>>>     334 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
>>>     335 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
>>>     336 Nov 12 10:40:51 ct523c-a0af kernel:  ? lock_acquire+0xc2/0x2c0
>>>     337 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x66/0x290 [mt7996e]
>>>     338 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x50 [mt76]
>>>     339 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100 [mt76]
>>>     340 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 [mt76]
>>>     341 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
>>>     342 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
>>>     343 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
>>>     344 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
>>>     345 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
>>>     346 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
>>>     347 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
>>>     348 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
>>>     349 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
>>>     350 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
>>>     351 Nov 12 10:40:51 ct523c-a0af kernel: irq event stamp: 27647
>>>     352 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last  enabled at (27653): [<ffffffff813d447e>] __up_console_sem+0x5e/0x70
>>>     353 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last disabled at (27658): [<ffffffff813d4463>] __up_console_sem+0x43/0x70
>>>     354 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last  enabled at (26676): [<ffffffff81f2ad9c>] napi_pp_put_page+0xac/0xd0
>>> 355 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last disabled at (26674): [<ffffffff81fa3230>] page_pool_put_unrefed_netmem+0x290/0x3d0
>>>     356 Nov 12 10:40:51 ct523c-a0af kernel: ---[ end trace 0000000000000000 ]---
>>>     357 Nov 12 10:40:51 ct523c-a0af kernel:
>>>     358 Nov 12 10:40:51 ct523c-a0af kernel: =============================
>>>     359 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: suspicious RCU usage
>>>     360 Nov 12 10:40:51 ct523c-a0af kernel: 6.18.0-rc5+ #25 Tainted: G S      W
>>>     361 Nov 12 10:40:51 ct523c-a0af kernel: -----------------------------
>>>     362 Nov 12 10:40:51 ct523c-a0af kernel: drivers/net/wireless/mediatek/mt76/mt7996/main.c:415 suspicious rcu_dereference_check() usage!
>>>     363 Nov 12 10:40:51 ct523c-a0af kernel:
>>>     364                                     other info that might help us debug this:
>>>     365 Nov 12 10:40:51 ct523c-a0af kernel:
>>>     366                                     rcu_scheduler_active = 2, debug_locks = 1
>>>     367 Nov 12 10:40:51 ct523c-a0af kernel: 2 locks held by kworker/u32:4/115:
>>>     368 Nov 12 10:40:51 ct523c-a0af kernel:  #0: ffff888118ebdd48 ((wq_completion)phy2){+.+.}-{0:0}, at: process_one_work+0x41c/0x6d0
>>>     369 Nov 12 10:40:51 ct523c-a0af kernel:  #1: ffffc90000f1fe38
>>> ((work_completion)(&(&dev->scan_work)->work)){+.+.}-{0:0}, at:
>>> process_one_work+ 0x1e5/0x6d0
>>>     370 Nov 12 10:40:51 ct523c-a0af kernel:
>>>     371                                     stack backtrace:
>>>     372 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm: kworker/u32:4 Tainted: G S      W           6.18.0-rc5+ #25 PREEMPT(full)
>>>     373 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
>>>     374 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
>>>     375 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work [mt76]
>>>     376 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
>>>     377 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
>>>     378 Nov 12 10:40:51 ct523c-a0af kernel:  dump_stack_lvl+0x8d/0xa0
>>>     379 Nov 12 10:40:51 ct523c-a0af kernel:  lockdep_rcu_suspicious+0x146/0x1a0
>>>     380 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x279/0x290 [mt7996e]
>>>     381 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x50 [mt76]
>>>     382 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100 [mt76]
>>>     383 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 [mt76]
>>>     384 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
>>>     385 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
>>>     386 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
>>>     387 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
>>>     388 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
>>>     389 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
>>>     390 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
>>>     391 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
>>>     392 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
>>>     393 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
>>>     394 Nov 12 10:40:54 ct523c-a0af kernel: ixgbe 0000:01:00.0 eth2: NIC Link is Up 10 Gbps, Flow Control: RX/TX
>>>     395 Nov 12 10:40:54 ct523c-a0af kernel: ------------[ cut here ]------------
>>>
>>> Thanks,
>>> Ben
>>
>> I think the problem here is mt76_put_vif_phy_link() runs without grabbing
>> wiphy mutex in mt76_scan_complete() so we cant' run for_each_vif_active_link().
>> I will work on a fix.
>>
>> Regards,
>> Lorenzo
> 
> Hi Ben,
> 
> Can you please try the following patch?
> 
> Regards,
> Lorenzo
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index d30fcedf121f..f63053068e54 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -370,7 +370,8 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
>   
>   	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
>   
> -	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
> +	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED &&
> +	    !mlink->offchannel)
>   		mvif->mt76.deflink_id = link_conf->link_id;
>   
>   	return 0;
> @@ -401,7 +402,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
>   
>   	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
>   
> -	if (mvif->mt76.deflink_id == link_conf->link_id) {
> +	if (mvif->mt76.deflink_id == link_conf->link_id &&
> +	    !mlink->offchannel) {
>   		struct ieee80211_bss_conf *iter;
>   		unsigned int link_id;

Thanks for the patch.

I am still seeing these splats about the key.c logic being called w/out lock, and also
a RCU warning farther below.  This was bringing up a single STA, which did in fact associate
and get DHCP address.  This is a different RCU splat I think.  Possibly first one is fixed.
Previous test was bringing up additional station vdevs though, so this test below was more
gentle.

Nov 13 16:14:37 ct523c-a0af kernel: ------------[ cut here ]------------
Nov 13 16:14:37 ct523c-a0af kernel: WARNING: CPU: 5 PID: 70 at net/mac80211/key.c:1029 ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
Nov 13 16:14:37 ct523c-a0af kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc 
macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr bnep intel_rapl_msr iTCO_wdt coretemp ee1004 intel_rapl_common intel_pmc_bxt iTCO_vendor_support 
snd_hda_codec_intelhdmi intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec_hdmi snd_hda_codec_alc662 snd_hda_codec_realtek_lib 
snd_hda_codec_generic snd_hda_intel mt7996e snd_intel_dspcfg intel_tcc_cooling mt76_connac_lib x86_pkg_temp_thermal snd_hda_codec btusb intel_powerclamp iwlmld 
mt76 btbcm snd_hda_core btmtk pcspkr intel_wmi_thunderbolt btrtl snd_hwdep btintel snd_seq mac80211 iwlwifi snd_seq_device bluetooth joydev snd_pcm i2c_i801 
cfg80211 i2c_smbus bfq i2c_mux snd_timer mei_hdcp snd mei_pxp soundcore intel_pch_thermal intel_pmc_core pmt_telemetry pmt_discovery pmt_class 
intel_pmc_ssram_telemetry intel_vsec acpi_pad nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sch_fq_codel sunrpc fuse zram raid1 dm_raid
Nov 13 16:14:37 ct523c-a0af kernel:  raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib 
drm_display_helper drm_kms_helper cec rc_core igb ttm intel_oc_wdt i2c_algo_bit agpgart ixgbe mdio libie_fwlog dca drm hwmon mei_wdt i2c_core video wmi [last 
unloaded: nfnetlink]
Nov 13 16:14:37 ct523c-a0af kernel: CPU: 5 UID: 0 PID: 70 Comm: kworker/u32:1 Tainted: G S      W           6.18.0-rc5+ #26 PREEMPT(full)
Nov 13 16:14:37 ct523c-a0af kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
Nov 13 16:14:37 ct523c-a0af kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
Nov 13 16:14:37 ct523c-a0af kernel: Workqueue: phy3 mt76_scan_work [mt76]
Nov 13 16:14:37 ct523c-a0af kernel: RIP: 0010:ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
Nov 13 16:14:37 ct523c-a0af kernel: Code: 4c 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 47 48 be ff ff ff ff 48 8d 78 68 e8 b4 eb fe e0 85 c0 0f 85 49 
ff ff ff <0f> 0b 4d 85 ed 0f 85 47 ff ff ff 4c 8b ab 90 1a 00 00 48 8d 83 90
Nov 13 16:14:37 ct523c-a0af kernel: RSP: 0018:ffffc900002e7cb0 EFLAGS: 00010246
Nov 13 16:14:37 ct523c-a0af kernel: RAX: 0000000000000000 RBX: ffff88812d460ee0 RCX: 0000000000000000
Nov 13 16:14:37 ct523c-a0af kernel: RDX: 0000000000000000 RSI: ffff88812d460788 RDI: ffff8881113235c8
Nov 13 16:14:37 ct523c-a0af kernel: RBP: ffffffffa12da400 R08: 0000000000000001 R09: 0000000000000000
Nov 13 16:14:37 ct523c-a0af kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900002e7d00
Nov 13 16:14:37 ct523c-a0af kernel: R13: ffff88812e4eaa80 R14: ffff88812d46afc8 R15: ffff888084863038
Nov 13 16:14:37 ct523c-a0af kernel: FS:  0000000000000000(0000) GS:ffff8884da5c6000(0000) knlGS:0000000000000000
Nov 13 16:14:37 ct523c-a0af kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 13 16:14:37 ct523c-a0af kernel: CR2: 00005564731420a8 CR3: 0000000002c52001 CR4: 00000000003706f0
Nov 13 16:14:37 ct523c-a0af kernel: Call Trace:
Nov 13 16:14:37 ct523c-a0af kernel:  <TASK>
Nov 13 16:14:37 ct523c-a0af kernel:  mt7996_vif_link_remove+0x64/0x2a0 [mt7996e]
Nov 13 16:14:37 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x50 [mt76]
Nov 13 16:14:37 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100 [mt76]
Nov 13 16:14:37 ct523c-a0af kernel:  mt76_scan_work+0x2eb/0x3f0 [mt76]
Nov 13 16:14:37 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
Nov 13 16:14:37 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
Nov 13 16:14:37 ct523c-a0af kernel:  worker_thread+0x19a/0x340
Nov 13 16:14:37 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
Nov 13 16:14:37 ct523c-a0af kernel:  kthread+0x108/0x220
Nov 13 16:14:37 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
Nov 13 16:14:37 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
Nov 13 16:14:37 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0x110
Nov 13 16:14:37 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
Nov 13 16:14:37 ct523c-a0af kernel:  </TASK>
Nov 13 16:14:37 ct523c-a0af kernel: irq event stamp: 153569
Nov 13 16:14:37 ct523c-a0af kernel: hardirqs last  enabled at (153575): [<ffffffff813d447e>] __up_console_sem+0x5e/0x70
Nov 13 16:14:37 ct523c-a0af kernel: hardirqs last disabled at (153580): [<ffffffff813d4463>] __up_console_sem+0x43/0x70
Nov 13 16:14:37 ct523c-a0af kernel: softirqs last  enabled at (152614): [<ffffffff81335ae5>] __irq_exit_rcu+0xa5/0xd0
Nov 13 16:14:37 ct523c-a0af kernel: softirqs last disabled at (152609): [<ffffffff81335ae5>] __irq_exit_rcu+0xa5/0xd0
Nov 13 16:14:37 ct523c-a0af kernel: ---[ end trace 0000000000000000 ]---

[  107.081055] =============================
[  107.081056] WARNING: suspicious RCU usage
[  107.081058] 6.18.0-rc5+ #26 Tainted: G S      W
[  107.081061] -----------------------------
[  107.081062] drivers/net/wireless/mediatek/mt76/mt7996/main.c:1180 suspicious rcu_dereference_protected() usage!
[  107.081064]
                other info that might help us debug this:

[  107.081065]
                rcu_scheduler_active = 2, debug_locks = 1
[  107.081067] 3 locks held by kworker/u32:2/72:
[  107.081069]  #0: ffff888110070948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x41c/0x6d0
[  107.081079]  #1: ffffc900002f7e38 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x1e5/0x6d0
[  107.081086]  #2: ffff88812fdd0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0x41/0x220 [cfg80211]
[  107.081185]
                stack backtrace:
[  107.081188] CPU: 5 UID: 0 PID: 72 Comm: kworker/u32:2 Tainted: G S      W           6.18.0-rc5+ #26 PREEMPT(full)
[  107.081190] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[  107.081191] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
[  107.081192] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[  107.081226] Call Trace:
[  107.081227]  <TASK>
[  107.081229]  dump_stack_lvl+0x8d/0xa0
[  107.081234]  lockdep_rcu_suspicious+0x146/0x1a0
[  107.081240]  mt7996_sta_state+0x3c5/0x5a0 [mt7996e]
[  107.081256]  drv_sta_state+0x11f/0x880 [mac80211]
[  107.081375]  _sta_info_move_state+0x32a/0x6a0 [mac80211]
[  107.081425]  ieee80211_rx_mgmt_assoc_resp+0x835/0x15f0 [mac80211]
[  107.081505]  ? lock_is_held_type+0xa5/0x110
[  107.081512]  ieee80211_iface_work+0x4d1/0x5f0 [mac80211]
[  107.081565]  cfg80211_wiphy_work+0xe3/0x220 [cfg80211]
[  107.081603]  process_one_work+0x221/0x6d0
[  107.081611]  worker_thread+0x19a/0x340
[  107.081613]  ? rescuer_thread+0x450/0x450
[  107.081615]  kthread+0x108/0x220
[  107.081620]  ? kthreads_online_cpu+0x110/0x110
[  107.081623]  ret_from_fork+0x1c6/0x220
[  107.081626]  ? kthreads_online_cpu+0x110/0x110
[  107.081628]  ret_from_fork_asm+0x11/0x20
[  107.081641]  </TASK>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



