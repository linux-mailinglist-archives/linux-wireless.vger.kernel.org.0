Return-Path: <linux-wireless+bounces-4094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC386984F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC80295266
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A513DBBC;
	Tue, 27 Feb 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="XTGB8tXg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30D13A882
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044209; cv=none; b=YgA/Tr7hklEC0hLfYbc7wmc7H5dWWoxcBEWL24eEbRR96pvfYQFhsCAK4R4oTY3d7XssXwpmB1Ijidvl+mYjz4FFo6ykuSTjbOewMvWE6SMyTzMPviAQLYxEKIHxbPsDlYFBYJe/nQ8nNF0eFRD3m4cAofv3XBVJMmwRodKJnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044209; c=relaxed/simple;
	bh=68KB048vSQiQoRCSFS4MCCCBpEMvF0OQOPTA2ZIYLAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bos8+ZZYdvrFdsPIciV9GKGfpmBLP790QrzSaL++RUtl5muB+xZN9CtFg7mo2mRXQUrTHCnqiEmw35HhvXftl7pLmKZVZn2Znsb2EdlPc8MGVWln0rVXvjxAxf8UyPixYcZxWpnbk2dluVHN73mApyS7BhApWauHLTHSSa4CumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=XTGB8tXg; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CDEDBC0007E;
	Tue, 27 Feb 2024 14:29:59 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.112.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2EFAF13C2B0;
	Tue, 27 Feb 2024 06:29:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2EFAF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709044199;
	bh=68KB048vSQiQoRCSFS4MCCCBpEMvF0OQOPTA2ZIYLAI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XTGB8tXgfAwqqWbyKoxsoKBz/oYnMaXg75tVYN5RjM8Hq+eNC+7GnoHVHtlLQ62jO
	 5G3MfeVsGhVfC8vWI4HiSpQZ1WFCZQvbHaqCJtoUrosc/ZixHAc4Epbzszkp0PuA+m
	 lkfw1BbXvwkry9AsINHOAG5lG7RscWzGlEjZDOEo=
Message-ID: <33cc22b8-5852-42ae-9e80-8c3c58c36b6d@candelatech.com>
Date: Tue, 27 Feb 2024 06:29:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
 <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709044200-00eiX04aQteD
X-MDID-O:
 us5;at1;1709044200;00eiX04aQteD;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/27/24 05:47, Johannes Berg wrote:
> 
>> Feb 26 06:01:45 ct523c-0b0b kernel: task:ip              state:D stack:0     pid:28125 tgid:28125 ppid:3604   flags:0x00004002
>> Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
>> Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
>> Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
>> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_timeout+0x19c/0x1b0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  ? mark_held_locks+0x49/0x70
>> Feb 26 06:01:45 ct523c-0b0b kernel:  __wait_for_common+0xba/0x1d0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  ? usleep_range_state+0xb0/0xb0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  remove_one+0x6b/0x100
> 
> Can you say where this remove_one+0x6b is?
> 
> I feel it's probably this:
> 
>         if (!refcount_dec_and_test(&fsd->active_users)) {
>                 wait_for_completion(&fsd->active_users_drained);
> 
> which ... looking at it, seems wrong?
> 
> _Completely_ untested:
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 034a617cb1a5..fb636478c54d 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -751,13 +751,19 @@ static void __debugfs_file_removed(struct dentry *dentry)
>   	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
>   		return;
>   
> -	/* if we hit zero, just wait for all to finish */
> -	if (!refcount_dec_and_test(&fsd->active_users)) {
> -		wait_for_completion(&fsd->active_users_drained);
> -		return;
> -	}
> +	/*
> +	 * Now that debugfs_file_get() no longer sees a valid entry,
> +	 * decrement the refcount to remove the initial reference.
> +	 */
> +	refcount_dec(&fsd->active_users);
>   
> -	/* if we didn't hit zero, try to cancel any we can */
> +	/*
> +	 * As long as it's not zero, try to cancel any cancellations,
> +	 * new incoming ones will wake up the completion as we might
> +	 * have raced: debugfs_file_get() had already been done, but
> +	 * debugfs_enter_cancellation() hadn't, by the time we got
> +	 * to this point here.
> +	 */
>   	while (refcount_read(&fsd->active_users)) {
>   		struct debugfs_cancellation *c;

I see this splat with the patch applied:

[   94.576688] ------------[ cut here ]------------
[   94.576699] refcount_t: decrement hit 0; leaking memory.
[   94.576717] WARNING: CPU: 1 PID: 5686 at lib/refcount.c:31 refcount_warn_saturate+0x42/0xe0
[   94.576724] Modules linked in: nf_conntrack_netlink nfnetlink xt_MASQUERADE iptable_nat nf_nat iptable_raw xt_CT nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
bpfilter vrf 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr iTCO_wdt intel_pmc_bxt ee1004 intel_rapl_msr iTCO_vendor_support 
snd_hda_codec_hdmi mt7915e mt76_connac_lib snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio mt76 coretemp intel_rapl_common mac80211 intel_tcc_cooling 
snd_hda_intel x86_pkg_temp_thermal intel_powerclamp snd_intel_dspcfg snd_hda_codec intel_wmi_thunderbolt cfg80211 snd_hda_core snd_hwdep pl2303 bfq snd_seq 
mei_hdcp mei_pxp snd_seq_device snd_pcm snd_timer i2c_i801 snd intel_pch_thermal soundcore i2c_smbus pcspkr acpi_pad nfsd auth_rpcgss nfs_acl sch_fq_codel lockd 
grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt 
drm_display_helper drm_kms_helper cec igb rc_core i2c_algo_bit ttm drm ixgbe agpgart mdio
[   94.576822]  dca xhci_pci mei_wdt i2c_core xhci_pci_renesas hwmon video wmi [last unloaded: nfnetlink]
[   94.576833] CPU: 1 PID: 5686 Comm: iw Not tainted 6.7.5+ #2
[   94.576836] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
[   94.576838] RIP: 0010:refcount_warn_saturate+0x42/0xe0
[   94.576841] Code: 80 3d 24 70 3b 01 00 0f 84 a0 00 00 00 c3 80 3d 15 70 3b 01 00 75 f6 48 c7 c7 10 a5 66 82 c6 05 05 70 3b 01 01 e8 9e a9 a9 ff <0f> 0b c3 80 
3d f9 6f 3b 01 00 75 d7 48 c7 c7 90 a4 66 82 c6 05 e9
[   94.576843] RSP: 0018:ffffc900063df848 EFLAGS: 00010282
[   94.576846] RAX: 0000000000000000 RBX: ffff88810e752750 RCX: 0000000000000027
[   94.576848] RDX: ffff88845dc5c708 RSI: 0000000000000001 RDI: ffff88845dc5c700
[   94.576850] RBP: ffff88811b8af400 R08: 0000000000000000 R09: ffffc900063df6f0
[   94.576851] R10: 0000000000000003 R11: ffffffff8296a2e8 R12: ffff88811000b1d8
[   94.576853] R13: ffff88810e7dcea0 R14: 0000000000000000 R15: ffff88810e752868
[   94.576855] FS:  00007f31ae1f3b80(0000) GS:ffff88845dc40000(0000) knlGS:0000000000000000
[   94.576857] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.576859] CR2: 00007f0533889a90 CR3: 0000000129c8f003 CR4: 00000000003706f0
[   94.576861] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.576862] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.576864] Call Trace:
[   94.576865]  <TASK>
[   94.576867]  ? refcount_warn_saturate+0x42/0xe0
[   94.576869]  ? __warn+0x7c/0x170
[   94.576873]  ? refcount_warn_saturate+0x42/0xe0
[   94.576877]  ? report_bug+0x169/0x1a0
[   94.576883]  ? handle_bug+0x41/0x70
[   94.576887]  ? exc_invalid_op+0x13/0x60
[   94.576890]  ? asm_exc_invalid_op+0x16/0x20
[   94.576900]  ? refcount_warn_saturate+0x42/0xe0
[   94.576903]  ? refcount_warn_saturate+0x42/0xe0
[   94.576905]  remove_one+0xde/0xf0
[   94.576910]  simple_recursive_removal+0x20c/0x2b0
[   94.576914]  ? start_creating.part.0+0x170/0x170
[   94.576919]  debugfs_remove+0x3b/0x60
[   94.576922]  ieee80211_debugfs_remove_netdev+0x15/0x30 [mac80211]
[   94.576998]  ieee80211_teardown_sdata+0x13/0x50 [mac80211]
[   94.577036]  unregister_netdevice_many_notify+0x3b9/0x7e0
[   94.577045]  unregister_netdevice_queue+0x84/0xc0
[   94.577049]  _cfg80211_unregister_wdev+0x1c5/0x210 [cfg80211]
[   94.577117]  ieee80211_if_remove+0x9b/0x110 [mac80211]
[   94.577166]  ieee80211_del_iface+0xc/0x10 [mac80211]
[   94.577220]  cfg80211_remove_virtual_intf+0x42/0x120 [cfg80211]
[   94.577257]  genl_family_rcv_msg_doit+0xd1/0x120
[   94.577267]  genl_rcv_msg+0x182/0x290
[   94.577270]  ? __cfg80211_wdev_from_attrs+0x2b0/0x2b0 [cfg80211]
[   94.577306]  ? nl80211_stop_ap+0x30/0x30 [cfg80211]
[   94.577341]  ? nlmsg_trim+0x20/0x20 [cfg80211]
[   94.577378]  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
[   94.577383]  netlink_rcv_skb+0x4f/0x100
[   94.577392]  genl_rcv+0x1f/0x30
[   94.577395]  netlink_unicast+0x18e/0x270
[   94.577400]  netlink_sendmsg+0x257/0x4d0
[   94.577406]  __sock_sendmsg+0x33/0x60
[   94.577411]  ____sys_sendmsg+0x22c/0x2a0
[   94.577414]  ? copy_msghdr_from_user+0x68/0xa0
[   94.577420]  ___sys_sendmsg+0x81/0xc0
[   94.577424]  ? __lock_acquire+0x405/0x2380
[   94.577430]  ? __lock_acquire+0x405/0x2380
[   94.577435]  ? reacquire_held_locks+0xd3/0x1f0
[   94.577438]  ? do_user_addr_fault+0x322/0x850
[   94.577443]  ? lock_acquire+0xc6/0x2b0
[   94.577448]  __sys_sendmsg+0x52/0xa0
[   94.577456]  do_syscall_64+0x3b/0x110
[   94.577460]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   94.577464] RIP: 0033:0x7f31adf13737
[   94.577467] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   94.577469] RSP: 002b:00007ffd1e029ae8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   94.577472] RAX: ffffffffffffffda RBX: 0000000000924390 RCX: 00007f31adf13737
[   94.577474] RDX: 0000000000000000 RSI: 00007ffd1e029b40 RDI: 0000000000000004
[   94.577476] RBP: 0000000000929780 R08: 00000000009242a0 R09: 0000000000000000
[   94.577478] R10: 00007f31ae20a3e0 R11: 0000000000000246 R12: 00000000009298c0
[   94.577479] R13: 00007ffd1e029b40 R14: 00007ffd1e029c70 R15: 000000000043d280
[   94.577487]  </TASK>
[   94.577488] irq event stamp: 12053
[   94.577490] hardirqs last  enabled at (12059): [<ffffffff8121af54>] console_unlock+0x114/0x140
[   94.577495] hardirqs last disabled at (12064): [<ffffffff8121af39>] console_unlock+0xf9/0x140
[   94.577497] softirqs last  enabled at (11844): [<ffffffff81188b97>] __irq_exit_rcu+0x77/0xa0
[   94.577500] softirqs last disabled at (11839): [<ffffffff81188b97>] __irq_exit_rcu+0x77/0xa0
[   94.577502] ---[ end trace 0000000000000000 ]---
[  103.657993] workqueue: gc_worker [nf_conntrack] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
[  148.747435] workqueue: gc_worker [nf_conntrack] hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND

Thanks,
Ben

>   
> 
> 
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


